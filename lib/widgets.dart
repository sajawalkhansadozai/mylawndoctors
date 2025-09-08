import 'dart:async'; // for auto-play timer
import 'package:flutter/material.dart';
import 'theme.dart';

/* --------------------------- Typography utils --------------------------- */

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle? style;
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          gradient.createShader(Offset.zero & bounds.size),
      child: Text(
        text,
        style: (style ?? const TextStyle()).copyWith(color: Colors.white),
      ),
    );
  }
}

class GradientLeafLogo extends StatelessWidget {
  final double size;
  const GradientLeafLogo({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: kBrandGradient,
        borderRadius: BorderRadius.circular(size),
      ),
      child: const Center(child: Text('🌿', style: TextStyle(fontSize: 16))),
    );
  }
}

class NavChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const NavChip({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(colors: [kGreen, kGreenDark])
              : null,
          color: isActive ? null : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0x1A4CAF50)),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: kGreen.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: isActive ? Colors.white : const Color(0xFF333333),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = width > 900 ? 36.0 : (width > 600 ? 30.0 : 24.0);
    return GradientText(
      text,
      gradient: const LinearGradient(colors: [kForest, kGreen]),
      style: TextStyle(fontSize: size, fontWeight: FontWeight.w800),
    );
  }
}

/* ------------------------------ ShellSection ------------------------------ */

const double _shellHPad = 20;
const double _shellVPad = 28;

/// Centers content, adds responsive page padding, and constrains max width.
class ShellSection extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  const ShellSection({super.key, required this.child, this.maxWidth = 1200});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _shellHPad,
          vertical: _shellVPad,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}

/* ------------------------ Gradient hero (optional) ----------------------- */

class HeroBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> actions;
  const HeroBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double heroHeight = (size.height * 0.52).clamp(320.0, 520.0);
    heroHeight = heroHeight.roundToDouble();
    final isWide = size.width > 900;
    final titleSize = isWide ? 42.0 : (size.width > 600 ? 36.0 : 28.0);
    final subtitleSize = size.width > 600 ? 16.0 : 14.0;
    return Container(
      height: heroHeight,
      decoration: const BoxDecoration(gradient: kHeroGradient),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.08,
                child: CustomPaint(painter: _GrassPainter()),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w800,
                        shadows: const [
                          Shadow(
                            blurRadius: 6,
                            offset: Offset(0, 2),
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: subtitleSize,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: actions,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ------------- Photo-only, auto-sliding hero (now more flexible) -------- */

class HeroBannerSlider extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Widget> actions;
  final List<ImageProvider> images;

  /// If provided, overrides automatic height computation.
  final double? height;

  /// If provided (and [height] is null), height becomes
  ///   screenWidth / aspectRatio  (clamped 360..720)
  /// Use this with BoxFit.contain to show the full image without cropping.
  final double? aspectRatio;

  /// How to fit the image. Use BoxFit.contain to avoid cropping.
  final BoxFit imageFit;

  /// Where to align the image inside.
  final Alignment imageAlignment;

  final Duration autoPlayInterval;

  const HeroBannerSlider({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actions,
    required this.images,
    this.height,
    this.aspectRatio,
    this.imageFit = BoxFit.cover,
    this.imageAlignment = Alignment.center,
    this.autoPlayInterval = const Duration(seconds: 4),
  });

  @override
  State<HeroBannerSlider> createState() => _HeroBannerSliderState();
}

class _HeroBannerSliderState extends State<HeroBannerSlider> {
  late final PageController _controller;
  int _index = 0;
  Timer? _timer;

  void _start() {
    _timer?.cancel();
    if (widget.images.length > 1) {
      _timer = Timer.periodic(widget.autoPlayInterval, (_) {
        if (!mounted) return;
        final next = (_index + 1) % widget.images.length;
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _stop() => _timer?.cancel();

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _start();
  }

  @override
  void dispose() {
    _stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Decide banner height
    double heroHeight;
    if (widget.height != null) {
      heroHeight = widget.height!;
    } else if (widget.aspectRatio != null) {
      heroHeight = (size.width / widget.aspectRatio!).clamp(360.0, 720.0);
    } else {
      heroHeight = (size.height * 0.52).clamp(320.0, 520.0);
    }
    heroHeight = heroHeight.roundToDouble(); // avoid sub-pixel blur

    // Responsive text sizes
    final isWide = size.width > 900;
    final titleSize = isWide ? 42.0 : (size.width > 600 ? 36.0 : 28.0);
    final subtitleSize = size.width > 600 ? 16.0 : 14.0;

    return MouseRegion(
      onEnter: (_) => _stop(), // pause on hover (web)
      onExit: (_) => _start(),
      child: SizedBox(
        height: heroHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Photos
            PageView.builder(
              controller: _controller,
              onPageChanged: (i) => setState(() => _index = i),
              itemCount: widget.images.length,
              itemBuilder: (_, i) {
                return SizedBox.expand(
                  child: Image(
                    image: widget.images[i],
                    fit: widget.imageFit,
                    alignment: widget.imageAlignment,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                  ),
                );
              },
            ),

            // Content
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: titleSize,
                          fontWeight: FontWeight.w800,
                          shadows: const [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 12,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        widget.subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: subtitleSize,
                          height: 1.6,
                          shadows: const [
                            Shadow(
                              color: Colors.black45,
                              blurRadius: 8,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 12,
                        children: widget.actions,
                      ),
                      const SizedBox(height: 18),

                      // Dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(widget.images.length, (i) {
                          final active = i == _index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: active ? 22 : 8,
                            decoration: BoxDecoration(
                              color: active ? Colors.white : Colors.white70,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ------------------------------- Buttons ------------------------------- */

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const PrimaryButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [kGreen, kGreenDark]),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: kGreen.withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const SecondaryButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white30, width: 2),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

/* -------------------------------- Cards -------------------------------- */

class CardShell extends StatelessWidget {
  final Widget child;
  final bool borderLeft;
  const CardShell({super.key, required this.child, this.borderLeft = false});

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.of(context).size.width < 400;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      padding: EdgeInsets.all(compact ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0x1A4CAF50)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      foregroundDecoration: borderLeft
          ? const BoxDecoration(
              border: Border(left: BorderSide(color: kGreen, width: 5)),
            )
          : null,
      child: child,
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String body;
  final String price;
  const ServiceCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.body,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CircleIcon(emoji: emoji),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: kForest,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(color: Color(0xFF666666), height: 1.6),
          ),
          const Divider(height: 28),
          Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.w800, color: kGreen),
          ),
        ],
      ),
    );
  }
}

/* ---------------------- UPDATED: Compact PlantCard ---------------------- */

class PlantCard extends StatelessWidget {
  final String emoji;
  final String title;
  final List<String> bullets;
  final String desc;

  /// When true, the card uses tighter spacing & smaller banner.
  final bool compact;

  /// Optionally override the banner height (defaults: 160 / 110).
  final double? bannerHeight;

  const PlantCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.bullets,
    required this.desc,
    this.compact = false,
    this.bannerHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double bh = bannerHeight ?? (compact ? 110 : 160);
    final double titleSize = compact ? 16 : 18;
    final double emojiSize = compact ? 38 : 44;
    final double gap1 = compact ? 10 : 14;
    final double gap2 = compact ? 6 : 8;
    const baseStyle = TextStyle(color: Color(0xFF666666));
    final bulletStyle = baseStyle.copyWith(fontSize: compact ? 13 : null);

    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: bh,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [kGreen, kGreenDark]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(emoji, style: TextStyle(fontSize: emojiSize)),
            ),
          ),
          SizedBox(height: gap1),
          Text(
            title,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.w800,
              color: kForest,
            ),
          ),
          SizedBox(height: gap2),
          Text(desc, style: bulletStyle),
          SizedBox(height: gap2),
          ...bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  const Text('🌿 '),
                  const SizedBox(width: 6),
                  Expanded(child: Text(b, style: bulletStyle)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String body;
  const InfoCard({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return CardShell(
      borderLeft: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: kForest,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(color: Color(0xFF666666), height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final String emoji;
  const _CircleIcon({required this.emoji});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [kGreen, kGreenDark]),
        shape: BoxShape.circle,
      ),
      child: Center(child: Text(emoji, style: const TextStyle(fontSize: 28))),
    );
  }
}

/* -------------------------------- Footer ------------------------------- */

class Footer extends StatelessWidget {
  const Footer({super.key});

  Widget _col(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: kGreen,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [kForest, kBlue]),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  spacing: 24,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      width: 260,
                      child: _col('Lawn Doctor', const [
                        Text(
                          'Your trusted partner for premium lawn care and landscaping services. '
                          'We keep your outdoor space beautiful, healthy, and always guest-ready.',
                          style: TextStyle(color: Colors.white70, height: 1.6),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Licensed • Bonded • Insured',
                          style: TextStyle(
                            color: kGreen,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      width: 200,
                      child: _col('Quick Links', const [
                        Text(
                          'Our Services',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Plant Selection',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Book Service',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Contact Us',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ]),
                    ),
                    // UPDATED CONTACT INFO
                    SizedBox(
                      width: 240,
                      child: _col('Contact Information', const [
                        Text(
                          '📞 +923335554059',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          '📞 +923345173764',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          '📧 bookings@mylawndoctors.com',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          '📍 Serving Your Metro Area',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ]),
                    ),
                    SizedBox(
                      width: 220,
                      child: _col('Service Hours', const [
                        Text(
                          'Mon–Fri  7:00–18:00',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Saturday 8:00–16:00',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Sunday   Emergency Only',
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Free estimates available!',
                          style: TextStyle(color: kGreen),
                        ),
                      ]),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: kGreen),
                const SizedBox(height: 8),
                const Text(
                  '© 2025 My Lawn Doctor. All rights reserved.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ------------------------------ Painters ------------------------------ */

class _GrassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.06);
    for (double x = 0; x < size.width; x += 40) {
      final path = Path();
      path.moveTo(x + 20, size.height);
      path.quadraticBezierTo(x + 10, size.height * 0.5, x + 20, 0);
      path.quadraticBezierTo(x + 30, size.height * 0.5, x + 20, size.height);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
