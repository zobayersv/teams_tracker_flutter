import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceListScreen extends StatefulWidget {
  const AttendanceListScreen({super.key});

  @override
  State<AttendanceListScreen> createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends State<AttendanceListScreen> {
  late DateTime _selectedDate;
  late DateTime _currentMonthYear;
  final ScrollController _calendarScrollController = ScrollController();

  // Demo Attendance Logs (api_attendance_toggle.php theke fetch hobe)
  final List _attendanceRecords = [
    {
      'date': '2026-11-03',
      'in_time': '09:05 AM',
      'out_time': '05:15 PM',
      'working_hours': '8h 10m',
      'status': 'present',
      'in_address': 'Mohakhali C/A, Dhaka',
      'out_address': 'Gulshan 1 Circle, Dhaka',
      'in_lat': 23.7776,
      'in_lng': 90.4054,
    },
    {
      'date': '2026-11-02',
      'in_time': '09:32 AM',
      'out_time': '05:20 PM',
      'working_hours': '7h 48m',
      'status': 'late',
      'in_address': 'Tongi Station Road, Gazipur',
      'out_address': 'Tongi Bazar, Gazipur',
      'in_lat': 23.8983,
      'in_lng': 90.4035,
    },
    {
      'date': '2026-11-01',
      'in_time': '08:58 AM',
      'out_time': '05:05 PM',
      'working_hours': '8h 07m',
      'status': 'present',
      'in_address': 'Banani Super Market, Dhaka',
      'out_address': 'Airport Road, Dhaka',
      'in_lat': 23.7937,
      'in_lng': 90.4046,
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _currentMonthYear = DateTime(_selectedDate.year, _selectedDate.month);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDay();
    });
  }

  int _daysInMonth(DateTime date) {
    var firstDayThisMonth = DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = DateTime(
      firstDayThisMonth.year,
      firstDayThisMonth.month + 1,
      1,
    );
    return firstDayNextMonth.subtract(const Duration(days: 1)).day;
  }

  void _changeMonth(int increment) {
    setState(() {
      _currentMonthYear = DateTime(
        _currentMonthYear.year,
        _currentMonthYear.month + increment,
      );
      _selectedDate = DateTime(
        _currentMonthYear.year,
        _currentMonthYear.month,
        1,
      );
    });
    _scrollToSelectedDay();
  }

  void _scrollToSelectedDay() {
    if (_calendarScrollController.hasClients) {
      double targetScroll = (_selectedDate.day - 1) * 62.0;
      _calendarScrollController.animateTo(
        targetScroll,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  String _formatDateKey(DateTime d) {
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  String _getWeekdayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  // Pinpoint Coordinates Details Modal
  void _showCoordinatesModal(BuildContext context, Map<String, dynamic> att) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
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
                Text(
                  'GPS Pinpoint Audit',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF064E3B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Exact satellite coordinates during check-in',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 16),

                // Recorded Spot Address
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFF059669),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          att['in_address'] ?? 'No Address Recorded',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Latitude & Longitude Block
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LATITUDE',
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${att['in_lat']}',
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF064E3B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LONGITUDE',
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${att['in_lng']}',
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF064E3B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Open in Google Maps Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    // Google Maps link / intent
                    _triggerExportNotice(
                      "Opening GPS: ${att['in_lat']}, ${att['in_lng']}",
                    );
                  },
                  icon: const Icon(
                    Icons.map_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: Text(
                    'Open in Google Maps',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF059669),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  // Export Action Sheet (PDF ও Excel অপশন)
  void _showExportOptionsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Export Attendance Statement',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF064E3B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Duration: ${_getMonthName(_currentMonthYear.month)} ${_currentMonthYear.year}',
                  style: GoogleFonts.outfit(
                    fontSize: 12.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 20),

                // 1. Export as PDF
                _buildExportTile(
                  icon: Icons.picture_as_pdf_rounded,
                  iconColor: const Color(0xFFEF4444),
                  bgColor: const Color(0xFFFEE2E2),
                  title: 'Print / Save as PDF Document',
                  subtitle: 'Official signed monthly field audit preview',
                  onTap: () {
                    Navigator.pop(context);
                    _triggerExportNotice('PDF Statement Generating...');
                  },
                ),
                const SizedBox(height: 12),

                // 2. Export as Excel (.CSV)
                _buildExportTile(
                  icon: Icons.table_view_rounded,
                  iconColor: const Color(0xFF10B981),
                  bgColor: const Color(0xFFD1FAE5),
                  title: 'Export to Excel Spreadsheet (.CSV)',
                  subtitle: 'Detailed time, coordinates & duration logs',
                  onTap: () {
                    Navigator.pop(context);
                    _triggerExportNotice(
                      'Excel (.CSV) Spreadsheet Downloaded!',
                    );
                  },
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExportTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }

  void _triggerExportNotice(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.outfit(color: Colors.white)),
        backgroundColor: const Color(0xFF059669),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final totalDaysInCurrentMonth = _daysInMonth(_currentMonthYear);
    final String selectedDateStr = _formatDateKey(_selectedDate);

    final filteredRecords = _attendanceRecords
        .where((a) => a['date'] == selectedDateStr)
        .toList();

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gradient
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
            top: -40,
            right: -30,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF34D399).withOpacity(0.35),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withOpacity(0.35),
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
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFA7F3D0).withOpacity(0.35),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF059669).withOpacity(0.2),
                    blurRadius: 100,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),

          // 3. Main Screen View
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header with Month Switcher & Export Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Attendance Log',
                            style: GoogleFonts.outfit(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF064E3B),
                            ),
                          ),
                          Text(
                            'Daily duty timestamps & working hours',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: const Color(0xFF059669),
                            ),
                          ),
                        ],
                      ),
                      // Export Action Button (PDF / Excel)
                      InkWell(
                        onTap: _showExportOptionsModal,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF10B981).withOpacity(0.4),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF059669,
                                ).withOpacity(0.12),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.file_download_outlined,
                                size: 16,
                                color: Color(0xFF059669),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Export',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Month Switcher Row
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 4,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _changeMonth(-1),
                          child: const Icon(
                            Icons.chevron_left_rounded,
                            size: 22,
                            color: Color(0xFF064E3B),
                          ),
                        ),
                        Text(
                          "${_getMonthName(_currentMonthYear.month)} ${_currentMonthYear.year}",
                          style: GoogleFonts.outfit(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF064E3B),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _changeMonth(1),
                          child: const Icon(
                            Icons.chevron_right_rounded,
                            size: 22,
                            color: Color(0xFF064E3B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // 4. Interactive Monthly Horizontal Calendar Bar (30/31 days)
                SizedBox(
                  height: 85,
                  child: ListView.builder(
                    controller: _calendarScrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: totalDaysInCurrentMonth,
                    itemBuilder: (context, index) {
                      final dayNum = index + 1;
                      final dayDate = DateTime(
                        _currentMonthYear.year,
                        _currentMonthYear.month,
                        dayNum,
                      );
                      final bool isSelected =
                          _selectedDate.day == dayNum &&
                          _selectedDate.month == dayDate.month &&
                          _selectedDate.year == dayDate.year;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDate = dayDate;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: 54,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF059669)
                                : Colors.white.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFFE2E8F0),
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? const Color(0xFF059669).withOpacity(0.35)
                                    : Colors.black.withOpacity(0.04),
                                blurRadius: isSelected ? 12 : 6,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _getWeekdayName(dayDate),
                                style: GoogleFonts.outfit(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white70
                                      : const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$dayNum',
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF064E3B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // Attendance Status Header for the Selected Day
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date: ${_selectedDate.day} ${_getMonthName(_selectedDate.month)}, ${_selectedDate.year}',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF064E3B),
                        ),
                      ),
                      Text(
                        filteredRecords.isNotEmpty
                            ? 'Record Found'
                            : 'Holiday / Off Day',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: filteredRecords.isNotEmpty
                              ? const Color(0xFF059669)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 5. Attendance Details Card / Empty View
                Expanded(
                  child: filteredRecords.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF10B981,
                                  ).withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.event_busy_rounded,
                                  size: 40,
                                  color: Color(0xFF059669),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No Duty Logged',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'No Check-in entry on ${_selectedDate.day} ${_getMonthName(_selectedDate.month)}',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 90),
                          itemCount: filteredRecords.length,
                          itemBuilder: (context, index) {
                            final att = filteredRecords[index];
                            final bool isLate = att['status'] == 'late';

                            return ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 18,
                                  sigmaY: 18,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.78),
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF064E3B,
                                        ).withOpacity(0.06),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Status Badge Row
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isLate
                                                  ? const Color(0xFFFEF3C7)
                                                  : const Color(0xFFD1FAE5),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  isLate
                                                      ? Icons
                                                            .warning_amber_rounded
                                                      : Icons
                                                            .check_circle_rounded,
                                                  size: 14,
                                                  color: isLate
                                                      ? const Color(0xFFD97706)
                                                      : const Color(0xFF059669),
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  isLate
                                                      ? 'LATE ARRIVAL'
                                                      : 'ON TIME (PRESENT)',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 10.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: isLate
                                                        ? const Color(
                                                            0xFFB45309,
                                                          )
                                                        : const Color(
                                                            0xFF047857,
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'Duration: ${att['working_hours']}',
                                            style: GoogleFonts.outfit(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF064E3B),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const Divider(
                                        height: 22,
                                        color: Color(0xFFE2E8F0),
                                      ),

                                      // Time Comparison
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.login_rounded,
                                                      size: 14,
                                                      color: Color(0xFF10B981),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      'CHECK-IN (IN)',
                                                      style: GoogleFonts.outfit(
                                                        fontSize: 10.5,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                          0xFF64748B,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  att['in_time'],
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                      0xFF0F172A,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  att['in_address'],
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 11,
                                                    color: const Color(
                                                      0xFF64748B,
                                                    ),
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 1,
                                            height: 45,
                                            color: const Color(0xFFE2E8F0),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.logout_rounded,
                                                      size: 14,
                                                      color: Color(0xFFEF4444),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      'CHECK-OUT (OUT)',
                                                      style: GoogleFonts.outfit(
                                                        fontSize: 10.5,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                          0xFF64748B,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  att['out_time'] ??
                                                      'Duty Active',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                      0xFF0F172A,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  att['out_address'] ??
                                                      'In Field Area',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 11,
                                                    color: const Color(
                                                      0xFF64748B,
                                                    ),
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 14),

                                      // GPS Coordinates Spot View Link (Working Action)
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            _showCoordinatesModal(context, att);
                                          },
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                              horizontal: 6,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.map_outlined,
                                                  size: 14,
                                                  color: Color(0xFF059669),
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  'View Pinpoint Coordinates',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 11.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                      0xFF059669,
                                                    ),
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
}
