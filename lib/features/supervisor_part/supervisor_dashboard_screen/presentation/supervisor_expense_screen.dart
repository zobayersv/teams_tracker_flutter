import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupervisorViewExpenseScreen extends StatefulWidget {
  const SupervisorViewExpenseScreen({super.key});

  @override
  State<SupervisorViewExpenseScreen> createState() =>
      _SupervisorViewExpenseScreenState();
}

class _SupervisorViewExpenseScreenState
    extends State<SupervisorViewExpenseScreen> {
  late DateTime _selectedDate;
  late DateTime _currentMonthYear;
  final ScrollController _calendarScrollController = ScrollController();

  // Supervisor Personal Expense Logs (api_supervisor_my_expenses.php)
  final List _myExpenses = [
    {
      'id': 'EXP-SUP-01',
      'date': '2026-11-04',
      'category': 'Motorbike Fuel & Octane',
      'amount': 650.0,
      'voucher_no': 'PETRO-9912',
      'purpose': 'Full territory audit from Tongi to Gazipur Chowrasta branch',
      'status': 'pending', // 'pending', 'approved', 'rejected'
      'accounts_note': 'Awaiting accounts department weekly verification',
    },
    {
      'id': 'EXP-SUP-02',
      'date': '2026-11-04',
      'category': 'Daily Field Lunch DA',
      'amount': 250.0,
      'voucher_no': 'DA-4401',
      'purpose':
          'Supervisor standard field meal allowance for full-day inspection',
      'status': 'approved',
      'accounts_note': 'Approved and ready for reimbursement',
    },
    {
      'id': 'EXP-SUP-03',
      'date': '2026-11-02',
      'category': 'Vehicle Maintenance',
      'amount': 420.0,
      'voucher_no': 'SRV-8821',
      'purpose': 'Official bike engine oil replacement and brake inspection',
      'status': 'approved',
      'accounts_note': 'Approved with service slip copy',
    },
    {
      'id': 'EXP-SUP-04',
      'date': '2026-10-28',
      'category': 'Client & Wholesaler Entertainment',
      'amount': 550.0,
      'voucher_no': 'TEA-7721',
      'purpose': 'Tea and hospitality with 4 key egg carton stockists',
      'status': 'approved',
      'accounts_note': 'Approved as official business PR expense',
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

  IconData _getCategoryIcon(String cat) {
    if (cat.contains('Fuel')) return Icons.local_gas_station_rounded;
    if (cat.contains('Lunch')) return Icons.restaurant_rounded;
    if (cat.contains('Maintenance')) return Icons.build_circle_outlined;
    if (cat.contains('Entertainment')) return Icons.coffee_rounded;
    return Icons.receipt_long_rounded;
  }

  // Supervisor New Expense Submission Modal
  void _openAddExpenseModal() {
    String selectedCat = 'Motorbike Fuel & Octane';
    final amountController = TextEditingController();
    final voucherController = TextEditingController();
    final purposeController = TextEditingController();
    DateTime expenseDate = _selectedDate;

    final categories = [
      'Motorbike Fuel & Octane',
      'Daily Field Lunch DA',
      'Vehicle Maintenance',
      'Client & Wholesaler Entertainment',
      'Emergency Field Transit',
      'Others / Misc Bill',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 22,
                  ),
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
                          'Submit Supervisor Expense',
                          style: GoogleFonts.outfit(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF064E3B),
                          ),
                        ),
                        Text(
                          'Log your personal field travel, fuel or DA bills for clearance',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Expense Category Dropdown
                        Text(
                          'Expense Category',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color(0xFF059669),
                              ),
                              value: selectedCat,
                              items: categories.map((c) {
                                return DropdownMenuItem(
                                  value: c,
                                  child: Text(
                                    c,
                                    style: GoogleFonts.outfit(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setModalState(() => selectedCat = val);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Amount & Voucher Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bill Amount (৳)',
                                    style: GoogleFonts.outfit(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: const Color(0xFFE2E8F0),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: amountController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF064E3B),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'e.g. 500',
                                        prefixIcon: const Icon(
                                          Icons.payments_outlined,
                                          size: 18,
                                          color: Color(0xFF059669),
                                        ),
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 12,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Voucher / Slip No',
                                    style: GoogleFonts.outfit(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: const Color(0xFFE2E8F0),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: voucherController,
                                      style: GoogleFonts.outfit(
                                        fontSize: 13,
                                        color: const Color(0xFF0F172A),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'e.g. MEMO-421',
                                        prefixIcon: const Icon(
                                          Icons.tag_rounded,
                                          size: 18,
                                          color: Color(0xFF059669),
                                        ),
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 12,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Date Picker
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expense Date',
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: expenseDate,
                                  firstDate: DateTime(2025),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null) {
                                  setModalState(() => expenseDate = picked);
                                }
                              },
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatDateKey(expenseDate),
                                      style: GoogleFonts.outfit(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.calendar_today_rounded,
                                      size: 16,
                                      color: Color(0xFF059669),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Description / Purpose
                        Text(
                          'Reason & Field Route Details',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: TextField(
                            controller: purposeController,
                            maxLines: 2,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              color: const Color(0xFF0F172A),
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  'e.g. Traveled Tongi to Gazipur Sadar for team audit...',
                              hintStyle: GoogleFonts.outfit(
                                fontSize: 12.5,
                                color: const Color(0xFF94A3B8),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Submit Button
                        ElevatedButton(
                          onPressed: () {
                            final double? amt = double.tryParse(
                              amountController.text.trim(),
                            );
                            if (amt == null || amt <= 0) return;

                            Navigator.pop(context);

                            setState(() {
                              _myExpenses.insert(0, {
                                'id':
                                    'EXP-SUP-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                                'date': _formatDateKey(expenseDate),
                                'category': selectedCat,
                                'amount': amt,
                                'voucher_no':
                                    voucherController.text.trim().isNotEmpty
                                    ? voucherController.text.trim()
                                    : 'SELF-DECL',
                                'purpose':
                                    purposeController.text.trim().isNotEmpty
                                    ? purposeController.text.trim()
                                    : 'Official field duty transit',
                                'status': 'pending',
                                'accounts_note':
                                    'Submitted to accounts department for review',
                              });
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Expense bill of ৳${amt.toStringAsFixed(0)} submitted successfully!',
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
                            'Submit Bill to Accounts',
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final totalDaysInCurrentMonth = _daysInMonth(_currentMonthYear);
    final String selectedDateStr = _formatDateKey(_selectedDate);

    // Filter supervisor's personal bills for the selected day
    final dailyExpenses = _myExpenses
        .where((e) => e['date'] == selectedDateStr)
        .toList();

    // Financial KPI Calculations
    final double dayTotal = dailyExpenses.fold(
      0.0,
      (sum, e) => sum + (e['amount'] as double),
    );

    final String monthPrefix =
        "${_currentMonthYear.year}-${_currentMonthYear.month.toString().padLeft(2, '0')}";
    final double monthlyTotal = _myExpenses
        .where((e) => (e['date'] as String).startsWith(monthPrefix))
        .fold(0.0, (sum, e) => sum + (e['amount'] as double));

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
                // Top App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
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
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
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
                                'My Travel & Bills',
                                style: GoogleFonts.outfit(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              Text(
                                'Log & track your personal field expenses',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: const Color(0xFF059669),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Add Expense Button
                      InkWell(
                        onTap: _openAddExpenseModal,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF10B981), Color(0xFF047857)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF10B981).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Add Bill',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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

                const SizedBox(height: 6),

                // 4. Interactive Horizontal Calendar Strip
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

                const SizedBox(height: 8),

                // 5. Dual Expense Summary KPI Card
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
                            // Day Total
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.today_rounded,
                                        size: 14,
                                        color: Color(0xFF10B981),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'DAY BILLS (${_selectedDate.day} ${_getMonthName(_selectedDate.month).substring(0, 3)})',
                                        style: GoogleFonts.outfit(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '৳${dayTotal.toStringAsFixed(0)}',
                                    style: GoogleFonts.outfit(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF064E3B),
                                    ),
                                  ),
                                  Text(
                                    '${dailyExpenses.length} Claims Logged',
                                    style: GoogleFonts.outfit(
                                      fontSize: 11,
                                      color: const Color(0xFF059669),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: const Color(0xFFE2E8F0),
                            ),
                            const SizedBox(width: 16),
                            // Monthly Total
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.receipt_long_rounded,
                                        size: 14,
                                        color: Color(0xFF0D9488),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'MONTH TOTAL (${_getMonthName(_currentMonthYear.month).toUpperCase()})',
                                        style: GoogleFonts.outfit(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '৳${monthlyTotal.toStringAsFixed(0)}',
                                    style: GoogleFonts.outfit(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0D9488),
                                    ),
                                  ),
                                  Text(
                                    'Cumulative Claims',
                                    style: GoogleFonts.outfit(
                                      fontSize: 11,
                                      color: const Color(0xFF047857),
                                      fontWeight: FontWeight.w600,
                                    ),
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

                // Section Label
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'MY CLAIMS FOR THIS DATE',
                    style: GoogleFonts.outfit(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: const Color(0xFF064E3B).withOpacity(0.75),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // 6. My Expenses List
                Expanded(
                  child: dailyExpenses.isEmpty
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
                                  Icons.receipt_outlined,
                                  size: 40,
                                  color: Color(0xFF059669),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No Personal Bills Logged',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Tap "+ Add Bill" on top to submit fuel or lunch claims',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                          itemCount: dailyExpenses.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = dailyExpenses[index];
                            final double amount = (item['amount'] as double);
                            final String status = item['status'] as String;

                            Color statusColor;
                            String statusLabel;

                            if (status == 'approved') {
                              statusColor = const Color(0xFF10B981);
                              statusLabel = 'APPROVED';
                            } else if (status == 'rejected') {
                              statusColor = const Color(0xFFEF4444);
                              statusLabel = 'REJECTED';
                            } else {
                              statusColor = const Color(0xFFF59E0B);
                              statusLabel = 'PENDING';
                            }

                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 16,
                                  sigmaY: 16,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.76),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.8,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF064E3B,
                                        ).withOpacity(0.05),
                                        blurRadius: 16,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Top Row: Category Icon & Amount
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: const Color(
                                                0xFF10B981,
                                              ).withOpacity(0.12),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              _getCategoryIcon(
                                                item['category'],
                                              ),
                                              size: 22,
                                              color: const Color(0xFF059669),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item['category'],
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                      0xFF0F172A,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Voucher: ${item['voucher_no']}',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 11.5,
                                                    color: const Color(
                                                      0xFF64748B,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '৳${amount.toStringAsFixed(0)}',
                                                style: GoogleFonts.outfit(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(
                                                    0xFF064E3B,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 7,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: statusColor
                                                      .withOpacity(0.14),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  statusLabel,
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 9.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: statusColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      const Divider(
                                        height: 16,
                                        color: Color(0xFFE2E8F0),
                                      ),

                                      // Purpose
                                      Text(
                                        item['purpose'],
                                        style: GoogleFonts.outfit(
                                          fontSize: 12,
                                          color: const Color(0xFF475569),
                                          height: 1.3,
                                        ),
                                      ),

                                      // Accounts Note if any
                                      if (item['accounts_note'] != null) ...[
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFECFDF5),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: const Color(
                                                0xFF10B981,
                                              ).withOpacity(0.25),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.account_balance_outlined,
                                                size: 13,
                                                color: Color(0xFF059669),
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  'Accounts: ${item['accounts_note']}',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 11,
                                                    color: const Color(
                                                      0xFF047857,
                                                    ),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
