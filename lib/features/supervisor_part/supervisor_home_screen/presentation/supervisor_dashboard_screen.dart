import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupervisorDashboardScreen extends StatefulWidget {
  const SupervisorDashboardScreen({super.key});

  @override
  State<SupervisorDashboardScreen> createState() =>
      _SupervisorDashboardScreenState();
}

class _SupervisorDashboardScreenState extends State<SupervisorDashboardScreen> {
  // Demo Operational Statistics
  final double _monthlySales = 284500.0;
  final double _monthlyCollection = 215000.0;
  final double _monthlyExpense = 18400.0;
  final int _activeStaff = 12;

  // 10 Core Supervisor Modules Defined
  final List _dashboardModules = [
    // {
    //   'id': 'view_employee',
    //   'title': 'view Employee',
    //   'subtitle': 'Register field officer',
    //   'icon': Icons.person_add_alt_1_rounded,
    //   'color': const Color(0xFF10B981), // Emerald Green
    //   'badge': 'HR',
    // },
    // {
    //   'id': 'add_customer',
    //   'title': 'Add Customer',
    //   'subtitle': 'New shop registration',
    //   'icon': Icons.storefront_rounded,
    //   'color': const Color(0xFF059669), // Deep Emerald
    //   'badge': null,
    // },
    // {
    //   'id': 'sales',
    //   'title': 'Sales',
    //   'subtitle': 'Order booking & targets',
    //   'icon': Icons.trending_up_rounded,
    //   'color': const Color(0xFF0D9488), // Teal
    //   'badge': '৳284K',
    // },
    {
      'id': 'expense',
      'title': 'Expense',
      'subtitle': 'Fuel, TA/DA & bills',
      'icon': Icons.receipt_long_rounded,
      'color': const Color(0xFFE11D48), // Rose Red
      'badge': null,
    },
    {
      'id': 'catalog',
      'title': 'Catalog',
      'subtitle': 'Egg stock & crate rates',
      'icon': Icons.inventory_2_outlined,
      'color': const Color(0xFF0284C7), // Sky Blue
      'badge': null,
    },
    {
      'id': 'tour_plan',
      'title': 'Tour Plan',
      'subtitle': 'Field routes & roster',
      'icon': Icons.map_outlined,
      'color': const Color(0xFF7C3AED), // Violet
      'badge': '3 Pending',
    },
    {
      'id': 'leave_apply',
      'title': 'Leave Apply',
      'subtitle': 'Staff approvals & requests',
      'icon': Icons.event_note_rounded,
      'color': const Color(0xFFF59E0B), // Amber
      'badge': '2 New',
    },
    {
      'id': 'view_reports',
      'title': 'View Reports',
      'subtitle': 'PDF & Excel statements',
      'icon': Icons.assessment_outlined,
      'color': const Color(0xFF0F766E), // Dark Cyan
      'badge': 'Export',
    },
    {
      'id': 'learning_points',
      'title': 'Learning Points',
      'subtitle': 'SOPs, rules & materials',
      'icon': Icons.menu_book_rounded,
      'color': const Color(0xFF4338CA), // Indigo
      'badge': 'Docs',
    },
  ];

  void _onModuleTap(Map<String, dynamic> module) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Navigating to ${module['title']}...',
          style: GoogleFonts.outfit(),
        ),
        backgroundColor: const Color(0xFF059669),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Pristine Fresh Green & White Background
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFECFDF5),
                  Color(0xFFF0FDF4),
                  Color(0xFFFFFFFF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 2. Ambient Floating Glowing Spheres
          Positioned(
            top: -50,
            right: -40,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF34D399).withOpacity(0.32),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withOpacity(0.3),
                    blurRadius: 90,
                    spreadRadius: 25,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: -40,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFA7F3D0).withOpacity(0.35),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF059669).withOpacity(0.18),
                    blurRadius: 100,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),

          // 3. Main Scrollable Dashboard Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar Header
                  _buildTopHeader(),
                  const SizedBox(height: 16),

                  // High-level Performance KPI Card
                  _buildExecutiveKPICard(),
                  const SizedBox(height: 22),

                  // Section Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SUPERVISORY WORKSPACE (10)',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                          color: const Color(0xFF064E3B).withOpacity(0.75),
                        ),
                      ),
                      Text(
                        'Direct Operations',
                        style: GoogleFonts.outfit(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF059669),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // The 10 Essential Modules in 2-Column Responsive Grid
                  _buildModulesGrid(),

                  const SizedBox(height: 90), // Bottom navigation clearance
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Top App Bar Header
  Widget _buildTopHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: Color(0xFF064E3B),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Operations Hub',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF064E3B),
                  ),
                ),
                Text(
                  'Enterprise monitoring & branch oversight',
                  style: GoogleFonts.outfit(
                    fontSize: 11.5,
                    color: const Color(0xFF059669),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                'LIVE SYNC',
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF064E3B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Executive KPI Card (Sales, Collections, Expenses, Staff)
  Widget _buildExecutiveKPICard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF064E3B).withOpacity(0.06),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'MONTHLY METRICS OVERVIEW',
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  Text(
                    '$_activeStaff Officers Fielded',
                    style: GoogleFonts.outfit(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF059669),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _buildKPIMetricItem(
                    'Team Sales',
                    '৳${(_monthlySales / 1000).toStringAsFixed(1)}K',
                    const Color(0xFF059669),
                  ),
                  _buildKPIMetricItem(
                    'Collection',
                    '৳${(_monthlyCollection / 1000).toStringAsFixed(1)}K',
                    const Color(0xFF0D9488),
                  ),
                  _buildKPIMetricItem(
                    'Total Expense',
                    '৳${(_monthlyExpense / 1000).toStringAsFixed(1)}K',
                    const Color(0xFFE11D48),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKPIMetricItem(String label, String value, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // 10 Core Modules in a 2-Column Grid
  Widget _buildModulesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _dashboardModules.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.35,
      ),
      itemBuilder: (context, index) {
        final item = _dashboardModules[index];
        final Color color = item['color'] as Color;
        final String? badge = item['badge'] as String?;

        return InkWell(
          onTap: () => _onModuleTap(item),
          borderRadius: BorderRadius.circular(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.74),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 1.8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF064E3B).withOpacity(0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            size: 20,
                            color: color,
                          ),
                        ),
                        if (badge != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2.5,
                            ),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.14),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              badge,
                              style: GoogleFonts.outfit(
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['title'] as String,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      item['subtitle'] as String,
                      style: GoogleFonts.outfit(
                        fontSize: 10.5,
                        color: const Color(0xFF64748B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
