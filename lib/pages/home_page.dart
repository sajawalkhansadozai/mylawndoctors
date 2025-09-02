// ignore_for_file: unused_element_parameter
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme.dart';
import '../widgets.dart';

class HomePage extends StatelessWidget {
  final void Function(String) onNavigate;
  const HomePage({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // ==== HERO (actions are responsive & won’t overflow) ====
        HeroBannerSlider(
          title: 'Transform Your Lawn Into Paradise',
          subtitle:
              'We supply and install the finest selection of plants, flowers, and trees, chosen to thrive in your climate. '
              'Our specialists ensure every installation matches your space and budget.',
          actions: [
            _HeroActions(
              onPrimary: () => onNavigate('services'),
              onSecondary: () => onNavigate('services'),
            ),
          ],
          images: const [
            AssetImage('assets/hero1.jpg'),
            AssetImage('assets/hero2.jpg'),
            AssetImage('assets/hero3.jpg'),
          ],
        ),

        // ==== PREMIUM PLANTS (overflow-proof grid) ====
        ShellSection(
          child: Column(
            children: [
              const SectionTitle('Premium Plant Selection'),
              const SizedBox(height: 12),
              const Text(
                'Expertly chosen plants that thrive in your environment',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF666666)),
              ),
              const SizedBox(height: 22),
              LayoutBuilder(
                builder: (context, c) {
                  final maxW = c.maxWidth;
                  final cols = maxW > 1150 ? 3 : (maxW > 900 ? 2 : 1);
                  const gap = 22.0;

                  final cellWidth = (maxW - (cols - 1) * gap) / cols;
                  final targetHeight = cols == 1
                      ? 460.0
                      : (cols == 2 ? 430.0 : 410.0);
                  final aspect = cellWidth / targetHeight;

                  return GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      crossAxisSpacing: gap,
                      mainAxisSpacing: gap,
                      childAspectRatio: aspect,
                    ),
                    children: const [
                      PlantCard(
                        emoji: '🌺',
                        title: 'Seasonal Flowers',
                        desc: 'Vibrant blooms for year-round color and beauty.',
                        bullets: [
                          'Spring bulbs and perennials',
                          'Summer annuals and tropicals',
                          'Fall mums and ornamental cabbage',
                          'Winter evergreen arrangements',
                        ],
                      ),
                      PlantCard(
                        emoji: '🌿',
                        title: 'Ornamental Plants',
                        desc:
                            'Decorative plants adding sophistication to garden.',
                        bullets: [
                          'Hostas and ferns for shade',
                          'Ornamental grasses',
                          'Decorative foliage plants',
                          'Architectural specimens',
                        ],
                      ),
                      PlantCard(
                        emoji: '🌳',
                        title: 'Trees & Shrubs',
                        desc: 'Structure, privacy, and year-round appeal.',
                        bullets: [
                          'Shade and ornamental trees',
                          'Privacy and flowering shrubs',
                          'Palms and tropicals',
                          'Fruit trees and edibles',
                        ],
                      ),
                      PlantCard(
                        emoji: '🌾',
                        title: 'Premium Turf',
                        desc: 'High-quality grass varieties for your use case.',
                        bullets: [
                          'Drought-resistant options',
                          'High-traffic tolerant grass',
                          'Shade-adapted species',
                          'Low-maintenance choices',
                        ],
                      ),
                      PlantCard(
                        emoji: '🌵',
                        title: 'Succulents & Cacti',
                        desc: 'Low-water plants with bold forms and texture.',
                        bullets: [
                          'Perfect for sunny spots',
                          'Minimal maintenance',
                          'Great in containers',
                          'Year-round structure',
                        ],
                      ),
                      PlantCard(
                        emoji: '🍓',
                        title: 'Herbs & Edibles',
                        desc: 'Grow fresh flavors right in your garden.',
                        bullets: [
                          'Culinary herbs & veggies',
                          'Compact fruit varieties',
                          'Pollinator-friendly choices',
                          'Easy-care raised beds',
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // ==== REVIEWS (overflow-proof grid & adaptive image height) ====
        ShellSection(
          child: Column(
            children: [
              const SectionTitle('What Our Customers Say'),
              const SizedBox(height: 12),
              const Text(
                'Real reviews from happy customers across Pakistan',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF666666)),
              ),
              const SizedBox(height: 18),
              LayoutBuilder(
                builder: (context, c) {
                  final maxW = c.maxWidth;
                  final cols = maxW > 1150 ? 3 : (maxW > 750 ? 2 : 1);
                  const gap = 22.0;
                  final cellWidth = (maxW - (cols - 1) * gap) / cols;
                  final targetHeight = cols == 1
                      ? 420.0
                      : (cols == 2 ? 380.0 : 360.0);
                  final aspect = cellWidth / targetHeight;

                  return GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      crossAxisSpacing: gap,
                      mainAxisSpacing: gap,
                      childAspectRatio: aspect,
                    ),
                    children: const [
                      _ReviewCard(
                        avatar: AssetImage('assets/aisha.jpg'),
                        gardenImage: AssetImage('assets/garden1.jpg'),
                        name: 'Aisha Khan',
                        location: 'Islamabad F-6',
                        review:
                            'Beautiful plant selection and very professional team. My garden looks alive again!',
                      ),
                      _ReviewCard(
                        avatar: AssetImage('assets/muhammad.jpg'),
                        gardenImage: AssetImage('assets/garden2.jpg'),
                        name: 'Muhammad Ahmed',
                        location: 'Islamabad F-7',
                        review:
                            'On-time service and a neat finish. Highly recommend Lawn Doctor for turf work.',
                      ),
                      _ReviewCard(
                        avatar: AssetImage('assets/fatima.jpg'),
                        gardenImage: AssetImage('assets/garden3.jpg'),
                        name: 'Fatima Zahra',
                        location: 'Islamabad F-10',
                        review:
                            'They suggested the right plants for shade and installed everything perfectly.',
                      ),
                      _ReviewCard(
                        avatar: AssetImage('assets/ali.jpg'),
                        gardenImage: AssetImage('assets/garden4.jpg'),
                        name: 'Ali Raza',
                        location: 'Islamabad E-11',
                        review:
                            'Great communication, fair pricing, and excellent results. Five stars from me!',
                      ),
                      _ReviewCard(
                        avatar: AssetImage('assets/zainab.jpg'),
                        gardenImage: AssetImage('assets/garden5.jpg'),
                        name: 'Zainab Malik',
                        location: 'Islamabad G-6',
                        review:
                            'Loved the seasonal flowers. The team was courteous and fast.',
                      ),
                      _ReviewCard(
                        avatar: AssetImage('assets/omar.jpg'),
                        gardenImage: AssetImage('assets/garden6.jpg'),
                        name: 'Omar Farooq',
                        location: 'Islamabad F-8',
                        review:
                            'Quality turf and clean installation. My lawn has never looked better.',
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // ==== CONTACT ====
        ShellSection(
          child: Column(
            children: const [
              Text(
                'Get In Touch',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: kForest,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Ready to transform your lawn? Let’s discuss your project',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF666666)),
              ),
            ],
          ),
        ),

        // Contact form + info
        const _HomeContactSection(),

        const Footer(),
      ],
    );
  }
}

/* -------------------- HERO: mobile-safe actions -------------------- */

class _HeroActions extends StatelessWidget {
  final VoidCallback onPrimary;
  final VoidCallback onSecondary;
  const _HeroActions({required this.onPrimary, required this.onSecondary});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isNarrow = w < 520;

    // Wrap prevents overflow; vertical on very small widths
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 10,
        direction: isNarrow ? Axis.vertical : Axis.horizontal,
        children: [
          PrimaryButton(label: 'Book Service Now', onTap: onPrimary),
          SecondaryButton(label: 'Explore Services', onTap: onSecondary),
        ],
      ),
    );
  }
}

/* -------------- Contact section: mobile-safe (no Expanded on mobile) -------------- */

class _HomeContactSection extends StatelessWidget {
  const _HomeContactSection();

  @override
  Widget build(BuildContext context) {
    return ShellSection(
      child: LayoutBuilder(
        builder: (context, c) {
          final twoCol = c.maxWidth > 920;

          // Wide: Row with Expanded. Narrow: plain Column (NO Expanded).
          if (twoCol) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: _ContactFormCard()),
                SizedBox(width: 24),
                Expanded(child: _ContactInfoColumn()),
              ],
            );
          } else {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ContactFormCard(),
                SizedBox(height: 24),
                _ContactInfoColumn(),
              ],
            );
          }
        },
      ),
    );
  }
}

class _ContactInfoColumn extends StatelessWidget {
  const _ContactInfoColumn();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        InfoCard(
          title: '📞 Phone & Email',
          body:
              'Main Line: (555) 123-LAWN\nEmergency: (555) 123-9999\nEmail: info@lawndoctor.com',
        ),
        SizedBox(height: 16),
        InfoCard(
          title: '📍 Service Area',
          body:
              'We proudly serve the entire metropolitan area and surrounding communities within a 50-mile radius.',
        ),
        SizedBox(height: 16),
        InfoCard(
          title: '🕒 Business Hours',
          body:
              'Mon–Fri: 7:00 AM – 6:00 PM\nSaturday: 8:00 AM – 4:00 PM\nSunday: Emergency Services Only',
        ),
        SizedBox(height: 16),
        InfoCard(
          title: '⚡ Emergency Services',
          body:
              'Storm cleanup, irrigation repairs, and urgent lawn needs. 24/7 for existing customers.',
        ),
      ],
    );
  }
}

class _ContactFormCard extends StatefulWidget {
  const _ContactFormCard();

  @override
  State<_ContactFormCard> createState() => _ContactFormCardState();
}

class _ContactFormCardState extends State<_ContactFormCard> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  String? _subject;
  final _message = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _sending = true);

    try {
      await FirebaseFirestore.instance.collection('contactMessages').add({
        'name': _name.text.trim(),
        'email': _email.text.trim(),
        'phone': _phone.text.trim(),
        'subject': _subject,
        'message': _message.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => const _SuccessDialog(
          title: 'Message Sent',
          message:
              'Thanks for reaching out! We’ll get back to you within 24 hours.',
        ),
      );

      _formKey.currentState!.reset();
      _name.clear();
      _email.clear();
      _phone.clear();
      _message.clear();
      setState(() => _subject = null);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade600,
          content: Text('Failed to send. Please try again. ($e)'),
        ),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Send Us a Message',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: kForest,
            ),
          ),
          const SizedBox(height: 18),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Full Name *'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                    labelText: 'Email Address *',
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Required';
                    final ok = RegExp(
                      r'^[^@]+@[^@]+\.[^@]+$',
                    ).hasMatch(v.trim());
                    return ok ? null : 'Enter a valid email';
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number *',
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  value: _subject,
                  items: const [
                    DropdownMenuItem(
                      value: 'quote',
                      child: Text('Request a Quote'),
                    ),
                    DropdownMenuItem(
                      value: 'question',
                      child: Text('General Question'),
                    ),
                    DropdownMenuItem(
                      value: 'complaint',
                      child: Text('Service Issue'),
                    ),
                    DropdownMenuItem(
                      value: 'compliment',
                      child: Text('Compliment'),
                    ),
                    DropdownMenuItem(value: 'other', child: Text('Other')),
                  ],
                  decoration: const InputDecoration(labelText: 'Subject *'),
                  onChanged: (v) => setState(() => _subject = v),
                  validator: (v) =>
                      v == null ? 'Please select a subject' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _message,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Message *',
                    hintText: 'Tell us how we can help you...',
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _sending ? null : _submit,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: kGreen,
                    ),
                    child: Text(
                      _sending ? 'Sending…' : 'Send Message',
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------------- Shared small widgets (local) ------------------- */

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
            const Icon(Icons.check_circle, color: kGreen, size: 72),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kForest,
                fontSize: 20,
                fontWeight: FontWeight.w800,
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

/* ----------------------- PRIVATE: Review Card ----------------------- */

class _ReviewCard extends StatelessWidget {
  final ImageProvider avatar;
  final ImageProvider gardenImage;
  final String name;
  final String location;
  final String review;
  final int stars;

  const _ReviewCard({
    required this.avatar,
    required this.gardenImage,
    required this.name,
    required this.location,
    required this.review,
    this.stars = 5,
  });

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: LayoutBuilder(
        builder: (context, c) {
          // Slightly smaller image on very narrow cards to prevent overflow
          final imgH = c.maxWidth < 360 ? 120.0 : 140.0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 26, backgroundImage: avatar),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: kForest,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          location,
                          style: const TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  image: gardenImage,
                  height: imgH,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: List.generate(
                  stars,
                  (_) => const Padding(
                    padding: EdgeInsets.only(right: 2),
                    child: Icon(Icons.star, size: 16, color: Colors.amber),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                review,
                style: const TextStyle(color: Color(0xFF555555), height: 1.6),
              ),
            ],
          );
        },
      ),
    );
  }
}
