import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupervisorViewEmployeeScreen extends StatefulWidget {
  const SupervisorViewEmployeeScreen({super.key});

  @override
  State<SupervisorViewEmployeeScreen> createState() => _SupervisorViewEmployeeScreenState();
}

class _SupervisorViewEmployeeScreenState extends State<SupervisorViewEmployeeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  // Demo Assigned Employees List (api_supervisor_employees.php theke dynamic hobe)
  final List _teamEmployees = [
    {
      'id': 'EMP-101',
      'name': 'Rahim Ahmed',
      'designation': 'Field Sales Executive',
      'phone': '01711223344',
      'email': 'rahim.sales@company.com',
      'territory': 'Tongi Station Road & Bazar',
      'status': 'active', // 'active', 'on_leave', 'absent'
      'in_time': '09:05 AM',
      'today_orders': 4,
      'today_sales': 18450.0,
      'battery': 84,
      'current_lat': 23.8983,
      'current_lng': 90.4035,
      'last_location': 'Station Road, Tongi, Gazipur',
    },
    {
      'id': 'EMP-102',
      'name': 'Kamrul Hasan',
      'designation': 'Senior Sales Officer',
      'phone': '01811556677',
      'email': 'kamrul.officer@company.com',
      'territory': 'Gazipur Chowrasta & Chandana',
      'status': 'active',
      'in_time': '09:32 AM',
      'today_orders': 6,
      'today_sales': 26800.0,
      'battery': 67,
      'current_lat': 23.9981,
      'current_lng': 90.3789,
      'last_location': 'Chowrasta Bazar, Gazipur',
    },
    {
      'id': 'EMP-103',
      'name': 'Tanvir Hossain',
      'designation': 'Field Executive',
      'phone': '01911998877',
      'email': 'tanvir.field@company.com',
      'territory': 'Board Bazar & National University',
      'status': 'active',
      'in_time': '08:58 AM',
      'today_orders': 3,
      'today_sales': 14200.0,
      'battery': 92,
      'current_lat': 23.9482,
      'current_lng': 90.3792,
      'last_location': 'Board Bazar, Gazipur',
    },
    {
      'id': 'EMP-104',
      'name': 'Mehedi Hasan',
      'designation': 'Junior Sales Officer',
      'phone': '01611334455',
      'email': 'mehedi.rep@company.com',
      'territory': 'Konabari Industrial Market',
      'status': 'on_leave',
      'in_time': '--:--',
      'today_orders': 0,
      'today_sales': 0.0,
      'battery': 0,
      'current_lat': null,
      'current_lng': null,
      'last_location': 'Approved Sick Leave',
    },
    {
      'id': 'EMP-105',
      'name': 'Sabbir Hossain',
      'designation': 'Field Sales Executive',
      'phone': '01511889900',
      'email': 'sabbir.sales@company.com',
      'territory': 'Joydebpur Sadar & Rail Gate',
      'status': 'absent',
      'in_time': '--:--',
      'today_orders': 0,
      'today_sales': 0.0,
      'battery': 0,
      'current_lat': null,
      'current_lng': null,
      'last_location': 'Not Checked In',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List get _filteredEmployees {
    final query = _searchController.text.toLowerCase().trim();
    return _teamEmployees.where((emp) {
      final matchesSearch = emp['name'].toString().toLowerCase().contains(query) ||
          emp['id'].toString().toLowerCase().contains(query) ||
          emp['territory'].toString().toLowerCase().contains(query);

      final matchesFilter = _selectedFilter == 'All' ||
          (_selectedFilter == 'Active' && emp['status'] == 'active') ||
          (_selectedFilter == 'On Leave' && emp['status'] == 'on_leave') ||
          (_selectedFilter == 'Absent' && emp['status'] == 'absent');

      return matchesSearch && matchesFilter;
    }).toList();
  }

  // Employee Detail & Live Action Bottom Sheet
  void _showEmployeeDetailsModal(Map<String, dynamic> emp) {
    final bool isActive = emp['status'] == 'active';
    final bool isOnLeave = emp['status'] == 'on_leave';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.96),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 4.5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Employee Profile Summary Row
                Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF047857)],
                        ),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.person_rounded, size: 30, color: Colors.white),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                emp['name'],
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? const Color(0xFFD1FAE5)
                                      : (isOnLeave ? const Color(0xFFFEF3C7) : const Color(0xFFFEE2E2)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  isActive ? 'IN FIELD' : (isOnLeave ? 'ON LEAVE' : 'ABSENT'),
                                  style: GoogleFonts.outfit(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold,
                                    color: isActive
                                        ? const Color(0xFF047857)
                                        : (isOnLeave ? const Color(0xFFB45309) : const Color(0xFFDC2626)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${emp['id']} • ${emp['designation']}',
                            style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Location / Check-In Spot Info
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFF059669), size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          emp['last_location'],
                          style: GoogleFonts.outfit(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      if (isActive)
                        Text(
                          'Battery: ${emp['battery']}%',
                          style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF047857)),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Today Sales vs Orders Stats
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('TODAY BOOKED', style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF64748B))),
                            const SizedBox(height: 2),
                            Text('${emp['today_orders']} Shops', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF064E3B))),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('SALES AMOUNT', style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF64748B))),
                            const SizedBox(height: 2),
                            Text('৳${emp['today_sales'].toStringAsFixed(0)}', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF059669))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Action Buttons (Call / Track / Report)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Calling ${emp['phone']}...', style: GoogleFonts.outfit()), backgroundColor: const Color(0xFF059669)),
                          );
                        },
                        icon: const Icon(Icons.phone_in_talk_rounded, size: 16, color: Colors.white),
                        label: Text('Direct Call', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF059669),
                          minimumSize: const Size(double.infinity, 46),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    if (isActive && emp['current_lat'] != null) ...[
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Opening GPS Map for ${emp['name']}...', style: GoogleFonts.outfit()), backgroundColor: const Color(0xFF047857)),
                            );
                          },
                          icon: const Icon(Icons.radar_rounded, size: 16, color: Color(0xFF047857)),
                          label: Text('Live Map', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: const Color(0xFF047857))),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF047857), width: 1.5),
                            minimumSize: const Size(double.infinity, 46),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final employees = _filteredEmployees;

    final int totalCount = _teamEmployees.length;
    final int activeCount = _teamEmployees.where((e) => e['status'] == 'active').length;
    final int leaveCount = _teamEmployees.where((e) => e['status'] == 'on_leave').length;
    final int absentCount = _teamEmployees.where((e) => e['status'] == 'absent').length;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Pristine Fresh Green & White Background
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFECFDF5), Color(0xFFF0FDF4), Color(0xFFFFFFFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 2. Ambient Floating Glowing Orbs
          Positioned(
            top: -40,
            right: -30,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF34D399).withOpacity(0.35),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF10B981).withOpacity(0.35), blurRadius: 90, spreadRadius: 25),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: -40,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFA7F3D0).withOpacity(0.35),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF059669).withOpacity(0.2), blurRadius: 100, spreadRadius: 30),
                ],
              ),
            ),
          ),

          // 3. Main Screen View
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
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
                                'My Team Officers',
                                style: GoogleFonts.outfit(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              Text(
                                'Field staff roster & live location status',
                                style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF059669)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.14),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
                        ),
                        child: Text(
                          '$totalCount Staff',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF047857),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Team Status Overview KPI
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.76),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            _buildKPIStat('In Field', '$activeCount', const Color(0xFF10B981)),
                            Container(width: 1, height: 28, color: const Color(0xFFE2E8F0)),
                            _buildKPIStat('On Leave', '$leaveCount', const Color(0xFFF59E0B)),
                            Container(width: 1, height: 28, color: const Color(0xFFE2E8F0)),
                            _buildKPIStat('Absent', '$absentCount', const Color(0xFFEF4444)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF064E3B).withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() {}),
                      style: GoogleFonts.outfit(fontSize: 13.5, color: const Color(0xFF0F172A)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        hintText: 'Search officer by name, ID or route...',
                        hintStyle: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF94A3B8)),
                        prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF059669), size: 20),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded, size: 18, color: Color(0xFF64748B)),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Filter Tabs (All, Active, On Leave, Absent)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      _buildFilterChip('All'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Active'),
                      const SizedBox(width: 8),
                      _buildFilterChip('On Leave'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Absent'),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Employees List / Empty State
                Expanded(
                  child: employees.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.person_search_rounded, size: 40, color: Color(0xFF059669)),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No Staff Found',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Try matching officer name or territory name',
                                style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF64748B)),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                          itemCount: employees.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final emp = employees[index];
                            final status = emp['status'] as String;

                            Color badgeColor;
                            String badgeLabel;

                            if (status == 'active') {
                              badgeColor = const Color(0xFF10B981);
                              badgeLabel = 'ACTIVE';
                            } else if (status == 'on_leave') {
                              badgeColor = const Color(0xFFF59E0B);
                              badgeLabel = 'ON LEAVE';
                            } else {
                              badgeColor = const Color(0xFFEF4444);
                              badgeLabel = 'ABSENT';
                            }

                            return InkWell(
                              onTap: () => _showEmployeeDetailsModal(emp),
                              borderRadius: BorderRadius.circular(20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.76),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.white, width: 1.8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF064E3B).withOpacity(0.05),
                                          blurRadius: 16,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Top Row: Avatar, Name & Status Badge
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 44,
                                              height: 44,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: const LinearGradient(
                                                  colors: [Color(0xFF10B981), Color(0xFF047857)],
                                                ),
                                              ),
                                              child: const Icon(Icons.person_rounded, size: 24, color: Colors.white),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    emp['name'],
                                                    style: GoogleFonts.outfit(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: const Color(0xFF0F172A),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${emp['id']} • ${emp['designation']}',
                                                    style: GoogleFonts.outfit(fontSize: 11.5, color: const Color(0xFF64748B)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                              decoration: BoxDecoration(
                                                color: badgeColor.withOpacity(0.14),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                badgeLabel,
                                                style: GoogleFonts.outfit(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: badgeColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const Divider(height: 18, color: Color(0xFFE2E8F0)),

                                        // Territory Route & Phone
                                        Row(
                                          children: [
                                            const Icon(Icons.route_outlined, size: 14, color: Color(0xFF059669)),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                emp['territory'],
                                                style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF475569)),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.phone_outlined, size: 13, color: Color(0xFF64748B)),
                                                const SizedBox(width: 4),
                                                Text(
                                                  emp['phone'],
                                                  style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF64748B)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'View Actions',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 11.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(0xFF059669),
                                                  ),
                                                ),
                                                const SizedBox(width: 2),
                                                const Icon(Icons.arrow_forward_ios_rounded, size: 11, color: Color(0xFF059669)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKPIStat(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
          Text(
            label,
            style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final bool isSelected = _selectedFilter == label;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = label;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF059669) : Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: isSelected ? const Color(0xFF059669) : const Color(0xFFE2E8F0)),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 11.5,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFF475569),
            ),
          ),
        ),
      ),
    );
  }
}