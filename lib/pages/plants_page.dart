// lib/pages/plants_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lawndoctor/pages/plant_details_panel.dart'; // for PlantDetailsPage
import '../theme.dart';
import '../widgets.dart';

/* =============================== MODEL =============================== */

class Plant {
  final String id;
  final String name;
  final String price; // formatted PKR string
  final String shortDesc; // brief description
  final String longDesc; // detailed description
  final String coverImage; // Cloudinary/HTTP URL or asset path
  final List<String> images;

  const Plant({
    required this.id,
    required this.name,
    required this.price,
    required this.shortDesc,
    required this.longDesc,
    required this.coverImage,
    required this.images,
  });

  factory Plant.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? const <String, dynamic>{};
    return Plant(
      id: doc.id,
      name: (d['name'] ?? '').toString(),
      price: (d['price'] ?? '').toString(),
      shortDesc: (d['shortDesc'] ?? '').toString(),
      longDesc: (d['longDesc'] ?? '').toString(),
      coverImage: (d['coverImage'] ?? '').toString(),
      images:
          (d['images'] as List?)
              ?.map((e) => e?.toString() ?? '')
              .where((e) => e.isNotEmpty)
              .toList() ??
          const <String>[],
    );
  }
}

/* ============================== PLANTS PAGE ============================== */

class PlantsPage extends StatefulWidget {
  final void Function(String) onNavigate;
  const PlantsPage({super.key, required this.onNavigate});

  @override
  State<PlantsPage> createState() => _PlantsPageState();
}

class _PlantsPageState extends State<PlantsPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _q = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Stream<List<Plant>> _plantsStream() {
    // Keep it simple and robust: load up to 500 and filter client-side.
    // (If your catalog grows, add indexed queries or use an external search.)
    return FirebaseFirestore.instance
        .collection('plants')
        .limit(500)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Plant.fromDoc(d)).toList());
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return ListView(
      children: [
        // Heading — compact on mobile
        ShellSection(
          child: Column(
            children: [
              Text(
                'Premium Plant Selection',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 28 : 32,
                  fontWeight: FontWeight.w800,
                  color: kForest,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Expertly chosen plants that thrive in your environment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF666666),
                  fontSize: isMobile ? 13 : 14,
                ),
              ),
            ],
          ),
        ),

        // Search bar
        ShellSection(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isMobile ? 900 : 720),
                  child: TextField(
                    controller: _searchCtrl,
                    textInputAction: TextInputAction.search,
                    onChanged: (v) => setState(() => _q = v),
                    onSubmitted: (v) => setState(() => _q = v),
                    decoration: InputDecoration(
                      hintText: 'Search plants or trees…',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _q.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Clear',
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _searchCtrl.clear();
                                setState(() => _q = '');
                              },
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: isMobile ? 10 : 14,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Live counts via stream
              StreamBuilder<List<Plant>>(
                stream: _plantsStream(),
                builder: (context, snap) {
                  final total = snap.data?.length ?? 0;
                  // We don't filter here to avoid double work; just show total.
                  return Text(
                    'Total plants: $total',
                    style: TextStyle(
                      color: const Color(0xFF777777),
                      fontSize: isMobile ? 12 : 13,
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        // Responsive grid populated from Firestore
        ShellSection(
          child: StreamBuilder<List<Plant>>(
            stream: _plantsStream(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (snap.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'Error loading plants: ${snap.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              var items = snap.data ?? const <Plant>[];

              // Client-side search filter
              final q = _q.trim().toLowerCase();
              if (q.isNotEmpty) {
                items = items.where((p) {
                  final name = p.name.toLowerCase();
                  final desc = p.shortDesc.toLowerCase();
                  return name.contains(q) || desc.contains(q);
                }).toList();
              }

              if (items.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'No plants found. Add items in Admin panel, or adjust your search.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF666666)),
                  ),
                );
              }

              return LayoutBuilder(
                builder: (context, c) {
                  final w = c.maxWidth;
                  // exact requirement: 4 on big screens, 2 on mobile; use 3 on mid widths for better fit
                  final int cols = w >= 1200 ? 4 : (w >= 800 ? 3 : 2);
                  final bool compact = cols == 2; // phone
                  final double gap = compact ? 14 : 22;
                  // Heights tuned per density to keep layout overflow-proof
                  final double cardHeight = cols == 4
                      ? 356
                      : (cols == 3 ? 360 : 320);
                  final double imageHeight = compact ? 88 : 120;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      crossAxisSpacing: gap,
                      mainAxisSpacing: gap,
                      mainAxisExtent: cardHeight, // keeps layout stable
                    ),
                    itemCount: items.length,
                    itemBuilder: (_, i) => _PlantListCard(
                      plant: items[i],
                      imageHeight: imageHeight,
                      compact: compact,
                    ),
                  );
                },
              );
            },
          ),
        ),

        const Footer(),
      ],
    );
  }
}

/* --------------------------- LIST CARD (CTA) --------------------------- */

class _PlantListCard extends StatelessWidget {
  final Plant plant;
  final double imageHeight;
  final bool compact;
  const _PlantListCard({
    required this.plant,
    required this.imageHeight,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover image (Cloudinary/network/asset safe)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _SmartImage(
              src: plant.coverImage,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),

          // Name (2 lines on mobile)
          Text(
            plant.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: compact ? 15 : 16,
              fontWeight: FontWeight.w800,
              color: kForest,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 3),

          // Price
          Text(
            plant.price,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w800, color: kGreen),
          ),
          const SizedBox(height: 6),

          // Short description (2–3 lines)
          Text(
            plant.shortDesc,
            textAlign: TextAlign.justify,
            maxLines: compact ? 2 : 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF666666),
              height: compact ? 1.4 : 1.5,
              fontSize: compact ? 12.8 : 13.2,
            ),
          ),

          const Spacer(),

          // CTA
          Align(
            alignment: Alignment.centerLeft,
            child: PrimaryButton(
              label: 'Check Details',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PlantDetailsPage(plant: plant),
                  ),
                );
              },
            ),
          ),
        ],
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

    // Fallback: treat as asset path
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
