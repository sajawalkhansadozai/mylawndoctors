// lib/pages/admin_panel_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // Changed to 4 tabs
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });

    _fadeController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              _buildCompactHeader(isMobile),
              Flexible(child: _buildStatsOverview(isMobile, isTablet)),
              _buildTabBar(isMobile),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    _MessagesTab(),
                    _BookingsTab(),
                    _OrdersTab(),
                    _PlantsTab(), // Added plants tab
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActions(isMobile),
    );
  }

  Widget _buildCompactHeader(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isMobile ? 8 : 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kGreen.withOpacity(0.8), kGreenDark.withOpacity(0.9)],
              ),
              borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
              boxShadow: [
                BoxShadow(
                  color: kGreen.withOpacity(0.3),
                  blurRadius: isMobile ? 8 : 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.dashboard_rounded,
              color: Colors.white,
              size: isMobile ? 20 : 28,
            ),
          ),
          SizedBox(width: isMobile ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin Dashboard',
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 24,
                    fontWeight: FontWeight.w800,
                    color: kForest,
                    letterSpacing: -0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  isMobile
                      ? 'Manage your business'
                      : 'Monitor and manage your lawn care business',
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview(bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 8 : 12,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Force stacked layout on very narrow screens
          if (constraints.maxWidth < 400) {
            return Column(
              children: [
                _buildStatCard(
                  'Messages',
                  Icons.message_rounded,
                  const Color(0xFF10B981),
                  true,
                ),
                const SizedBox(height: 8),
                _buildStatCard(
                  'Bookings',
                  Icons.calendar_today_rounded,
                  const Color(0xFF3B82F6),
                  true,
                ),
                const SizedBox(height: 8),
                _buildStatCard(
                  'Orders',
                  Icons.shopping_bag_rounded,
                  const Color(0xFFf59E0B),
                  true,
                ),
                const SizedBox(height: 8),
                _buildStatCard(
                  'Plants',
                  Icons.local_florist_rounded,
                  const Color(0xFF8B5CF6),
                  true,
                ),
              ],
            );
          }

          // 2x2 grid for mobile, row for wider screens
          if (isMobile) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Messages',
                        Icons.message_rounded,
                        const Color(0xFF10B981),
                        isMobile,
                      ),
                    ),
                    SizedBox(width: isMobile ? 8 : 12),
                    Expanded(
                      child: _buildStatCard(
                        'Bookings',
                        Icons.calendar_today_rounded,
                        const Color(0xFF3B82F6),
                        isMobile,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Orders',
                        Icons.shopping_bag_rounded,
                        const Color(0xFFf59E0B),
                        isMobile,
                      ),
                    ),
                    SizedBox(width: isMobile ? 8 : 12),
                    Expanded(
                      child: _buildStatCard(
                        'Plants',
                        Icons.local_florist_rounded,
                        const Color(0xFF8B5CF6),
                        isMobile,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          // Row layout for wider screens
          return Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Messages',
                  Icons.message_rounded,
                  const Color(0xFF10B981),
                  isMobile,
                ),
              ),
              SizedBox(width: isMobile ? 8 : 12),
              Expanded(
                child: _buildStatCard(
                  'Bookings',
                  Icons.calendar_today_rounded,
                  const Color(0xFF3B82F6),
                  isMobile,
                ),
              ),
              SizedBox(width: isMobile ? 8 : 12),
              Expanded(
                child: _buildStatCard(
                  'Orders',
                  Icons.shopping_bag_rounded,
                  const Color(0xFFf59E0B),
                  isMobile,
                ),
              ),
              SizedBox(width: isMobile ? 8 : 12),
              Expanded(
                child: _buildStatCard(
                  'Plants',
                  Icons.local_florist_rounded,
                  const Color(0xFF8B5CF6),
                  isMobile,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    IconData icon,
    Color color,
    bool isCompact,
  ) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(_getCollectionName(title))
          .snapshots(),
      builder: (context, snapshot) {
        final count = snapshot.hasData ? snapshot.data!.docs.length : 0;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(isCompact ? 12 : 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isCompact ? 16 : 20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: isCompact ? 12 : 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(isCompact ? 8 : 12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(isCompact ? 8 : 12),
                ),
                child: Icon(icon, color: color, size: isCompact ? 18 : 24),
              ),
              SizedBox(height: isCompact ? 8 : 12),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: isCompact ? 18 : 24,
                  fontWeight: FontWeight.w800,
                  color: kForest,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: isCompact ? 10 : 12,
                  color: const Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  String _getCollectionName(String title) {
    switch (title) {
      case 'Messages':
        return 'contactMessages';
      case 'Bookings':
        return 'bookings';
      case 'Orders':
        return 'orders';
      case 'Plants':
        return 'plants';
      default:
        return 'contactMessages';
    }
  }

  Widget _buildTabBar(bool isMobile) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 8 : 10,
      ),
      padding: EdgeInsets.all(isMobile ? 4 : 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: isMobile ? 12 : 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
          gradient: LinearGradient(
            colors: [kGreen.withOpacity(0.9), kGreenDark],
          ),
          boxShadow: [
            BoxShadow(
              color: kGreen.withOpacity(0.4),
              blurRadius: isMobile ? 8 : 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF64748B),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: isMobile ? 11 : 13,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: isMobile ? 11 : 13,
        ),
        tabs: [
          _buildTab(
            Icons.message_rounded,
            isMobile ? 'Msg' : 'Messages',
            0,
            isMobile,
          ),
          _buildTab(
            Icons.calendar_today_rounded,
            isMobile ? 'Book' : 'Bookings',
            1,
            isMobile,
          ),
          _buildTab(
            Icons.shopping_bag_rounded,
            isMobile ? 'Order' : 'Orders',
            2,
            isMobile,
          ),
          _buildTab(
            Icons.local_florist_rounded,
            isMobile ? 'Plant' : 'Plants',
            3,
            isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildTab(IconData icon, String label, int index, bool isMobile) {
    final isSelected = _selectedIndex == index;
    return Tab(
      height: isMobile ? 40 : 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isMobile ? 14 : 18,
            color: isSelected ? Colors.white : const Color(0xFF64748B),
          ),
          SizedBox(width: isMobile ? 3 : 6),
          Flexible(
            child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActions(bool isMobile) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'debug',
          onPressed: () => _showDebugMenu(context),
          backgroundColor: kGreen,
          elevation: 8,
          mini: isMobile,
          child: Icon(
            Icons.bug_report_rounded,
            color: Colors.white,
            size: isMobile ? 18 : 24,
          ),
        ),
        SizedBox(height: isMobile ? 8 : 12),
        FloatingActionButton.small(
          heroTag: 'refresh',
          onPressed: () {
            setState(() {});
            _showSnackBar('Data refreshed', kGreen);
          },
          backgroundColor: Colors.white,
          elevation: 4,
          child: Icon(Icons.refresh_rounded, color: kGreen, size: 16),
        ),
      ],
    );
  }

  void _showDebugMenu(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: kGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.build_rounded,
                        color: kGreen,
                        size: isMobile ? 20 : 24,
                      ),
                    ),
                    SizedBox(width: isMobile ? 8 : 12),
                    Expanded(
                      child: Text(
                        'Debug Tools',
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 22,
                          fontWeight: FontWeight.w800,
                          color: kForest,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 16 : 24),
                _buildDebugButton(
                  'Add Test Message',
                  Icons.message_rounded,
                  () => _addTestMessage(),
                  const Color(0xFF10B981),
                  isMobile,
                ),
                _buildDebugButton(
                  'Add Test Booking',
                  Icons.calendar_today_rounded,
                  () => _addTestBooking(),
                  const Color(0xFF3B82F6),
                  isMobile,
                ),
                _buildDebugButton(
                  'Add Test Order',
                  Icons.shopping_bag_rounded,
                  () => _addTestOrder(),
                  const Color(0xFFf59E0B),
                  isMobile,
                ),

                Divider(height: isMobile ? 24 : 32),
                _buildDebugButton(
                  'Clear All Data',
                  Icons.delete_sweep_rounded,
                  () => _clearAllData(),
                  const Color(0xFFEF4444),
                  isMobile,
                  isDestructive: true,
                ),
                _buildDebugButton(
                  'Check Collections',
                  Icons.search_rounded,
                  () => _checkCollections(),
                  const Color(0xFF8B5CF6),
                  isMobile,
                ),
                SizedBox(height: isMobile ? 8 : 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDebugButton(
    String label,
    IconData icon,
    VoidCallback onTap,
    Color color,
    bool isMobile, {
    bool isDestructive = false,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: isMobile ? 8 : 12),
      child: Material(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            onTap();
          },
          borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 20),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isMobile ? 6 : 8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
                  ),
                  child: Icon(icon, color: color, size: isMobile ? 16 : 20),
                ),
                SizedBox(width: isMobile ? 12 : 16),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: color.withOpacity(0.9),
                      fontSize: isMobile ? 13 : 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: isMobile ? 14 : 16,
                  color: color.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Debug methods with added plant functionality
  Future<void> _addTestMessage() async {
    try {
      await FirebaseFirestore.instance.collection('contactMessages').add({
        'name': 'Sarah Ahmad',
        'email': 'sarah.ahmad@example.com',
        'phone': '+92 300 1234567',
        'subject': 'quote',
        'message':
            'Hi, I need professional lawn maintenance for my 2000 sq ft garden in F-7. Could you provide a detailed quote including weekly mowing and seasonal fertilization?',
        'createdAt': FieldValue.serverTimestamp(),
      });
      _showSnackBar('Test message added successfully', const Color(0xFF10B981));
    } catch (e) {
      _showSnackBar('Error adding test message', const Color(0xFFEF4444));
    }
  }

  Future<void> _addTestBooking() async {
    try {
      await FirebaseFirestore.instance.collection('bookings').add({
        'name': 'Ahmed Khan',
        'email': 'ahmed.khan@example.com',
        'phone': '+92 321 9876543',
        'address': '123 Garden Street, F-8 Markaz, Islamabad',
        'service': 'maintenance',
        'frequency': 'weekly',
        'size': 'medium',
        'preferredDate': DateTime.now()
            .add(const Duration(days: 7))
            .toIso8601String(),
        'details':
            'Need comprehensive lawn care including edge trimming and seasonal plantings.',
        'status': 'new',
        'createdAt': FieldValue.serverTimestamp(),
      });
      _showSnackBar('Test booking added successfully', const Color(0xFF3B82F6));
    } catch (e) {
      _showSnackBar('Error adding test booking', const Color(0xFFEF4444));
    }
  }

  Future<void> _addTestOrder() async {
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'plantId': 'rose_garden_premium',
        'plantName': 'Premium Rose Garden Collection',
        'price': 'PKR 25,000',
        'quantity': 3,
        'customerName': 'Fatima Malik',
        'address': '456 Rose Avenue, G-10/4, Islamabad',
        'city': 'Islamabad',
        'phone': '+92 335 4567890',
        'status': 'new',
        'createdAt': FieldValue.serverTimestamp(),
      });
      _showSnackBar('Test order added successfully', const Color(0xFFf59E0B));
    } catch (e) {
      _showSnackBar('Error adding test order', const Color(0xFFEF4444));
    }
  }

  Future<void> _clearAllData() async {
    try {
      final collections = ['contactMessages', 'bookings', 'orders', 'plants'];

      for (final collection in collections) {
        final snapshot = await FirebaseFirestore.instance
            .collection(collection)
            .get();
        for (final doc in snapshot.docs) {
          await doc.reference.delete();
        }
      }
      _showSnackBar('All test data cleared', const Color(0xFF8B5CF6));
    } catch (e) {
      _showSnackBar('Error clearing data', const Color(0xFFEF4444));
    }
  }

  Future<void> _checkCollections() async {
    try {
      final collections = ['contactMessages', 'bookings', 'orders', 'plants'];

      for (final collection in collections) {
        final snapshot = await FirebaseFirestore.instance
            .collection(collection)
            .get();
        print('📊 $collection: ${snapshot.docs.length} documents');

        if (snapshot.docs.isNotEmpty) {
          print('📄 Sample $collection data: ${snapshot.docs.first.data()}');
        }
      }

      _showSnackBar(
        'Collection data logged to console',
        const Color(0xFF8B5CF6),
      );
    } catch (e) {
      _showSnackBar('Error checking collections', const Color(0xFFEF4444));
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              message.contains('Error')
                  ? Icons.error_rounded
                  : Icons.check_circle_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}

/* ================================ TABS ================================ */

class _MessagesTab extends StatelessWidget {
  const _MessagesTab();

  @override
  Widget build(BuildContext context) {
    return _CollectionStreamList(
      collection: 'contactMessages',
      icon: Icons.message_rounded,
      emptyTitle: 'No Messages Yet',
      emptyDescription:
          'Customer messages will appear here when they contact you.',
      color: const Color(0xFF10B981),
      builder: (doc) {
        final data = doc.data() as Map<String, dynamic>? ?? {};
        return _MessageCard(
          name: data['name'] ?? 'Unknown',
          email: data['email'] ?? 'No email',
          phone: data['phone'] ?? 'No phone',
          subject: data['subject'] ?? 'No subject',
          message: data['message'] ?? 'No message',
          createdAt: data['createdAt'],
        );
      },
    );
  }
}

class _BookingsTab extends StatelessWidget {
  const _BookingsTab();

  @override
  Widget build(BuildContext context) {
    return _CollectionStreamList(
      collection: 'bookings',
      icon: Icons.calendar_today_rounded,
      emptyTitle: 'No Service Bookings',
      emptyDescription:
          'Service requests will appear here when customers book services.',
      color: const Color(0xFF3B82F6),
      builder: (doc) {
        final data = doc.data() as Map<String, dynamic>? ?? {};
        return _BookingCard(
          name: data['name'] ?? 'Unknown',
          email: data['email'] ?? 'No email',
          phone: data['phone'] ?? 'No phone',
          service: data['service'] ?? 'Unknown service',
          frequency: data['frequency'] ?? 'Not specified',
          size: data['size'] ?? 'Not specified',
          address: data['address'] ?? 'No address',
          preferredDate: data['preferredDate'],
          details: data['details'] ?? '',
          createdAt: data['createdAt'],
        );
      },
    );
  }
}

class _OrdersTab extends StatelessWidget {
  const _OrdersTab();

  @override
  Widget build(BuildContext context) {
    return _CollectionStreamList(
      collection: 'orders',
      icon: Icons.shopping_bag_rounded,
      emptyTitle: 'No Plant Orders',
      emptyDescription:
          'Plant orders will appear here when customers make purchases.',
      color: const Color(0xFFf59E0B),
      builder: (doc) {
        final data = doc.data() as Map<String, dynamic>? ?? {};
        return _OrderCard(
          customerName: data['customerName'] ?? 'Unknown',
          city: data['city'] ?? 'Unknown city',
          phone: data['phone'] ?? 'No phone',
          address: data['address'] ?? 'No address',
          plantName: data['plantName'] ?? 'Unknown plant',
          quantity: data['quantity'] ?? 1,
          price: data['price'] ?? 'Not specified',
          createdAt: data['createdAt'],
        );
      },
    );
  }
}

class _PlantsTab extends StatelessWidget {
  const _PlantsTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _CollectionStreamList(
        collection: 'plants',
        icon: Icons.local_florist_rounded,
        emptyTitle: 'No Plants in Catalog',
        emptyDescription:
            'Add plants to your catalog to display them to customers.',
        color: const Color(0xFF8B5CF6),
        builder: (doc) {
          final data = doc.data() as Map<String, dynamic>? ?? {};
          return _PlantCard(
            name: data['name'] ?? 'Unknown Plant',
            price: data['price'] ?? 'Price not set',
            shortDesc: data['shortDesc'] ?? 'No description',
            longDesc: data['longDesc'] ?? 'No detailed description',
            coverImage: data['coverImage'] ?? '',
            images:
                (data['images'] as List?)
                    ?.map((e) => e?.toString() ?? '')
                    .where((e) => e.isNotEmpty)
                    .toList() ??
                [],
            createdAt: data['createdAt'],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPlantDialog(context),
        backgroundColor: const Color(0xFF8B5CF6),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          'Add Plant',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  void _showAddPlantDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const _AddPlantDialog(),
    );
  }
}

/* ============================ ADD PLANT DIALOG ============================ */

class _AddPlantDialog extends StatefulWidget {
  const _AddPlantDialog();

  @override
  State<_AddPlantDialog> createState() => _AddPlantDialogState();
}

class _AddPlantDialogState extends State<_AddPlantDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _shortDescController = TextEditingController();
  final _longDescController = TextEditingController();
  final _coverImageController = TextEditingController();
  final _imageUrlController = TextEditingController();

  final List<String> _imageUrls = [];
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _shortDescController.dispose();
    _longDescController.dispose();
    _coverImageController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Dialog(
      insetPadding: EdgeInsets.all(isMobile ? 16 : 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: isMobile ? double.infinity : 600,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 20 : 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF8B5CF6).withOpacity(0.1),
                    const Color(0xFF8B5CF6).withOpacity(0.05),
                  ],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.local_florist_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add New Plant',
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 20,
                            fontWeight: FontWeight.w800,
                            color: kForest,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Add plant to your catalog',
                          style: TextStyle(
                            color: const Color(0xFF64748B),
                            fontSize: isMobile ? 13 : 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _saving ? null : () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                    color: const Color(0xFF64748B),
                  ),
                ],
              ),
            ),

            // Form
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 20 : 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Plant Name
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Plant Name *',
                          hintText: 'e.g., Premium Rose Bush',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.local_florist_rounded),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Plant name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Price
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Price *',
                          hintText: 'e.g., PKR 1,500',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.attach_money_rounded),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Price is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Short Description
                      TextFormField(
                        controller: _shortDescController,
                        decoration: InputDecoration(
                          labelText: 'Short Description *',
                          hintText: 'Brief description for plant cards',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.short_text_rounded),
                        ),
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Short description is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Long Description
                      TextFormField(
                        controller: _longDescController,
                        decoration: InputDecoration(
                          labelText: 'Detailed Description *',
                          hintText:
                              'Detailed description for plant detail page',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.description_rounded),
                        ),
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Detailed description is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Cover Image URL
                      TextFormField(
                        controller: _coverImageController,
                        decoration: InputDecoration(
                          labelText: 'Cover Image URL',
                          hintText: 'https://example.com/image.jpg',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.image_rounded),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Additional Images
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _imageUrlController,
                              decoration: InputDecoration(
                                labelText: 'Additional Image URL',
                                hintText: 'https://example.com/image2.jpg',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: const Icon(
                                  Icons.photo_library_rounded,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              final url = _imageUrlController.text.trim();
                              if (url.isNotEmpty && !_imageUrls.contains(url)) {
                                setState(() {
                                  _imageUrls.add(url);
                                  _imageUrlController.clear();
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8B5CF6),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(16),
                            ),
                            child: const Icon(Icons.add_rounded),
                          ),
                        ],
                      ),

                      // Show added image URLs
                      if (_imageUrls.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _imageUrls.map((url) {
                            return Chip(
                              label: Text(
                                url.length > 30
                                    ? '${url.substring(0, 30)}...'
                                    : url,
                                style: const TextStyle(fontSize: 12),
                              ),
                              deleteIcon: const Icon(Icons.close, size: 16),
                              onDeleted: () {
                                setState(() {
                                  _imageUrls.remove(url);
                                });
                              },
                              backgroundColor: const Color(
                                0xFF8B5CF6,
                              ).withOpacity(0.1),
                              deleteIconColor: const Color(0xFF8B5CF6),
                            );
                          }).toList(),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _saving
                                  ? null
                                  : () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _saving ? null : _savePlant,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8B5CF6),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _saving
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'Add Plant',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                            ),
                          ),
                        ],
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

  Future<void> _savePlant() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    try {
      await FirebaseFirestore.instance.collection('plants').add({
        'name': _nameController.text.trim(),
        'price': _priceController.text.trim(),
        'shortDesc': _shortDescController.text.trim(),
        'longDesc': _longDescController.text.trim(),
        'coverImage': _coverImageController.text.trim(),
        'images': _imageUrls,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${_nameController.text} added successfully!',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Error adding plant: $e',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

/* ============================ PLANT CARD ============================ */

class _PlantCard extends StatelessWidget {
  final String name, price, shortDesc, longDesc, coverImage;
  final List<String> images;
  final dynamic createdAt;

  const _PlantCard({
    required this.name,
    required this.price,
    required this.shortDesc,
    required this.longDesc,
    required this.coverImage,
    required this.images,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: isMobile ? 12 : 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with image and basic info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF8B5CF6).withOpacity(0.05),
                  const Color(0xFF8B5CF6).withOpacity(0.02),
                ],
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(isMobile ? 16 : 20),
              ),
            ),
            child: Row(
              children: [
                // Plant image
                Container(
                  width: isMobile ? 60 : 80,
                  height: isMobile ? 60 : 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                    border: Border.all(
                      color: const Color(0xFF8B5CF6).withOpacity(0.2),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(isMobile ? 11 : 15),
                    child: coverImage.isNotEmpty
                        ? Image.network(
                            coverImage,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: const Color(0xFFEFEFEF),
                              child: Icon(
                                Icons.local_florist_rounded,
                                color: const Color(0xFF8B5CF6).withOpacity(0.5),
                                size: isMobile ? 24 : 32,
                              ),
                            ),
                          )
                        : Container(
                            color: const Color(0xFFEFEFEF),
                            child: Icon(
                              Icons.local_florist_rounded,
                              color: const Color(0xFF8B5CF6).withOpacity(0.5),
                              size: isMobile ? 24 : 32,
                            ),
                          ),
                  ),
                ),
                SizedBox(width: isMobile ? 12 : 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.w800,
                          color: kForest,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isMobile ? 4 : 6),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 8 : 12,
                          vertical: isMobile ? 4 : 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B5CF6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            isMobile ? 16 : 20,
                          ),
                          border: Border.all(
                            color: const Color(0xFF8B5CF6).withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          price,
                          style: TextStyle(
                            color: const Color(0xFF8B5CF6),
                            fontWeight: FontWeight.w800,
                            fontSize: isMobile ? 12 : 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(createdAt, isMobile),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  Icons.description_rounded,
                  'Short Description',
                  shortDesc,
                  isMobile,
                  isMultiline: true,
                ),
                SizedBox(height: isMobile ? 12 : 16),
                _buildInfoRow(
                  Icons.info_rounded,
                  'Detailed Description',
                  longDesc.length > 100
                      ? '${longDesc.substring(0, 100)}...'
                      : longDesc,
                  isMobile,
                  isMultiline: true,
                ),
                if (images.isNotEmpty) ...[
                  SizedBox(height: isMobile ? 12 : 16),
                  _buildInfoRow(
                    Icons.photo_library_rounded,
                    'Images',
                    '${images.length} image${images.length == 1 ? '' : 's'} uploaded',
                    isMobile,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ============================ REMAINING CLASSES ============================ */

/* ============================= CORE LIST ============================= */

class _CollectionStreamList extends StatelessWidget {
  final String collection;
  final IconData icon;
  final String emptyTitle;
  final String emptyDescription;
  final Color color;
  final Widget Function(QueryDocumentSnapshot<Map<String, dynamic>>) builder;

  const _CollectionStreamList({
    required this.collection,
    required this.icon,
    required this.emptyTitle,
    required this.emptyDescription,
    required this.color,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final q = FirebaseFirestore.instance
        .collection(collection)
        .orderBy('createdAt', descending: true);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: q.snapshots(),
        builder: (context, snap) {
          if (snap.hasError) {
            return _ErrorState(
              icon: icon,
              collection: collection,
              error: snap.error.toString(),
              color: color,
            );
          }

          if (!snap.hasData) {
            return _LoadingState(icon: icon, color: color);
          }

          final docs = snap.data!.docs;

          if (docs.isEmpty) {
            return _EmptyState(
              icon: icon,
              title: emptyTitle,
              description: emptyDescription,
              color: color,
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 100), // Account for FAB
            itemCount: docs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) => TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 200 + (i * 50)),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 10 * (1 - value)),
                  child: Opacity(opacity: value, child: builder(docs[i])),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/* ============================ RESPONSIVE CARD DESIGNS ============================ */

class _MessageCard extends StatelessWidget {
  final String name, email, phone, subject, message;
  final dynamic createdAt;

  const _MessageCard({
    required this.name,
    required this.email,
    required this.phone,
    required this.subject,
    required this.message,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: isMobile ? 12 : 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF10B981).withOpacity(0.05),
                  const Color(0xFF10B981).withOpacity(0.02),
                ],
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(isMobile ? 16 : 20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: isMobile ? 40 : 48,
                  height: isMobile ? 40 : 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF10B981),
                        const Color(0xFF10B981).withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withOpacity(0.3),
                        blurRadius: isMobile ? 8 : 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: isMobile ? 14 : 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: isMobile ? 12 : 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.w800,
                          color: kForest,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isMobile ? 2 : 4),
                      Text(
                        email,
                        style: TextStyle(
                          color: kForest.withOpacity(0.7),
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(createdAt, isMobile),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (subject.isNotEmpty && subject != 'No subject') ...[
                  _buildInfoRow(
                    Icons.tag_rounded,
                    'Subject',
                    _formatSubject(subject),
                    isMobile,
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                ],
                if (phone.isNotEmpty && phone != 'No phone') ...[
                  _buildInfoRow(Icons.phone_rounded, 'Phone', phone, isMobile),
                  SizedBox(height: isMobile ? 12 : 16),
                ],
                _buildInfoRow(
                  Icons.message_rounded,
                  'Message',
                  message,
                  isMobile,
                  isMultiline: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final String name, email, phone, service, frequency, size, address, details;
  final dynamic preferredDate, createdAt;

  const _BookingCard({
    required this.name,
    required this.email,
    required this.phone,
    required this.service,
    required this.frequency,
    required this.size,
    required this.address,
    required this.details,
    required this.preferredDate,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: isMobile ? 12 : 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF3B82F6).withOpacity(0.05),
                  const Color(0xFF3B82F6).withOpacity(0.02),
                ],
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(isMobile ? 16 : 20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: isMobile ? 40 : 48,
                      height: isMobile ? 40 : 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF3B82F6),
                            const Color(0xFF3B82F6).withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF3B82F6).withOpacity(0.3),
                            blurRadius: isMobile ? 8 : 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.white,
                        size: isMobile ? 18 : 22,
                      ),
                    ),
                    SizedBox(width: isMobile ? 12 : 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              fontWeight: FontWeight.w800,
                              color: kForest,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: isMobile ? 2 : 4),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 8 : 12,
                              vertical: isMobile ? 4 : 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3B82F6).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                isMobile ? 16 : 20,
                              ),
                              border: Border.all(
                                color: const Color(0xFF3B82F6).withOpacity(0.2),
                              ),
                            ),
                            child: Text(
                              _formatService(service),
                              style: TextStyle(
                                color: const Color(0xFF3B82F6),
                                fontWeight: FontWeight.w700,
                                fontSize: isMobile ? 10 : 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusChip(createdAt, isMobile),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stack contact info on mobile
                if (isMobile) ...[
                  _buildInfoRow(Icons.email_rounded, 'Email', email, isMobile),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.phone_rounded, 'Phone', phone, isMobile),
                  const SizedBox(height: 12),
                ] else ...[
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoRow(
                          Icons.email_rounded,
                          'Email',
                          email,
                          isMobile,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildInfoRow(
                          Icons.phone_rounded,
                          'Phone',
                          phone,
                          isMobile,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                // Stack service details on mobile
                if (isMobile) ...[
                  _buildInfoRow(
                    Icons.repeat_rounded,
                    'Frequency',
                    _formatFrequency(frequency),
                    isMobile,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.aspect_ratio_rounded,
                    'Size',
                    _formatSize(size),
                    isMobile,
                  ),
                  const SizedBox(height: 12),
                ] else ...[
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoRow(
                          Icons.repeat_rounded,
                          'Frequency',
                          _formatFrequency(frequency),
                          isMobile,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildInfoRow(
                          Icons.aspect_ratio_rounded,
                          'Size',
                          _formatSize(size),
                          isMobile,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                _buildInfoRow(
                  Icons.event_rounded,
                  'Preferred Date',
                  _formatISODate(preferredDate),
                  isMobile,
                ),
                SizedBox(height: isMobile ? 12 : 16),
                _buildInfoRow(
                  Icons.location_on_rounded,
                  'Address',
                  address,
                  isMobile,
                ),
                if (details.isNotEmpty) ...[
                  SizedBox(height: isMobile ? 12 : 16),
                  _buildInfoRow(
                    Icons.notes_rounded,
                    'Details',
                    details,
                    isMobile,
                    isMultiline: true,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final String customerName, city, phone, address, plantName, price;
  final int quantity;
  final dynamic createdAt;

  const _OrderCard({
    required this.customerName,
    required this.city,
    required this.phone,
    required this.address,
    required this.plantName,
    required this.quantity,
    required this.price,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: isMobile ? 12 : 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFf59E0B).withOpacity(0.05),
                  const Color(0xFFf59E0B).withOpacity(0.02),
                ],
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(isMobile ? 16 : 20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: isMobile ? 40 : 48,
                  height: isMobile ? 40 : 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFf59E0B),
                        const Color(0xFFf59E0B).withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFf59E0B).withOpacity(0.3),
                        blurRadius: isMobile ? 8 : 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.local_florist_rounded,
                    color: Colors.white,
                    size: isMobile ? 18 : 22,
                  ),
                ),
                SizedBox(width: isMobile ? 12 : 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customerName,
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.w800,
                          color: kForest,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isMobile ? 2 : 4),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 8 : 12,
                          vertical: isMobile ? 4 : 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFf59E0B).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            isMobile ? 16 : 20,
                          ),
                          border: Border.all(
                            color: const Color(0xFFf59E0B).withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          '$plantName (×$quantity) - $price',
                          style: TextStyle(
                            color: const Color(0xFFf59E0B),
                            fontWeight: FontWeight.w700,
                            fontSize: isMobile ? 10 : 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(createdAt, isMobile),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stack on mobile
                if (isMobile) ...[
                  _buildInfoRow(
                    Icons.location_city_rounded,
                    'City',
                    city,
                    isMobile,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.phone_rounded, 'Phone', phone, isMobile),
                  const SizedBox(height: 12),
                ] else ...[
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoRow(
                          Icons.location_city_rounded,
                          'City',
                          city,
                          isMobile,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildInfoRow(
                          Icons.phone_rounded,
                          'Phone',
                          phone,
                          isMobile,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                _buildInfoRow(
                  Icons.location_on_rounded,
                  'Address',
                  address,
                  isMobile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ============================ RESPONSIVE STATES ============================ */

class _LoadingState extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _LoadingState({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 20 : 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 16 : 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: isMobile ? 12 : 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: isMobile ? 24 : 32),
            ),
            SizedBox(height: isMobile ? 16 : 24),
            CircularProgressIndicator(color: color),
            SizedBox(height: isMobile ? 12 : 16),
            Text(
              'Loading data...',
              style: TextStyle(
                color: const Color(0xFF64748B),
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title, description;
  final Color color;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 24 : 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 16 : 24),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
                border: Border.all(color: color.withOpacity(0.2)),
              ),
              child: Icon(
                icon,
                size: isMobile ? 32 : 48,
                color: color.withOpacity(0.7),
              ),
            ),
            SizedBox(height: isMobile ? 16 : 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w800,
                color: kForest,
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF64748B),
                height: 1.6,
                fontSize: isMobile ? 13 : 15,
              ),
            ),
            SizedBox(height: isMobile ? 20 : 28),
            Container(
              padding: EdgeInsets.all(isMobile ? 12 : 16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.05),
                borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
                border: Border.all(color: color.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lightbulb_rounded,
                    color: color,
                    size: isMobile ? 16 : 18,
                  ),
                  SizedBox(width: isMobile ? 6 : 8),
                  Flexible(
                    child: Text(
                      'Use the Debug button to add test data!',
                      style: TextStyle(
                        color: kForest,
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 11 : 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final IconData icon;
  final String collection;
  final String error;
  final Color color;

  const _ErrorState({
    required this.icon,
    required this.collection,
    required this.error,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 24 : 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 16 : 24),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withOpacity(0.1),
                borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
                border: Border.all(
                  color: const Color(0xFFEF4444).withOpacity(0.2),
                ),
              ),
              child: Icon(
                Icons.error_rounded,
                size: isMobile ? 32 : 48,
                color: const Color(0xFFEF4444),
              ),
            ),
            SizedBox(height: isMobile ? 16 : 24),
            Text(
              'Unable to Load Data',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w800,
                color: const Color(0xFFEF4444),
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Text(
              'There was an issue loading your data. Please check your connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF64748B),
                height: 1.6,
                fontSize: isMobile ? 13 : 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ============================ RESPONSIVE HELPERS ============================ */

Widget _buildInfoRow(
  IconData icon,
  String label,
  String value,
  bool isMobile, {
  bool isMultiline = false,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(isMobile ? 4 : 6),
        decoration: BoxDecoration(
          color: const Color(0xFF64748B).withOpacity(0.1),
          borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
        ),
        child: Icon(
          icon,
          size: isMobile ? 14 : 16,
          color: const Color(0xFF64748B),
        ),
      ),
      SizedBox(width: isMobile ? 8 : 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: isMobile ? 10 : 12,
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: isMobile ? 2 : 4),
            Text(
              value.isEmpty ? '—' : value,
              style: TextStyle(
                fontSize: isMobile ? 13 : 15,
                color: kForest,
                fontWeight: FontWeight.w600,
                height: isMultiline ? 1.5 : 1.2,
              ),
              maxLines: isMultiline ? null : 2,
              overflow: isMultiline
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildStatusChip(dynamic timestamp, bool isMobile) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 8 : 12,
      vertical: isMobile ? 4 : 8,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(isMobile ? 12 : 20),
      border: Border.all(color: const Color(0xFFE2E8F0)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: isMobile ? 4 : 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      _formatTimestamp(timestamp),
      style: TextStyle(
        fontSize: isMobile ? 9 : 11,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF64748B),
      ),
    ),
  );
}

// Helper functions remain the same
String _formatTimestamp(dynamic ts) {
  try {
    if (ts is Timestamp) {
      final d = ts.toDate();
      final now = DateTime.now();
      final diff = now.difference(d);

      if (diff.inDays == 0) {
        return '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
      } else if (diff.inDays == 1) {
        return 'Yesterday';
      } else if (diff.inDays < 7) {
        return '${diff.inDays}d ago';
      } else {
        return '${d.day}/${d.month}/${d.year}';
      }
    }
    return '—';
  } catch (_) {
    return '—';
  }
}

String _formatISODate(dynamic dateValue) {
  try {
    if (dateValue is String) {
      final date = DateTime.parse(dateValue);
      return '${date.day}/${date.month}/${date.year}';
    }
    return '—';
  } catch (_) {
    return '—';
  }
}

String _formatSubject(String subject) {
  switch (subject) {
    case 'quote':
      return 'Request a Quote';
    case 'question':
      return 'General Question';
    case 'complaint':
      return 'Service Issue';
    case 'compliment':
      return 'Compliment';
    case 'other':
      return 'Other';
    default:
      return subject;
  }
}

String _formatService(String service) {
  switch (service) {
    case 'maintenance':
      return 'Lawn Maintenance';
    case 'fertilization':
      return 'Fertilization & Care';
    case 'makeover':
      return 'Seasonal Makeover';
    case 'plants':
      return 'Plant Installation';
    case 'turf':
      return 'Turf Solutions';
    case 'consultation':
      return 'Free Consultation';
    default:
      return service;
  }
}

String _formatFrequency(String frequency) {
  switch (frequency) {
    case 'weekly':
      return 'Weekly Service';
    case 'bi-weekly':
      return 'Bi-Weekly Service';
    case 'monthly':
      return 'Monthly Service';
    case 'seasonal':
      return 'Seasonal Only';
    case 'one-time':
      return 'One-Time Service';
    default:
      return frequency;
  }
}

String _formatSize(String size) {
  switch (size) {
    case 'small':
      return 'Small (Under 5,000 sq ft)';
    case 'medium':
      return 'Medium (5,000–10,000 sq ft)';
    case 'large':
      return 'Large (10,000–20,000 sq ft)';
    case 'xlarge':
      return 'Extra Large (20,000+ sq ft)';
    default:
      return size;
  }
}
