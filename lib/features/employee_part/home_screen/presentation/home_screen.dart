import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location_tracker/common_widgets/common_import.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Demo Officer Information
  final String _officerName = "Rahim Ahmed";
  final String _designation = "Field Sales Executive";

  // Real-time Device Tracking States
  double _latitude = 23.7925;
  double _longitude = 90.4078;
  String _currentAddress = "Gulshan 1 Circle, Dhaka";
  int _batteryLevel = 84;

  // Attendance Toggle States
  bool _isCheckedIn = false;
  bool _isCheckedOut = false;
  String _inTime = "--:--";
  String _outTime = "--:--";
  String _workingHours = "0h 0m";
  bool _isAttendanceLoading = false;

  // Today's Performance Metrics
  final int _todayOrders = 4;
  final double _todaySales = 18450.0;
  final double _todayCollection = 9200.0;

  // Check-In / Check-Out Action
  void _handleAttendanceToggle() async {
    if (_isCheckedOut) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ajker diner duty check-out already complete hoyeche!',
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
        _inTime = "09:05 AM";
      } else {
        _isCheckedOut = true;
        _outTime = "05:15 PM";
        _workingHours = "8h 10m";
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isCheckedOut
              ? 'Duty Closed! Successfully Checked-Out.'
              : 'Duty Started! Successfully Checked-In at $_inTime',
          style: GoogleFonts.outfit(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF059669),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // Add Customer / New Shop Modal
  void _showAddCustomerModal() {
    final shopNameController = TextEditingController();
    final ownerNameController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController(text: _currentAddress);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.96),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: SingleChildScrollView(
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
                    Text(
                      'Add New Customer / Shop',
                      style: GoogleFonts.outfit(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF064E3B),
                      ),
                    ),
                    Text(
                      'Register shop with realtime pinpoint GPS location',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Shop Name
                    _buildModalTextField(
                      'Shop Name',
                      'e.g. Bismillah General Store',
                      Icons.store_rounded,
                      shopNameController,
                    ),
                    const SizedBox(height: 12),

                    // Owner Name
                    _buildModalTextField(
                      'Owner Name',
                      'e.g. Haji Mohammad Ali',
                      Icons.person_outline_rounded,
                      ownerNameController,
                    ),
                    const SizedBox(height: 12),

                    // Phone Number
                    _buildModalTextField(
                      'Mobile Number',
                      'e.g. 017XXXXXXXX',
                      Icons.phone_android_rounded,
                      phoneController,
                      isPhone: true,
                    ),
                    const SizedBox(height: 12),

                    // Address with current GPS coordinates badge
                    _buildModalTextField(
                      'Shop Address / Area',
                      'Road, Market details',
                      Icons.location_on_outlined,
                      addressController,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Auto GPS: $_latitude, $_longitude',
                      style: GoogleFonts.outfit(
                        fontSize: 10.5,
                        color: const Color(0xFF059669),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Submit Button
                    ElevatedButton(
                      onPressed: () {
                        if (shopNameController.text.trim().isEmpty ||
                            phoneController.text.trim().isEmpty) {
                          return;
                        }
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'New Customer Added Successfully!',
                              style: GoogleFonts.outfit(),
                            ),
                            backgroundColor: const Color(0xFF059669),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF059669),
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Save Shop Profile',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalTextField(
    String label,
    String hint,
    IconData icon,
    TextEditingController controller, {
    bool isPhone = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextField(
            controller: controller,
            keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
            style: GoogleFonts.outfit(
              fontSize: 13,
              color: const Color(0xFF0F172A),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.outfit(
                fontSize: 12.5,
                color: const Color(0xFF94A3B8),
              ),
              prefixIcon: Icon(icon, size: 18, color: const Color(0xFF059669)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
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
            top: 340,
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

          // 3. Main Dashboard Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopHeader(),
                  const SizedBox(height: 18),
                  _buildLiveTrackingCard(),
                  const SizedBox(height: 16),
                  _buildAttendanceActionCard(),
                  const SizedBox(height: 22),
                  _buildTodayPerformanceCard(),
                  const SizedBox(height: 24),

                  // Operational Services
                  Text(
                    'OPERATIONAL SERVICES',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: const Color(0xFF064E3B).withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildOperationalServicesGrid(),

                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 1. Top Header Profile Greeting
  Widget _buildTopHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF34D399), Color(0xFF059669)],
                ),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF059669).withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _officerName,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF064E3B),
                  ),
                ),
                Text(
                  _designation,
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
        GestureDetector(
          onTap: () {
            NavigationService.navigateTo(Routes.notificationScreen);
          },
          child: Container(
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
                        'Live GPS Tracker',
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

  // 3. Attendance Action Card
  Widget _buildAttendanceActionCard() {
    String buttonText = "Start Duty (Check-In)";
    Color buttonGradientStart = const Color(0xFF10B981);
    Color buttonGradientEnd = const Color(0xFF047857);

    if (_isCheckedIn && !_isCheckedOut) {
      buttonText = "End Duty (Check-Out)";
      buttonGradientStart = const Color(0xFFEF4444);
      buttonGradientEnd = const Color(0xFFB91C1C);
    } else if (_isCheckedOut) {
      buttonText = "Duty Completed";
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

  // 4. Today's Performance Card
  Widget _buildTodayPerformanceCard() {
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
                    "TODAY'S FIELD SUMMARY",
                    style: GoogleFonts.outfit(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                      color: const Color(0xFF064E3B).withOpacity(0.8),
                    ),
                  ),
                  Text(
                    'Realtime Sync',
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      color: const Color(0xFF10B981),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _buildMetricItem(
                    'Orders Booked',
                    '$_todayOrders',
                    Icons.shopping_cart_outlined,
                    const Color(0xFF059669),
                  ),
                  _buildMetricItem(
                    'Today Sales',
                    '৳${_todaySales.toStringAsFixed(0)}',
                    Icons.trending_up_rounded,
                    const Color(0xFF0D9488),
                  ),
                  _buildMetricItem(
                    'Collected',
                    '৳${_todayCollection.toStringAsFixed(0)}',
                    Icons.payments_outlined,
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
              fontSize: 15,
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

  // 5. Operational Services Action Grid (Add Customer Shoho)
  Widget _buildOperationalServicesGrid() {
    final List services = [
      {
        'title': 'Add Customer',
        'subtitle': 'Register new shop',
        'icon': Icons.person_add_alt_1_rounded,
        'color': const Color(0xFF059669),
        'action': 'add_customer',
      },
      {
        'title': 'Take Order',
        'subtitle': 'Book new shop order',
        'icon': Icons.add_shopping_cart_rounded,
        'color': const Color(0xFF10B981),
        'action': 'take_order',
      },
      {
        'title': 'Collect Due',
        'subtitle': 'Cash & payment log',
        'icon': Icons.account_balance_wallet_outlined,
        'color': const Color(0xFF0D9488),
        'action': 'collect_due',
      },
      {
        'title': 'Catalog',
        'subtitle': 'Stock & box prices',
        'icon': Icons.inventory_2_outlined,
        'color': const Color(0xFF047857),
        'action': 'catalog',
      },
      {
        'title': 'Tour Plan',
        'subtitle': 'Submit market route',
        'icon': Icons.map_outlined,
        'color': const Color(0xFF0E7490),
        'action': 'tour_plan',
      },
      {
        'title': 'Leave Apply',
        'subtitle': 'Apply for leave',
        'icon': Icons.event_note_outlined,
        'color': const Color(0xFF15803D),
        'action': 'leave_app',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.45,
      ),
      itemBuilder: (context, index) {
        final item = services[index];
        return InkWell(
          onTap: () {
            if (item['action'] == 'add_customer') {
              _showAddCustomerModal();
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
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.72),
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
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: (item['color'] as Color).withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        size: 20,
                        color: item['color'] as Color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['title'] as String,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF064E3B),
                      ),
                    ),
                    Text(
                      item['subtitle'] as String,
                      style: GoogleFonts.outfit(
                        fontSize: 10.5,
                        color: const Color(0xFF64748B),
                      ),
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
