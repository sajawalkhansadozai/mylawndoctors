// ignore_for_file: unused_element_parameter
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme.dart';
import '../widgets.dart';

/// Merged: Home + Services content in ONE page.
/// NOTE: Catalog cards are removed.
/// UPDATE: Hero buttons scroll to “Service Plans & Pricing”.
/// UPDATE: Plans replaced with 6 frequency-based rate cards (Daily, Weekly, Bi-Weekly, Monthly, Seasonal Only, One-Time).
/// UPDATE: Booking form frequency dropdown now includes “Daily Service”.

class HomePage extends StatefulWidget {
  final void Function(String) onNavigate; // kept for compatibility (unused)
  const HomePage({super.key, required this.onNavigate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Anchors
  final _servicesKey = GlobalKey();
  final _plansKey = GlobalKey(); // plans/pricing anchor
  final _bookingKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToPlans() => _scrollTo(_plansKey);
  void _scrollToBooking() => _scrollTo(_bookingKey);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // ==== HERO (both buttons -> Plans & Pricing) ====
        HeroBannerSlider(
          title: 'Transform Your Lawn Into Paradise',
          subtitle:
              'From bare ground to lush green, we build new lawns engineered for your soil and climate. '
              'Our specialists keep them pristine with seasonal maintenance, repairs, edging, and ongoing health checks.',
          actions: [
            _HeroActions(
              onPrimary: _scrollToPlans,
              onSecondary: _scrollToPlans,
            ),
          ],
          images: const [
            AssetImage('assets/hero1.jpg'),
            AssetImage('assets/hero2.jpg'),
            AssetImage('assets/hero3.jpg'),
          ],
        ),

        // ==== SERVICES (intro text) ====
        KeyedSubtree(
          key: _servicesKey,
          child: Column(
            children: [
              ShellSection(
                child: Column(
                  children: const [
                    Text(
                      'Our Premium Services',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: kForest,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Comprehensive lawn care solutions tailored to your needs',
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Color(0xFF666666)),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'From one-time clean-ups to dependable weekly and monthly plans, our certified team brings the right tools, '
                      'eco-friendly practices, and on-time professionalism to every visit—so your lawn looks sharp and stays healthy all year.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Color(0xFF666666), height: 1.6),
                    ),
                  ],
                ),
              ),

              ShellSection(
                child: Column(
                  children: const [
                    Text(
                      'At Lawn Doctor, we provide complete lawn care designed to keep your outdoor space healthy, beautiful, and perfectly maintained. '
                      'Our professional team uses premium equipment and proven techniques to deliver exceptional results.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Color(0xFF666666)),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'We match plant varieties and turf care to your local microclimate, monitor soil health, and fine-tune irrigation to reduce waste. '
                      'Expect clear communication, tidy clean-ups, and a 100% satisfaction promise on every job.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Color(0xFF666666), height: 1.6),
                    ),
                  ],
                ),
              ),

              // === WHAT'S INCLUDED EVERY VISIT ===
              ShellSection(
                child: CardShell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'What’s Included in Every Visit',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: kForest,
                        ),
                      ),
                      SizedBox(height: 10),
                      _Bullet('Sharp, even mowing and edging'),
                      _Bullet('Weed spot-treatments and debris removal'),
                      _Bullet('Clean blow-down of hard surfaces'),
                      _Bullet('Health check for turf, soil, and irrigation'),
                      _Bullet('Before/after photos on request'),
                    ],
                  ),
                ),
              ),

              // === PLANS & PRICING (6 RATE CARDS) ===
              KeyedSubtree(
                key: _plansKey,
                child: ShellSection(
                  child: Column(
                    children: [
                      const SectionTitle('Service Plans & Pricing'),
                      const SizedBox(height: 14),
                      LayoutBuilder(
                        builder: (context, c) {
                          final cross = c.maxWidth > 1050
                              ? 3
                              : (c.maxWidth > 700 ? 2 : 1);
                          return GridView.count(
                            crossAxisCount: cross,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 22,
                            crossAxisSpacing: 22,
                            children: [
                              // 1) Daily Service — FIRST
                              _PlanCard(
                                name: 'Daily Service',
                                price: 'PKR 2,000 / day',
                                desc:
                                    'One visit every day to keep your lawn flawless.',
                                features: const [
                                  'Daily mowing/edging',
                                  'Spot weeding & cleanup',
                                  'Health check each visit',
                                ],
                                onSelect: _scrollToBooking,
                                best: true,
                              ),
                              // 2) Weekly
                              _PlanCard(
                                name: 'Weekly Service',
                                price: 'PKR 15,000 / week',
                                desc:
                                    '1× visit every week. Simple, dependable upkeep.',
                                features: const [
                                  'Trim, edge & tidy',
                                  'Weed spot treatment',
                                  'Before/after on request',
                                ],
                                onSelect: _scrollToBooking,
                              ),
                              // 3) Bi-Weekly
                              _PlanCard(
                                name: 'Bi-Weekly Service',
                                price: 'PKR 7,000 / week',
                                desc:
                                    'Every 2 weeks for low-growth or budget lawns.',
                                features: const [
                                  'Full cut & edge',
                                  'Debris removal',
                                  'Irrigation glance-over',
                                ],
                                onSelect: _scrollToBooking,
                              ),
                              // 4) Monthly
                              _PlanCard(
                                name: 'Monthly Service',
                                price: 'PKR 60,000 / month',
                                desc:
                                    'Caretaker-style coverage built for daily attention.',
                                features: const [
                                  'Includes daily visits',
                                  'Priority response',
                                  'Pro-grade equipment',
                                ],
                                onSelect: _scrollToBooking,
                              ),
                              // 5) Seasonal Only
                              _PlanCard(
                                name: 'Bi-Monthly Service',
                                price: 'PKR 30,000 / month',
                                desc:
                                    'Spring/Fall cleanups and seasonal color refresh.',
                                features: const [
                                  'One-time seasonal makeover',
                                  'Flower/color installs',
                                  'Soil & turf tune-up',
                                ],
                                onSelect: _scrollToBooking,
                              ),
                              // 6) One-Time
                              _PlanCard(
                                name: 'One-Time Service',
                                price: 'From PKR 2,000 / job',
                                desc:
                                    'Perfect for events, move-ins, or quick spruce-ups.',
                                features: const [
                                  'Single scheduled visit',
                                  'Neat finish guaranteed',
                                  'Add-ons available',
                                ],
                                onSelect: _scrollToBooking,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // === FAQs ===
              ShellSection(
                child: Column(
                  children: const [
                    SectionTitle('Frequently Asked Questions'),
                    SizedBox(height: 12),
                    _FAQItem(
                      q: 'How soon can you start?',
                      a: 'Most bookings are confirmed within 24 hours. Start dates depend on crew availability and your preferences.',
                    ),
                    SizedBox(height: 10),
                    _FAQItem(
                      q: 'Do you offer one-time service?',
                      a: 'Yes. We can do a one-time clean-up or makeover. Many clients switch to a recurring plan afterward.',
                    ),
                    SizedBox(height: 10),
                    _FAQItem(
                      q: 'What if I’m not satisfied?',
                      a: 'We offer a 100% satisfaction promise. Tell us within 48 hours and we’ll make it right.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // === BOOKING (simple heading) ===
              ShellSection(
                child: Column(
                  children: const [
                    Text(
                      'Schedule Your Service',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: kForest,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tell us a few details and we’ll confirm your booking within 24 hours',
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Color(0xFF666666)),
                    ),
                  ],
                ),
              ),

              // Booking section (anchor)
              KeyedSubtree(key: _bookingKey, child: const _BookingSection()),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // ==== PREMIUM PLANTS (unchanged) ====
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

        // ==== REVIEWS (unchanged) ====
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

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 10,
        direction: isNarrow ? Axis.vertical : Axis.horizontal,
        children: [
          PrimaryButton(label: 'Maintain Existing Lawn', onTap: onPrimary),
          SecondaryButton(label: 'Develope New Lawn', onTap: onSecondary),
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
              'Phone 1: +92 333 5554059\nPhone 2: +92 334 5173764\nEmail: bookings@mylawndoctors.com',
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
        'message': _message.text.trim(), // FIXED
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
                    if (v == null || v.trim().isEmpty)
                      return 'Required'; // FIXED
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

/* -------------------------- Services: Booking ------------------------- */

class _BookingSection extends StatelessWidget {
  const _BookingSection();

  @override
  Widget build(BuildContext context) {
    return ShellSection(
      maxWidth: 1100,
      child: LayoutBuilder(
        builder: (context, c) {
          final twoCol = c.maxWidth > 920;

          if (twoCol) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: _BookingFormCard()),
                SizedBox(width: 24),
                Expanded(child: _BookingInfoCard()),
              ],
            );
          }

          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BookingFormCard(),
              SizedBox(height: 24),
              _BookingInfoCard(),
            ],
          );
        },
      ),
    );
  }
}

class _BookingInfoCard extends StatelessWidget {
  const _BookingInfoCard();

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'What Happens Next?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: kForest,
            ),
          ),
          SizedBox(height: 12),
          _Bullet('We’ll contact you within 24 hours'),
          _Bullet('Free on-site consultation and estimate'),
          _Bullet('Customized service plan for your needs'),
          _Bullet('Transparent, upfront pricing'),
          _Bullet('Flexible scheduling around your life'),
          _Bullet('Professional, uniformed team'),
          _Bullet('High-quality equipment and materials'),
          _Bullet('Guaranteed neat, thorough finish'),
          _Bullet('Follow-up to ensure satisfaction'),
          _Bullet('Ongoing support and maintenance'),
          SizedBox(height: 16),
          _OfferCard(),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [kGreen, kGreenDark]),
              shape: BoxShape.circle,
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
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(color: Color(0xFF333333))),
          ),
        ],
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF0F8F0), Color(0xFFE8F5E8)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0x1A4CAF50)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💰 Special Offer',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: kForest,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Get 20% off your first service when you book a monthly maintenance plan. '
            'Limited time offer for new customers!',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Color(0xFF555555),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/* ------------------------------ PLAN CARD ------------------------------ */
class _PlanCard extends StatelessWidget {
  final String name;
  final String price;
  final String desc;
  final List<String> features;
  final VoidCallback onSelect;
  final bool best;

  const _PlanCard({
    required this.name,
    required this.price,
    required this.desc,
    required this.features,
    required this.onSelect,
    this.best = false,
  });

  @override
  Widget build(BuildContext context) {
    return CardShell(
      borderLeft: best, // highlight plan subtly
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (best)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FFFB),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0x1A4CAF50)),
              ),
              child: const Text(
                'Most Popular',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: kGreen,
                  fontSize: 12,
                ),
              ),
            ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: kForest,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.w800, color: kGreen),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            textAlign: TextAlign.justify,
            style: const TextStyle(color: Color(0xFF666666), height: 1.6),
          ),
          const SizedBox(height: 12),
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Text('🌿 '),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      f,
                      style: const TextStyle(
                        color: Color(0xFF666666),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          PrimaryButton(label: 'Choose Plan', onTap: onSelect),
        ],
      ),
    );
  }
}

/* ------------------------------ FAQ ITEM ------------------------------ */
class _FAQItem extends StatelessWidget {
  final String q;
  final String a;
  const _FAQItem({required this.q, required this.a});

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: const EdgeInsets.only(top: 8),
          title: Text(
            q,
            style: const TextStyle(fontWeight: FontWeight.w800, color: kForest),
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                a,
                textAlign: TextAlign.justify,
                style: const TextStyle(color: Color(0xFF666666), height: 1.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ------------------------------ BOOKING FORM ------------------------------ */

class _BookingFormCard extends StatefulWidget {
  const _BookingFormCard();

  @override
  State<_BookingFormCard> createState() => _BookingFormCardState();
}

class _BookingFormCardState extends State<_BookingFormCard> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  String? _service;
  String? _frequency;
  String? _size;
  DateTime? _date;
  final _details = TextEditingController();

  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _address.dispose();
    _details.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    try {
      setState(() => _saving = true);

      await FirebaseFirestore.instance.collection('bookings').add({
        'name': _name.text.trim(),
        'email': _email.text.trim(),
        'phone': _phone.text.trim(),
        'address': _address.text.trim(),
        'service': _service,
        'frequency': _frequency,
        'size': _size,
        'preferredDate': _date?.toIso8601String(),
        'details': _details.text.trim(),
        'status': 'new',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) => const _SuccessDialog(
            title: '✅ Request Submitted',
            message:
                'Your service has been scheduled! We’ll contact you within 24 hours to confirm and provide a detailed estimate.',
          ),
        );
      }

      _formKey.currentState!.reset();
      _name.clear();
      _email.clear();
      _phone.clear();
      _address.clear();
      _details.clear();
      setState(() {
        _service = _frequency = _size = null;
        _date = null;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not submit. Please try again. ($e)'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Schedule Your Service',
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
                    if (v == null || v.trim().isEmpty)
                      return 'Required'; // FIXED
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
                TextFormField(
                  controller: _address,
                  decoration: const InputDecoration(
                    labelText: 'Property Address *',
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  value: _service,
                  items: const [
                    DropdownMenuItem(
                      value: 'maintenance',
                      child: Text('Lawn Maintenance'),
                    ),
                    DropdownMenuItem(
                      value: 'fertilization',
                      child: Text('Fertilization & Care'),
                    ),
                    DropdownMenuItem(
                      value: 'makeover',
                      child: Text('Seasonal Makeover'),
                    ),
                    DropdownMenuItem(
                      value: 'plants',
                      child: Text('Plant Installation'),
                    ),
                    DropdownMenuItem(
                      value: 'turf',
                      child: Text('Turf Solutions'),
                    ),
                    DropdownMenuItem(
                      value: 'consultation',
                      child: Text('Free Consultation'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Primary Service Needed *',
                  ),
                  onChanged: (v) => setState(() => _service = v),
                  validator: (v) =>
                      v == null ? 'Please select a service' : null,
                ),
                const SizedBox(height: 14),

                // === UPDATED: Frequency includes Daily ===
                DropdownButtonFormField<String>(
                  value: _frequency,
                  items: const [
                    DropdownMenuItem(
                      value: 'daily',
                      child: Text('Daily Service'),
                    ),
                    DropdownMenuItem(
                      value: 'weekly',
                      child: Text('Weekly Service'),
                    ),
                    DropdownMenuItem(
                      value: 'bi-weekly',
                      child: Text('Bi-Weekly Service'),
                    ),
                    DropdownMenuItem(
                      value: 'monthly',
                      child: Text('Monthly Service'),
                    ),
                    DropdownMenuItem(
                      value: 'seasonal',
                      child: Text('Seasonal Only'),
                    ),
                    DropdownMenuItem(
                      value: 'one-time',
                      child: Text('One-Time Service'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Service Frequency',
                  ),
                  onChanged: (v) => setState(() => _frequency = v),
                ),

                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  value: _size,
                  items: const [
                    DropdownMenuItem(
                      value: 'small',
                      child: Text('Small (Under 5,000 sq ft)'),
                    ),
                    DropdownMenuItem(
                      value: 'medium',
                      child: Text('Medium (5,000–10,000 sq ft)'),
                    ),
                    DropdownMenuItem(
                      value: 'large',
                      child: Text('Large (10,000–20,000 sq ft)'),
                    ),
                    DropdownMenuItem(
                      value: 'xlarge',
                      child: Text('Extra Large (20,000+ sq ft)'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Approximate Lawn Size',
                  ),
                  onChanged: (v) => setState(() => _size = v),
                ),
                const SizedBox(height: 14),
                InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Preferred Start Date',
                    ),
                    child: Text(
                      _date == null
                          ? 'Select date'
                          : '${_date!.year}-${_date!.month.toString().padLeft(2, '0')}-${_date!.day.toString().padLeft(2, '0')}',
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _details,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Additional Details',
                    hintText:
                        'Tell us about your needs, current lawn condition, special requests, or property challenges...',
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _saving ? null : _submit,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: kGreen,
                    ),
                    child: Text(
                      _saving ? 'Submitting…' : 'Schedule My Service',
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
