import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupervisorTeamSalesScreen extends StatefulWidget {
  const SupervisorTeamSalesScreen({super.key});

  @override
  State<SupervisorTeamSalesScreen> createState() => _SupervisorTeamSalesScreenState();
}

class _SupervisorTeamSalesScreenState extends State<SupervisorTeamSalesScreen> {
  late DateTime _selectedDate;
  late DateTime _currentMonthYear;
  final ScrollController _calendarScrollController = ScrollController();

  String _selectedOfficerFilter = 'All';

  // Demo Team Sales Database (api_supervisor_sales.php theke fetch hobe)
  final List _teamSalesLogs = [
    {
      'date': '2026-11-03',
      'officer_id': 101,
      'officer_name': 'Rahim Ahmed',
      'officer_area': 'Tongi & Station Road',
      'total_sales': 18450.0,
      'collection': 12000.0,
      'due': 6450.0,
      'orders_count': 4,
      'shops': [
        {'name': 'Rahman Brothers Store', 'amount': 7200.0, 'status': 'PAID'},
        {'name': 'Bismillah Groceries', 'amount': 6500.0, 'status': 'DUE'},
        {'name': 'Janata Mini Mart', 'amount': 4750.0, 'status': 'PAID'},
      ],
    },
    {
      'date': '2026-11-03',
      'officer_id': 102,
      'officer_name': 'Kamrul Hasan',
      'officer_area': 'Gazipur Chowrasta',
      'total_sales': 26800.0,
      'collection': 19500.0,
      'due': 7300.0,
      'orders_count': 6,
      'shops': [
        {'name': 'Al-Madina Store', 'amount': 11400.0, 'status': 'PAID'},
        {'name': 'Mayer Doa General', 'amount': 8200.0, 'status': 'DUE'},
        {'name': 'Bhawal Traders', 'amount': 7200.0, 'status': 'PAID'},
      ],
    },
    {
      'date': '2026-11-03',
      'officer_id': 103,
      'officer_name': 'Tanvir Hossain',
      'officer_area': 'Board Bazar & National Univ',
      'total_sales': 14200.0,
      'collection': 9800.0,
      'due': 4400.0,
      'orders_count': 3,
      'shops': [
        {'name': 'Campus Grocers', 'amount': 8200.0, 'status': 'PAID'},
        {'name': 'Shahjalal Egg Mart', 'amount': 6000.0, 'status': 'DUE'},
      ],
    },
    {
      'date': '2026-11-02',
      'officer_id': 101,
      'officer_name': 'Rahim Ahmed',
      'officer_area': 'Tongi Station Road',
      'total_sales': 15600.0,
      'collection': 11000.0,
      'due': 4600.0,
      'orders_count': 3,
      'shops': [
        {'name': 'Tongi Super Shop', 'amount': 15600.0, 'status': 'PAID'},
      ],
    },
    {
      'date': '2026-11-02',
      'officer_id': 102,
      'officer_name': 'Kamrul Hasan',
      'officer_area': 'Gazipur Chowrasta',
      'total_sales': 22400.0,
      'collection': 16000.0,
      'due': 6400.0,
      'orders_count': 5,
      'shops': [
        {'name': 'Sultana Traders', 'amount': 22400.0, 'status': 'PAID'},
      ],
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
    var firstDayNextMonth = DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, 1);
    return firstDayNextMonth.subtract(const Duration(days: 1)).day;
  }

  void _changeMonth(int increment) {
    setState(() {
      _currentMonthYear = DateTime(_currentMonthYear.year, _currentMonthYear.month + increment);
      _selectedDate = DateTime(_currentMonthYear.year, _currentMonthYear.month, 1);
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
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  String _getWeekdayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final totalDaysInCurrentMonth = _daysInMonth(_currentMonthYear);
    final String selectedDateStr = _formatDateKey(_selectedDate);

    // Selected Date er data filter
    final List dailyLogs = _teamSalesLogs.where((l) {
      final matchesDate = l['date'] == selectedDateStr;
      final matchesOfficer = _selectedOfficerFilter == 'All' || l['officer_name'] == _selectedOfficerFilter;
      return matchesDate && matchesOfficer;
    }).toList();

    // Day calculations
    final double dayTotalSales = dailyLogs.fold(0.0, (sum, item) => sum + (item['total_sales'] as double));
    final double dayTotalCollection = dailyLogs.fold(0.0, (sum, item) => sum + (item['collection'] as double));

    // Full Month cumulative sales
    final String monthPrefix = "${_currentMonthYear.year}-${_currentMonthYear.month.toString().padLeft(2, '0')}";
    final double monthlyTotalSales = _teamSalesLogs
        .where((l) => (l['date'] as String).startsWith(monthPrefix))
        .fold(0.0, (sum, item) => sum + (item['total_sales'] as double));

    final double monthlyTotalCollection = _teamSalesLogs
        .where((l) => (l['date'] as String).startsWith(monthPrefix))
        .fold(0.0, (sum, item) => sum + (item['collection'] as double));

    // Unique Officers list for filter tabs
    final List<String> officerNames = ['All', 'Rahim Ahmed', 'Kamrul Hasan', 'Tanvir Hossain'];

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
                // Top Header Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Team Sales Oversight',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF064E3B),
                              ),
                            ),
                            Text(
                              'Employee-wise daily and monthly performance',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(fontSize: 11.5, color: const Color(0xFF059669)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Month Switcher
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF10B981).withOpacity(0.4)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => _changeMonth(-1),
                              child: const Icon(Icons.chevron_left_rounded, size: 20, color: Color(0xFF064E3B)),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${_getMonthName(_currentMonthYear.month).substring(0, 3)} ${_currentMonthYear.year}",
                              style: GoogleFonts.outfit(
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF064E3B),
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () => _changeMonth(1),
                              child: const Icon(Icons.chevron_right_rounded, size: 20, color: Color(0xFF064E3B)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 4. Interactive Horizontal Calendar Strip (30/31 days)
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
                      final dayDate = DateTime(_currentMonthYear.year, _currentMonthYear.month, dayNum);
                      final bool isSelected = _selectedDate.day == dayNum &&
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
                          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF059669)
                                : Colors.white.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSelected ? Colors.white : const Color(0xFFE2E8F0),
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
                                  color: isSelected ? Colors.white70 : const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$dayNum',
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : const Color(0xFF064E3B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // 5. Dual KPI Card (Selected Day vs Total Monthly)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.76),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF064E3B).withOpacity(0.06),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Day Sales Card
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.today_rounded, size: 14, color: Color(0xFF10B981)),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          'DAY SALES (${_selectedDate.day} ${_getMonthName(_selectedDate.month).substring(0, 3)})',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '৳${dayTotalSales.toStringAsFixed(0)}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF064E3B)),
                                  ),
                                  Text(
                                    'Collected: ৳${dayTotalCollection.toStringAsFixed(0)}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF059669), fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Container(width: 1, height: 50, margin: const EdgeInsets.symmetric(horizontal: 12), color: const Color(0xFFE2E8F0)),
                            // Monthly Total Card
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.date_range_rounded, size: 14, color: Color(0xFF0D9488)),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          'MONTH TOTAL (${_getMonthName(_currentMonthYear.month).substring(0, 3).toUpperCase()})',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '৳${monthlyTotalSales.toStringAsFixed(0)}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF0D9488)),
                                  ),
                                  Text(
                                    'Collected: ৳${monthlyTotalCollection.toStringAsFixed(0)}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF047857), fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // 6. Officer Filter Chips
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    itemCount: officerNames.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final name = officerNames[index];
                      final bool isSelected = _selectedOfficerFilter == name;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOfficerFilter = name;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF059669) : Colors.white.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF059669) : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              name,
                              style: GoogleFonts.outfit(
                                fontSize: 11.5,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? Colors.white : const Color(0xFF475569),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // 7. Employee-Wise Sales List
                Expanded(
                  child: dailyLogs.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981).withOpacity(0.12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.assignment_late_outlined, size: 40, color: Color(0xFF059669)),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'No Sales Records Logged',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF064E3B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'No field orders on ${_selectedDate.day} ${_getMonthName(_selectedDate.month)} for $_selectedOfficerFilter',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF64748B)),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(18, 4, 18, 90),
                          itemCount: dailyLogs.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final log = dailyLogs[index];
                            final List shops = log['shops'] ?? [];

                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.78),
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
                                      // Officer Name & Orders Count Badge
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFF10B981).withOpacity(0.14),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(Icons.person_rounded, size: 18, color: Color(0xFF059669)),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        log['officer_name'],
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: GoogleFonts.outfit(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                          color: const Color(0xFF0F172A),
                                                        ),
                                                      ),
                                                      Text(
                                                        log['officer_area'],
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: GoogleFonts.outfit(
                                                          fontSize: 11,
                                                          color: const Color(0xFF64748B),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFECFDF5),
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
                                            ),
                                            child: Text(
                                              '${log['orders_count']} Bookings',
                                              style: GoogleFonts.outfit(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF047857),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const Divider(height: 20, color: Color(0xFFE2E8F0)),

                                      // Financial Breakdown Row (Sales, Collection, Due)
                                      Row(
                                        children: [
                                          _buildFinancialCol('Total Booked', '৳${log['total_sales']}', const Color(0xFF064E3B)),
                                          _buildFinancialCol('Cash Received', '৳${log['collection']}', const Color(0xFF059669)),
                                          _buildFinancialCol('Market Due', '৳${log['due']}', const Color(0xFFDC2626)),
                                        ],
                                      ),

                                      const SizedBox(height: 12),

                                      // Booked Shops Micro-List
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF8FAFC).withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: const Color(0xFFE2E8F0)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'BOOKED SHOPS THIS DAY',
                                              style: GoogleFonts.outfit(fontSize: 9.5, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)),
                                            ),
                                            const SizedBox(height: 6),
                                            ...shops.map((s) {
                                              final bool isPaid = s['status'] == 'PAID';
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 2.5),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        s['name'],
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: GoogleFonts.outfit(fontSize: 11.5, color: const Color(0xFF1E293B), fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '৳${s['amount']}',
                                                          style: GoogleFonts.outfit(fontSize: 11.5, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                                                        ),
                                                        const SizedBox(width: 6),
                                                        Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                                                          decoration: BoxDecoration(
                                                            color: isPaid ? const Color(0xFFD1FAE5) : const Color(0xFFFEE2E2),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Text(
                                                            s['status'],
                                                            style: GoogleFonts.outfit(
                                                              fontSize: 8.5,
                                                              fontWeight: FontWeight.bold,
                                                              color: isPaid ? const Color(0xFF047857) : const Color(0xFFDC2626),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                          ],
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

  Widget _buildFinancialCol(String label, String value, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}