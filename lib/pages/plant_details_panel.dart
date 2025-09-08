// lib/pages/plant_details_panel.dart
// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lawndoctor/pages/plants_page.dart'; // Plant model
import '../theme.dart';
import '../widgets.dart';

class PlantDetailsPage extends StatefulWidget {
  final Plant plant;
  const PlantDetailsPage({super.key, required this.plant});

  @override
  State<PlantDetailsPage> createState() => _PlantDetailsPageState();
}

class _PlantDetailsPageState extends State<PlantDetailsPage> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _buyNow() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _BuyDialog(plant: widget.plant),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.plant;
    final specs = _specsFor(p.name);
    final isMobile = MediaQuery.of(context).size.width < 700;

    // Ensure we always have something to show
    final List<String> imgs =
        (p.images.isNotEmpty
                ? p.images
                : [p.coverImage].where((e) => e.trim().isNotEmpty).toList())
            .take(12) // guard against super long arrays
            .toList();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            ShellSection(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row
                  Row(
                    children: [
                      SecondaryButton(
                        label: '← Back to Plants',
                        onTap: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      _PricePill(price: p.price),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // ==== SQUARE GALLERY + THUMBS (network/asset safe) ====
                  LayoutBuilder(
                    builder: (context, c) {
                      final double side =
                          (c.maxWidth * (isMobile ? 0.86 : 0.55)).clamp(
                            220.0,
                            520.0,
                          );

                      return Column(
                        children: [
                          // Main square
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: side,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: imgs.isEmpty
                                      ? Container(
                                          color: const Color(0xFFEFEFEF),
                                          child: const Center(
                                            child: Icon(Icons.broken_image),
                                          ),
                                        )
                                      : PageView.builder(
                                          controller: _controller,
                                          onPageChanged: (i) =>
                                              setState(() => _index = i),
                                          itemCount: imgs.length,
                                          itemBuilder: (_, i) => _SmartImage(
                                            src: imgs[i],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Thumbnails
                          if (imgs.length > 1)
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: isMobile ? 52 : 56,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 2,
                                  ),
                                  itemCount: imgs.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 8),
                                  itemBuilder: (_, i) {
                                    final active = i == _index;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() => _index = i);
                                        _controller.animateToPage(
                                          i,
                                          duration: const Duration(
                                            milliseconds: 280,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 160,
                                        ),
                                        width: isMobile ? 52 : 56,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: active
                                                ? kGreen
                                                : const Color(0x22000000),
                                            width: active ? 2 : 1,
                                          ),
                                          boxShadow: active
                                              ? const [
                                                  BoxShadow(
                                                    color: Color(0x14000000),
                                                    blurRadius: 8,
                                                    offset: Offset(0, 4),
                                                  ),
                                                ]
                                              : null,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: _SmartImage(
                                            src: imgs[i],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 18),
                  // Name + description
                  Text(
                    p.name,
                    style: TextStyle(
                      fontSize: isMobile ? 22 : 24,
                      fontWeight: FontWeight.w800,
                      color: kForest,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    p.longDesc,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: const Color(0xFF555555),
                      height: 1.7,
                      fontSize: isMobile ? 13.6 : 14,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Quick specs
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _InfoPill(
                        icon: Icons.wb_sunny_outlined,
                        label: specs.sun,
                      ),
                      _InfoPill(
                        icon: Icons.opacity_outlined,
                        label: specs.water,
                      ),
                      _InfoPill(
                        icon: Icons.place_outlined,
                        label: specs.placement,
                      ),
                      _InfoPill(
                        icon: Icons.handyman_outlined,
                        label: specs.care,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Highlights
                  CardShell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        _SectionTitle('Why You’ll Love It'),
                        SizedBox(height: 10),
                        _Highlight('Nursery-grown, pest-checked, and healthy'),
                        _Highlight('Packed and delivered with plant-safe care'),
                        _Highlight('Free basic planting guidance included'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Care tips accordion
                  CardShell(
                    child: Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: Column(
                        children: const [
                          _SectionTitle('Care & Tips'),
                          SizedBox(height: 6),
                          _TipTile(
                            title: 'Light',
                            body:
                                'Place where it receives the recommended light shown above. If leaves pale or stretch, increase brightness.',
                          ),
                          _TipTile(
                            title: 'Water',
                            body:
                                'Water thoroughly when the top inch feels dry. Ensure excellent drainage—never let it sit in water.',
                          ),
                          _TipTile(
                            title: 'Feeding',
                            body:
                                'Use a balanced liquid fertilizer at half strength during active growth (spring–summer).',
                          ),
                          _TipTile(
                            title: 'Pruning & Grooming',
                            body:
                                'Remove spent flowers or yellowing leaves to keep the plant tidy and encourage new growth.',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Delivery / warranty info
                  CardShell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        _SectionTitle('Delivery & Assurance'),
                        SizedBox(height: 8),
                        Text(
                          'We deliver across the city with careful, plant-friendly packing. '
                          'If your plant arrives in less than great condition, let us know within 48 hours—'
                          'we’ll make it right.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Color(0xFF555555),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // CTAs
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      PrimaryButton(label: 'Buy Now', onTap: _buyNow),
                      SecondaryButton(
                        label: 'Back to Plants',
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _Specs _specsFor(String name) {
    final n = name.toLowerCase();
    if (n.contains('palm') || n.contains('hibiscus') || n.contains('bougain')) {
      return const _Specs(
        sun: 'Full Sun / Bright',
        water: 'Moderate',
        placement: 'Outdoor / Patio',
        care: 'Low–Medium',
      );
    }
    if (n.contains('snake') ||
        n.contains('sansevieria') ||
        n.contains('aloe') ||
        n.contains('succulent')) {
      return const _Specs(
        sun: 'Bright / Tolerates Low',
        water: 'Low',
        placement: 'Indoor or Balcony',
        care: 'Very Low',
      );
    }
    if (n.contains('ficus') || n.contains('rubber') || n.contains('dracaena')) {
      return const _Specs(
        sun: 'Bright Indirect',
        water: 'Moderate',
        placement: 'Indoor',
        care: 'Low–Medium',
      );
    }
    if (n.contains('lavender') ||
        n.contains('olive') ||
        n.contains('cypress') ||
        n.contains('juniper')) {
      return const _Specs(
        sun: 'Full Sun',
        water: 'Low–Moderate',
        placement: 'Outdoor',
        care: 'Low',
      );
    }
    if (n.contains('rose') ||
        n.contains('hydrangea') ||
        n.contains('azalea') ||
        n.contains('camellia')) {
      return const _Specs(
        sun: 'Sun / Part Shade',
        water: 'Regular',
        placement: 'Outdoor Garden',
        care: 'Medium',
      );
    }
    if (n.contains('jasmine') ||
        n.contains('ixora') ||
        n.contains('marigold') ||
        n.contains('petunia')) {
      return const _Specs(
        sun: 'Full Sun',
        water: 'Moderate',
        placement: 'Outdoor / Planters',
        care: 'Low',
      );
    }
    if (n.contains('lemon') ||
        n.contains('mango') ||
        n.contains('guava') ||
        n.contains('neem')) {
      return const _Specs(
        sun: 'Full Sun',
        water: 'Regular (young)',
        placement: 'Outdoor Ground / Large Pot',
        care: 'Low–Medium',
      );
    }
    return const _Specs(
      sun: 'Bright Light',
      water: 'Moderate',
      placement: 'Indoor / Outdoor',
      care: 'Low',
    );
  }
}

/* ============================ SMALL WIDGETS ============================ */

class _PricePill extends StatelessWidget {
  final String price;
  const _PricePill({required this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FFFB),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x1A4CAF50)),
      ),
      child: Text(
        price,
        style: const TextStyle(color: kGreen, fontWeight: FontWeight.w800),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoPill({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x22000000)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: kForest),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Color(0xFF333333))),
        ],
      ),
    );
  }
}

class _Highlight extends StatelessWidget {
  final String text;
  const _Highlight(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [kGreen, kGreenDark]),
            ),
            child: const Center(
              child: Text(
                '✓',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Color(0xFF444444), height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: kForest,
      ),
    );
  }
}

class _TipTile extends StatelessWidget {
  final String title;
  final String body;
  const _TipTile({required this.title, required this.body});
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(top: 6, bottom: 6),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w800, color: kForest),
      ),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            body,
            textAlign: TextAlign.justify,
            style: const TextStyle(color: Color(0xFF555555), height: 1.6),
          ),
        ),
      ],
    );
  }
}

/* =============================== MODELS =============================== */

class _Specs {
  final String sun;
  final String water;
  final String placement;
  final String care;
  const _Specs({
    required this.sun,
    required this.water,
    required this.placement,
    required this.care,
  });
}

/* ------------------------------- BUY DIALOG ----------------------------- */

class _BuyDialog extends StatefulWidget {
  final Plant plant;
  const _BuyDialog({required this.plant});

  @override
  State<_BuyDialog> createState() => _BuyDialogState();
}

class _BuyDialogState extends State<_BuyDialog> {
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _address = TextEditingController();
  final _city = TextEditingController();
  final _phone = TextEditingController();
  int _qty = 1;
  bool _saving = false;

  @override
  void dispose() {
    _fullName.dispose();
    _address.dispose();
    _city.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_saving) return;

    setState(() => _saving = true);
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'plantId': widget.plant.id,
        'plantName': widget.plant.name,
        'price': widget.plant.price,
        'quantity': _qty,
        'customerName': _fullName.text.trim(),
        'address': _address.text.trim(),
        'city': _city.text.trim(),
        'phone': _phone.text.trim(),
        'status': 'new',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) Navigator.of(context).pop();
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) => const _SuccessDialog(
            title: '✅ Order Received',
            message:
                'Thank you! Our team will contact you shortly to confirm your order and delivery schedule.',
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not place order: $e'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Buy Now',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: kForest,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: widget.plant.name,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Plant / Tree'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      'Quantity: ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: 8),
                    _QtyPicker(
                      value: _qty,
                      onChanged: (v) => setState(() => _qty = v),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _fullName,
                        decoration: const InputDecoration(
                          labelText: 'Full Name *',
                        ),
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _address,
                        decoration: const InputDecoration(
                          labelText: 'House Address *',
                        ),
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _city,
                        decoration: const InputDecoration(labelText: 'City *'),
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number *',
                        ),
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _saving ? null : _submit,
                          style: FilledButton.styleFrom(
                            backgroundColor: kGreen,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: _saving
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    valueColor: AlwaysStoppedAnimation(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Place Order',
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QtyPicker extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  const _QtyPicker({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x22000000)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QtyBtn(
            icon: Icons.remove,
            onTap: value > 1 ? () => onChanged(value - 1) : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '$value',
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          _QtyBtn(icon: Icons.add, onTap: () => onChanged(value + 1)),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _QtyBtn({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Icon(
          icon,
          size: 18,
          color: enabled ? kForest : const Color(0x33000000),
        ),
      ),
    );
  }
}

/* ----------------------- REUSABLE SUCCESS DIALOG ----------------------- */

class _SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  const _SuccessDialog({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 520,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 24,
              offset: Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: kGreen, size: 60),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kGreen,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'We appreciate your order!',
              style: TextStyle(
                color: Color(0xFF444444),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF555555), height: 1.6),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(
                backgroundColor: kGreen,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Close',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );  
  }
}
/* ============================ SMART IMAGE ============================ */

/// Network + Cloudinary optimizer (adds f_auto,q_auto,dpr_auto).
/// Falls back to asset images if `src` isn't a URL.
class _SmartImage extends StatelessWidget {
  final String src;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const _SmartImage({required this.src, this.height, this.width, this.fit});

  bool get _isNetwork =>
      src.startsWith('http://') || src.startsWith('https://');

  bool get _isCloudinary =>
      src.contains('res.cloudinary.com') && src.contains('/image/upload/');

  String _withCloudinaryOptimizations(String url) {
    if (url.contains('/image/upload/') && url.contains('f_auto')) return url;
    const marker = '/image/upload/';
    final i = url.indexOf(marker);
    if (i == -1) return url;
    final before = url.substring(0, i + marker.length);
    final after = url.substring(i + marker.length);
    return '$before'
        'f_auto,q_auto,dpr_auto/'
        '$after';
  }

  @override
  Widget build(BuildContext context) {
    if (src.isEmpty) {
      return Container(
        height: height,
        width: width,
        color: const Color(0xFFEFEFEF),
        child: const Center(child: Icon(Icons.broken_image)),
      );
    }

    if (_isNetwork) {
      final url = _isCloudinary ? _withCloudinaryOptimizations(src) : src;
      return Image.network(
        url,
        height: height,
        width: width,
        fit: fit,
        filterQuality: FilterQuality.high,
        errorBuilder: (_, __, ___) => Container(
          height: height,
          width: width,
          color: const Color(0xFFEFEFEF),
          child: const Center(child: Icon(Icons.broken_image)),
        ),
      );
    }

    // Fallback: asset
    return Image.asset(
      src,
      height: height,
      width: width,
      fit: fit,
      filterQuality: FilterQuality.high,
      errorBuilder: (_, __, ___) => Container(
        height: height,
        width: width,
        color: const Color(0xFFEFEFEF),
        child: const Center(child: Icon(Icons.broken_image)),
      ),
    );
  }
}
