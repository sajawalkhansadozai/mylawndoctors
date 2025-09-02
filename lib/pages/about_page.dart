import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets.dart';

class AboutPage extends StatelessWidget {
  final void Function(String) onNavigate;
  const AboutPage({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // SIMPLE heading (no green hero background)
        ShellSection(
          child: Column(
            children: const [
              Text(
                'About Lawn Doctor',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: kForest,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Your trusted partner in creating beautiful outdoor spaces',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF666666)),
              ),
            ],
          ),
        ),

        // Story + Stats (overflow-proof)
        ShellSection(
          child: LayoutBuilder(
            builder: (context, c) {
              final twoCol = c.maxWidth > 920;

              final story = _StoryBlock();
              final stats = _StatsGrid();

              // Row on wide screens, Column on mobile — no Expanded in vertical mode
              if (twoCol) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: story),
                    const SizedBox(width: 24),
                    Expanded(child: stats),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [story, const SizedBox(height: 24), stats],
                );
              }
            },
          ),
        ),

        // Our Values
        ShellSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionTitle('Our Values'),
              const SizedBox(height: 14),
              LayoutBuilder(
                builder: (context, c) {
                  final cross = c.maxWidth > 900
                      ? 3
                      : (c.maxWidth > 600 ? 2 : 1);
                  return GridView.count(
                    crossAxisCount: cross,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: const [
                      _ValueCard(
                        emoji: '🤝',
                        title: 'Customer-First',
                        body:
                            'Clear communication, fast responses, and friendly crews. '
                            'We tailor service plans to your goals, schedule, and budget—no pressure, no surprises.',
                      ),
                      _ValueCard(
                        emoji: '🪴',
                        title: 'Craftsmanship',
                        body:
                            'Attention to detail in every cut, edge, and planting. '
                            'We specify the right species, soil amendments, and techniques to help your lawn thrive.',
                      ),
                      _ValueCard(
                        emoji: '♻️',
                        title: 'Sustainability',
                        body:
                            'Water-wise practices, battery equipment where practical, and low-toxicity treatments. '
                            'Healthy lawns with a lighter footprint.',
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),

        // Why Choose (6 cards)
        ShellSection(
          child: Column(
            children: [
              const SectionTitle('Why Choose Lawn Doctor?'),
              const SizedBox(height: 18),
              LayoutBuilder(
                builder: (context, c) {
                  final cross = c.maxWidth > 900
                      ? 3
                      : (c.maxWidth > 600 ? 2 : 1);
                  return GridView.count(
                    crossAxisCount: cross,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: const [
                      _WhyCard(
                        emoji: '🏆',
                        title: 'Licensed & Insured',
                        body:
                            'We’re fully licensed, bonded, and insured for complete peace of mind. '
                            'Background-checked crews follow safety-first processes with documented site assessments on larger projects.',
                      ),
                      _WhyCard(
                        emoji: '⭐',
                        title: 'Quality Guarantee',
                        body:
                            'Every job comes with a 100% satisfaction promise. '
                            'If anything isn’t perfect, we return promptly to make it right—post-service walkthroughs and photo updates included.',
                      ),
                      _WhyCard(
                        emoji: '🌍',
                        title: 'Eco-Friendly',
                        body:
                            'Low-toxicity products, integrated pest management, and water-wise irrigation audits help your lawn thrive sustainably. '
                            'We adopt battery-powered equipment where practical to reduce noise and emissions.',
                      ),
                      _WhyCard(
                        emoji: '💵',
                        title: 'Transparent Pricing',
                        body:
                            'Clear written estimates with line items, options, and timelines. '
                            'No surprise add-ons—just honest pricing and digital invoices for easy records.',
                      ),
                      _WhyCard(
                        emoji: '🎓',
                        title: 'Certified Specialists',
                        body:
                            'Horticulturists and irrigation technicians with ongoing training in soil health and turf diagnostics. '
                            'We match plant varieties to your microclimate for long-term success.',
                      ),
                      _WhyCard(
                        emoji: '⏱️',
                        title: 'On-Time & Reliable',
                        body:
                            'Accurate appointment windows with SMS reminders and GPS-dispatched crews. '
                            'Neat uniforms, respectful service, and spotless clean-ups after every visit.',
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),

        // How We Work (4 steps)
        ShellSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionTitle('How We Work'),
              const SizedBox(height: 14),
              LayoutBuilder(
                builder: (context, c) {
                  final cross = c.maxWidth > 900
                      ? 4
                      : (c.maxWidth > 700 ? 2 : 1);
                  return GridView.count(
                    crossAxisCount: cross,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: const [
                      _StepCard(
                        step: 1,
                        title: 'Discover',
                        body:
                            'Tell us your goals and constraints. We assess site conditions and discuss options.',
                      ),
                      _StepCard(
                        step: 2,
                        title: 'Design',
                        body:
                            'We propose a tailored plan—scope, timeline, and pricing—optimized for your property.',
                      ),
                      _StepCard(
                        step: 3,
                        title: 'Deliver',
                        body:
                            'Uniformed pros execute with precision, protect surfaces, and keep the site tidy.',
                      ),
                      _StepCard(
                        step: 4,
                        title: 'Delight',
                        body:
                            'Final walkthrough, tips for care, and ongoing support to keep results looking great.',
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),

        // Badges / Memberships
        ShellSection(
          child: Column(
            children: [
              const SectionTitle('Trusted By Homeowners'),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: const [
                  _BadgePill('Licensed'),
                  _BadgePill('Insured'),
                  _BadgePill('Background-Checked Crews'),
                  _BadgePill('Eco-Conscious'),
                  _BadgePill('Local Experts'),
                ],
              ),
            ],
          ),
        ),

        const Footer(),
      ],
    );
  }
}

/* --------------------------- Pieces used above --------------------------- */

class _StoryBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 8),
        SectionTitle('Our Story'),
        SizedBox(height: 12),
        Text(
          'For over a decade, Lawn Doctor has been transforming outdoor spaces across the region. '
          'We began with a simple promise: combine expert horticulture with dependable customer service—and deliver results that make homeowners proud.',
          style: TextStyle(height: 1.8, color: Color(0xFF555555)),
        ),
        SizedBox(height: 12),
        Text(
          'Today our certified specialists bring deep plant knowledge, modern turf science, and meticulous craftsmanship to every property. '
          'From compact city lawns to sprawling estates, we design, install and maintain landscapes that thrive in local conditions—season after season.',
          style: TextStyle(height: 1.8, color: Color(0xFF555555)),
        ),
        SizedBox(height: 12),
        Text(
          'Clients love us for our communication and care. You get transparent estimates, punctual crews in uniform, and spotless clean-ups after every visit. '
          'We use premium materials, water-wise practices, and eco-friendly products to protect your family, pets, and the planet.',
          style: TextStyle(height: 1.8, color: Color(0xFF555555)),
        ),
        SizedBox(height: 12),
        Text(
          'Whether you need routine maintenance, a seasonal refresh, or a complete makeover, we stand behind our work with a 100% satisfaction guarantee. '
          'Your lawn is an extension of your home—and we treat it that way.',
          style: TextStyle(height: 1.8, color: Color(0xFF555555)),
        ),
      ],
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c2) {
        final cross = c2.maxWidth > 500 ? 2 : 1;
        return GridView.count(
          crossAxisCount: cross,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _StatCard(number: '500+', label: 'Happy Customers'),
            _StatCard(number: '10+', label: 'Years Experience'),
            _StatCard(number: '100%', label: 'Satisfaction Rate'),
            _StatCard(number: '24/7', label: 'Customer Support'),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String number;
  final String label;
  const _StatCard({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FFFE), Color(0xFFF0F8F0)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0x1A4CAF50)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: kGreen,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF666666),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _WhyCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String body;
  const _WhyCard({
    required this.emoji,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [kGreen, kGreenDark]),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 28)),
            ),
          ),
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
        ],
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String body;
  const _ValueCard({
    required this.emoji,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: kForest,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(color: Color(0xFF666666), height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final int step;
  final String title;
  final String body;
  const _StepCard({
    required this.step,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Number badge
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0x1A4CAF50)),
              color: const Color(0xFFF9FFFB),
            ),
            child: Center(
              child: Text(
                '$step',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: kGreen,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: kForest,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(color: Color(0xFF666666), height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _BadgePill extends StatelessWidget {
  final String text;
  const _BadgePill(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FFFB),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x1A4CAF50)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700, color: kForest),
      ),
    );
  }
}
