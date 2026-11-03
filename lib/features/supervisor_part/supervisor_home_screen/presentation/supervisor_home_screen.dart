// ignore_for_file: prefer_final_fields, unused_field, unused_element, deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location_tracker/helpers/all_routes.dart';
import 'package:location_tracker/helpers/navigation_service.dart';

class SupervisorHomeScreen extends StatefulWidget {
  const SupervisorHomeScreen({super.key});

  @override
  State<SupervisorHomeScreen> createState() => _SupervisorHomeScreenState();
}

class _SupervisorHomeScreenState extends State<SupervisorHomeScreen> {
  // Supervisor Info
  final String _supervisorName = "Nayem Supervisor";
  final String _designation = "Territory Field Supervisor";
  final String _assignedTerritory = "Gazipur & Tongi Zone";

  // Real-time GPS & Device Info
  double _latitude = 23.8983;
  double _longitude = 90.4035;
  String _currentAddress = "Tongi Station Road, Gazipur";
  int _batteryLevel = 91;

  // Supervisor Own Attendance Duty States
  bool _isCheckedIn = false;
  bool _isCheckedOut = false;
  String _inTime = "--:--";
  String _outTime = "--:--";
  String _workingHours = "0h 0m";
  bool _isAttendanceLoading = false;

  // Team Analytics Summary
  final int _activeOfficersCount = 8;
  final int _totalTeamOfficers = 10;
  final double _teamTodaySales = 74500.0;
  final double _teamTodayCollection = 42800.0;
  final int _pendingLeaves = 3;
  final int _pendingTours = 2;

  // Attendance Check-in / Check-out Handler
  void _handleAttendanceToggle() async {
    if (_isCheckedOut) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ajker duty check-out already done!',
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF064E3B),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isAttendanceLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isAttendanceLoading = false;
      if (!_isCheckedIn) {
        _isCheckedIn = true;
        _inTime = "08:50 AM";
      } else {
        _isCheckedOut = true;
        _outTime = "05:30 PM";
        _workingHours = "8h 40m";
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isCheckedOut
              ? 'Supervisor Duty Ended! Checked-Out at $_outTime'
              : 'Supervisor Duty Started! Checked-In at $_inTime',
          style: GoogleFonts.outfit(color: Colors.white),
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
          // 1. Pristine Fresh Green & White Gradient Background
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

          // 2. Ambient Floating Glowing Orbs
          Positioned(
            top: -60,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF34D399).withOpacity(0.32),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withOpacity(0.3),
                    blurRadius: 100,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 360,
            left: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFA7F3D0).withOpacity(0.35),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF059669).withOpacity(0.18),
                    blurRadius: 110,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),

          // 3. Main Dashboard View
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Supervisor Header Bar
                  _buildSupervisorHeader(),
                  const SizedBox(height: 18),

                  // Real-time GPS Tracker Card
                  _buildLiveTrackingCard(),
                  const SizedBox(height: 16),

                  // Supervisor Own Check-In / Check-Out Duty Card
                  _buildAttendanceActionCard(),
                  const SizedBox(height: 22),

                  // Team Performance & Field Operations Card
                  _buildTeamSummaryCard(),
                  const SizedBox(height: 24),

                  // Supervisor Operational Grid
                  Text(
                    'SUPERVISOR CONTROLS',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: const Color(0xFF064E3B).withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSupervisorControlGrid(),

                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 1. Top Supervisor Header
  Widget _buildSupervisorHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF047857)],
                ),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF059669).withOpacity(0.28),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.shield_outlined,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _supervisorName,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF064E3B),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'LEAD',
                        style: GoogleFonts.outfit(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF047857),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  _assignedTerritory,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF059669),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            size: 20,
            color: Color(0xFF064E3B),
          ),
        ),
      ],
    );
  }

  // 2. Real-Time GPS Tracking Card
  Widget _buildLiveTrackingCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.72),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF064E3B).withOpacity(0.06),
                blurRadius: 24,
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.radar_rounded,
                          size: 18,
                          color: Color(0xFF059669),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Live Field GPS Status',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF064E3B),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _batteryLevel > 20
                              ? Icons.battery_charging_full_rounded
                              : Icons.battery_alert_rounded,
                          size: 15,
                          color: _batteryLevel > 20
                              ? const Color(0xFF059669)
                              : Colors.redAccent,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$_batteryLevel%',
                          style: GoogleFonts.outfit(
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 17,
                    color: Color(0xFF059669),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _currentAddress,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lat: ${_latitude.toStringAsFixed(6)}',
                      style: GoogleFonts.outfit(
                        fontSize: 11.5,
                        color: const Color(0xFF475569),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 14,
                      color: const Color(0xFFCBD5E1),
                    ),
                    Text(
                      'Lng: ${_longitude.toStringAsFixed(6)}',
                      style: GoogleFonts.outfit(
                        fontSize: 11.5,
                        color: const Color(0xFF475569),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 3. Supervisor Check-In / Check-Out Duty Toggle Card
  Widget _buildAttendanceActionCard() {
    String buttonText = "Start Supervisor Duty (Check-In)";
    Color buttonGradientStart = const Color(0xFF10B981);
    Color buttonGradientEnd = const Color(0xFF047857);

    if (_isCheckedIn && !_isCheckedOut) {
      buttonText = "End Supervisor Duty (Check-Out)";
      buttonGradientStart = const Color(0xFFEF4444);
      buttonGradientEnd = const Color(0xFFB91C1C);
    } else if (_isCheckedOut) {
      buttonText = "Supervisor Duty Completed";
    }

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
                color: const Color(0xFF064E3B).withOpacity(0.07),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDutyTimeBlock('IN TIME', _inTime, Icons.login_rounded),
                  Container(
                    width: 1,
                    height: 35,
                    color: const Color(0xFFE2E8F0),
                  ),
                  _buildDutyTimeBlock(
                    'OUT TIME',
                    _outTime,
                    Icons.logout_rounded,
                  ),
                  Container(
                    width: 1,
                    height: 35,
                    color: const Color(0xFFE2E8F0),
                  ),
                  _buildDutyTimeBlock(
                    'WORKING',
                    _workingHours,
                    Icons.hourglass_bottom_rounded,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: (_isAttendanceLoading || _isCheckedOut)
                    ? null
                    : _handleAttendanceToggle,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: _isCheckedOut
                        ? LinearGradient(
                            colors: [
                              Colors.grey.shade400,
                              Colors.grey.shade600,
                            ],
                          )
                        : LinearGradient(
                            colors: [buttonGradientStart, buttonGradientEnd],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: _isCheckedOut
                            ? Colors.black12
                            : buttonGradientStart.withOpacity(0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: _isAttendanceLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.2,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _isCheckedIn && !_isCheckedOut
                                    ? Icons.stop_circle_outlined
                                    : Icons.play_circle_outline_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                buttonText,
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDutyTimeBlock(String label, String value, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 13, color: const Color(0xFF059669)),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF064E3B),
          ),
        ),
      ],
    );
  }

  // 4. Team Performance Card
  Widget _buildTeamSummaryCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF064E3B).withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 10),
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
                    "TEAM PERFORMANCE OVERSIGHT",
                    style: GoogleFonts.outfit(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                      color: const Color(0xFF064E3B).withOpacity(0.8),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.14),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$_activeOfficersCount/$_totalTeamOfficers Active',
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        color: const Color(0xFF047857),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _buildMetricItem(
                    'Active Team',
                    '$_activeOfficersCount Men',
                    Icons.people_alt_outlined,
                    const Color(0xFF059669),
                  ),
                  _buildMetricItem(
                    'Team Sales',
                    '৳${_teamTodaySales.toStringAsFixed(0)}',
                    Icons.trending_up_rounded,
                    const Color(0xFF0D9488),
                  ),
                  _buildMetricItem(
                    'Collected',
                    '৳${_teamTodayCollection.toStringAsFixed(0)}',
                    Icons.account_balance_wallet_outlined,
                    const Color(0xFF047857),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricItem(
    String title,
    String val,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(height: 6),
          Text(
            val,
            style: GoogleFonts.outfit(
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF064E3B),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 10.5,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // 5. Supervisor Operations Control Grid (Dashboard, Employee, Customer, Leaves, Tours)
  Widget _buildSupervisorControlGrid() {
    final List menu = [
      {
        'title': 'Dashboard',
        'subtitle': 'Analytics & team KPI',
        'icon': Icons.insights_rounded,
        'color': const Color(0xFF059669),
        'badge': null,
        'action': 'dashboard',
      },
      {
        'title': 'View Employee',
        'subtitle': 'Team roster & status',
        'icon': Icons.groups_2_rounded,
        'color': const Color(0xFF10B981),
        'badge': '$_totalTeamOfficers Staff',
        'action': 'view_employee',
      },
      {
        'title': 'View Customer',
        'subtitle': 'Shops & market due',
        'icon': Icons.storefront_rounded,
        'color': const Color(0xFF0D9488),
        'badge': null,
        'action': 'view_customer',
      },
      {
        'title': 'View Collection',
        'subtitle': 'Due recovery & payments',
        'icon': Icons.account_balance_wallet_outlined,
        'color': const Color(0xFF047857), // Forest Green
        'badge': '৳215K',
        'action': 'view_leave_request',
      },
      {
        'title': 'View Leave Request',
        'subtitle': 'Review employee leaves',
        'icon': Icons.event_note_rounded,
        'color': const Color(0xFFEAB308),
        'badge': '$_pendingLeaves Pending',
        'action': 'view_leave_request',
      },
      {
        'title': 'View Tour Request',
        'subtitle': 'Market visiting routes',
        'icon': Icons.route_rounded,
        'color': const Color(0xFF0284C7),
        'badge': '$_pendingTours New',
        'action': 'view_tour_request',
      },
      {
        'title': 'Product Catalog',
        'subtitle': 'Stock & box prices',
        'icon': Icons.inventory_2_outlined,
        'color': const Color(0xFF047857),
        'badge': null,
        'action': 'catalog',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menu.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) {
        final item = menu[index];
        final badge = item['badge'] as String?;

        return InkWell(
          onTap: () {
            if (item['action'] == 'dashboard') {
              NavigationService.navigateTo(Routes.supervisorDashboard);
            } else if (item['action'] == 'take_order') {
              NavigationService.navigateTo(Routes.takeOrder);
            } else if (item['action'] == 'collect_due') {
              NavigationService.navigateTo(Routes.collectDue);
            } else if (item['action'] == 'catalog') {
              NavigationService.navigateTo(Routes.catalogScreen);
            } else if (item['action'] == 'tour_plan') {
              NavigationService.navigateTo(Routes.tourPlanScreen);
            } else if (item['action'] == 'leave_app') {
              NavigationService.navigateTo(Routes.leaveScreen);
            }
          },
          borderRadius: BorderRadius.circular(18),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.74),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white, width: 1.6),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF064E3B).withOpacity(0.05),
                      blurRadius: 18,
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
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: (item['color'] as Color).withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            size: 19,
                            color: item['color'] as Color,
                          ),
                        ),
                        if (badge != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (item['color'] as Color).withOpacity(0.14),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              badge,
                              style: GoogleFonts.outfit(
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                                color: (item['color'] as Color),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['title'] as String,
                      style: GoogleFonts.outfit(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF064E3B),
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
