import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // <-- Firestore
import '../theme.dart';
import '../widgets.dart';

class ServicesPage extends StatefulWidget {
  final void Function(String) onNavigate;
  const ServicesPage({super.key, required this.onNavigate});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  // Anchor to scroll to booking form
  final _bookingKey = GlobalKey();

  void _scrollToBooking() {
    final ctx = _bookingKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // === SIMPLE HEADING (no image slider) ===
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

        // === SERVICE CATALOG ===
        ShellSection(
          child: Column(
            children: [
              const Text(
                'At Lawn Doctor, we provide complete lawn care designed to keep your outdoor space healthy, beautiful, and perfectly maintained. '
                'Our professional team uses premium equipment and proven techniques to deliver exceptional results.',
                textAlign: TextAlign.justify,
                style: TextStyle(color: Color(0xFF666666)),
              ),
              const SizedBox(height: 10),
              const Text(
                'We match plant varieties and turf care to your local microclimate, monitor soil health, and fine-tune irrigation to reduce waste. '
                'Expect clear communication, tidy clean-ups, and a 100% satisfaction promise on every job.',
                textAlign: TextAlign.justify,
                style: TextStyle(color: Color(0xFF666666), height: 1.6),
              ),
              const SizedBox(height: 24),
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
                    children: const [
                      ServiceCard(
                        emoji: '🌱',
                        title: 'Professional Maintenance',
                        body:
                            'Precision cutting, edging, weeding, and full upkeep to keep your lawn immaculate.',
                        price: 'Starting at PKR 2,000 / visit',
                      ),
                      ServiceCard(
                        emoji: '💧',
                        title: 'Fertilization & Health Care',
                        body:
                            'Fertilization programs, pest control, disease management, and irrigation checks.',
                        price: 'Starting at PKR 3,000–4,000 / treatment',
                      ),
                      ServiceCard(
                        emoji: '🌸',
                        title: 'Seasonal Makeovers',
                        body:
                            'Transformations with seasonal plantings and design refreshes.',
                        price: 'Custom pricing (PKR)',
                      ),
                      ServiceCard(
                        emoji: '🌳',
                        title: 'Plant Installation',
                        body:
                            'Ornamentals, flowers, shrubs, palms, and fruit trees matched to your space.',
                        price: 'Starting at PKR 10,000+ / project',
                      ),
                      ServiceCard(
                        emoji: '🏡',
                        title: 'Premium Turf Solutions',
                        body:
                            'Turf installation and maintenance with durable, beautiful varieties.',
                        price: 'From PKR 2,000 / sq ft',
                      ),
                      ServiceCard(
                        emoji: '📅',
                        title: 'Flexible Service Plans',
                        body:
                            'Weekly or monthly plans with on-time service and transparent billing.',
                        price: 'Plans from PKR 2,000 / month',
                      ),
                    ],
                  );
                },
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

        // === PLANS & PRICING ===
        ShellSection(
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
                      _PlanCard(
                        name: 'Essential',
                        price: 'PKR 2,000 / visit',
                        desc:
                            'Reliable upkeep to keep your lawn neat and healthy.',
                        features: const [
                          'Mowing, edging & trimming',
                          'Spot weeding',
                          'Blow-down & cleanup',
                        ],
                        onSelect: _scrollToBooking, // auto-scroll
                      ),
                      _PlanCard(
                        name: 'Plus',
                        price: 'PKR 3,500 / visit',
                        desc:
                            'Everything in Essential, plus proactive health care.',
                        features: const [
                          'All Essential features',
                          'Fertilization schedule',
                          'Irrigation checkup',
                        ],
                        onSelect: _scrollToBooking,
                        best: true,
                      ),
                      _PlanCard(
                        name: 'Premium',
                        price: 'Custom (PKR)',
                        desc: 'White-glove care for showcase lawns & estates.',
                        features: const [
                          'All Plus features',
                          'Seasonal color & refresh',
                          'Priority scheduling',
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

        // === BOOKING (simple heading, no hero) ===
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

        // Anchor-wrapped booking section for smooth scroll
        KeyedSubtree(key: _bookingKey, child: const _BookingSection()),
        const Footer(),
      ],
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
            // Wide screens: side-by-side with Expanded
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: _BookingFormCard()),
                SizedBox(width: 24),
                Expanded(child: _BookingInfoCard()),
              ],
            );
          }

          // Mobile: stacked, NO Expanded (prevents unbounded/hidden content)
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
      borderLeft: best, // highlight best plan subtly
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

      // Success UI
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

      // Reset form
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
                DropdownButtonFormField<String>(
                  value: _frequency,
                  items: const [
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
            Text(
              title,
              style: const TextStyle(
                color: kGreen,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF555555)),
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
