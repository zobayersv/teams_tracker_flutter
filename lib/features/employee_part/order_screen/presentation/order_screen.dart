import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'order_details_screen.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late DateTime _selectedDate;
  late DateTime _currentMonthYear;
  final ScrollController _calendarScrollController = ScrollController();

  // Demo Order Data (api_orders.php theke fetch kora hobe)
  final List _allOrders = [
    {
      'order_id': 101,
      'order_date': '2026-11-03',
      'shop_name': 'Rahman Brothers General Store',
      'shop_phone': '01755667788',
      'shop_address': 'Shop #14, Mohakhali Kacha Bazar, Dhaka',
      'total_amount': 2800.0,
      'payment_status': 'due',
      'order_status': 'confirmed',
      'items': [
        {
          'product_name': 'Brown Farm Egg (Large)',
          'quantity': 200,
          'unit_price': 11.5,
          'subtotal': 2300.0,
        },
        {
          'product_name': 'White Premium Egg',
          'quantity': 50,
          'unit_price': 10.0,
          'subtotal': 500.0,
        },
      ],
    },
    {
      'order_id': 102,
      'order_date': '2026-11-03',
      'shop_name': 'Bismillah Groceries & Store',
      'shop_phone': '01811223344',
      'shop_address': 'Mirpur 10 Circle, Dhaka',
      'total_amount': 4500.0,
      'payment_status': 'paid',
      'order_status': 'delivered',
      'items': [
        {
          'product_name': 'Brown Farm Egg (Large)',
          'quantity': 350,
          'unit_price': 11.5,
          'subtotal': 4025.0,
        },
        {
          'product_name': 'Egg Paper Tray',
          'quantity': 10,
          'unit_price': 47.5,
          'subtotal': 475.0,
        },
      ],
    },
    {
      'order_id': 103,
      'order_date': '2026-11-02',
      'shop_name': 'Janata Super Shop',
      'shop_phone': '01922334455',
      'shop_address': 'Banani Super Market, Dhaka',
      'total_amount': 7200.0,
      'payment_status': 'due',
      'order_status': 'pending',
      'items': [
        {
          'product_name': 'Brown Farm Egg (Medium)',
          'quantity': 600,
          'unit_price': 11.0,
          'subtotal': 6600.0,
        },
        {
          'product_name': 'Organic Country Egg',
          'quantity': 40,
          'unit_price': 15.0,
          'subtotal': 600.0,
        },
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

  // Mash-er total din (28, 29, 30, ba 31) auto calculate
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final totalDaysInCurrentMonth = _daysInMonth(_currentMonthYear);
    final String selectedDateStr = _formatDateKey(_selectedDate);

    // Selected date onujayi orders filter
    final filteredOrders = _allOrders
        .where((o) => o['order_date'] == selectedDateStr)
        .toList();
    final double dayTotalSales = filteredOrders.fold(
      0.0,
      (sum, o) => sum + (o['total_amount'] as double),
    );

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

          // 2. Glossy Ambient Spheres
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

          // 3. Main Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row
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
                            'Field Orders',
                            style: GoogleFonts.outfit(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF064E3B),
                            ),
                          ),
                          Text(
                            'Daily shop bookings & delivery logs',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: const Color(0xFF059669),
                            ),
                          ),
                        ],
                      ),
                      // Month Selector with Prev & Next arrows
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF10B981).withOpacity(0.4),
                          ),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => _changeMonth(-1),
                              child: const Icon(
                                Icons.chevron_left_rounded,
                                size: 20,
                                color: Color(0xFF064E3B),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${_getMonthName(_currentMonthYear.month)} ${_currentMonthYear.year}",
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF064E3B),
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () => _changeMonth(1),
                              child: const Icon(
                                Icons.chevron_right_rounded,
                                size: 20,
                                color: Color(0xFF064E3B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

                // Selected Day Summary (Count + Sales Value)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Orders (${filteredOrders.length})',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF064E3B),
                        ),
                      ),
                      Text(
                        'Total: ৳${dayTotalSales.toStringAsFixed(0)}',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF047857),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 5. Orders List / Empty View
                Expanded(
                  child: filteredOrders.isEmpty
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
                                  Icons.remove_shopping_cart_outlined,
                                  size: 40,
                                  color: Color(0xFF059669),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No Orders Found',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'No shop orders booked on ${_selectedDate.day} ${_getMonthName(_selectedDate.month)}',
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
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 90),
                          itemCount: filteredOrders.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final o = filteredOrders[index];
                            final bool isPaid = o['payment_status'] == 'paid';

                            return InkWell(
                              onTap: () {
                                // Order Details Screen e navigate
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderDetailsScreen(order: o),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 16,
                                    sigmaY: 16,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.75),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.8,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFF064E3B,
                                          ).withOpacity(0.06),
                                          blurRadius: 18,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Top Row: Shop Name & Paid/Due Badge
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                o['shop_name'],
                                                style: GoogleFonts.outfit(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(
                                                    0xFF0F172A,
                                                  ),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 3,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: isPaid
                                                    ? const Color(
                                                        0xFF10B981,
                                                      ).withOpacity(0.16)
                                                    : const Color(
                                                        0xFFEF4444,
                                                      ).withOpacity(0.14),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                isPaid ? 'PAID' : 'DUE',
                                                style: GoogleFonts.outfit(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: isPaid
                                                      ? const Color(0xFF047857)
                                                      : const Color(0xFFDC2626),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),

                                        // Mobile & Area
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.phone_outlined,
                                              size: 13,
                                              color: Color(0xFF64748B),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              o['shop_phone'],
                                              style: GoogleFonts.outfit(
                                                fontSize: 12,
                                                color: const Color(0xFF64748B),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            const Icon(
                                              Icons.tag_rounded,
                                              size: 13,
                                              color: Color(0xFF64748B),
                                            ),
                                            Text(
                                              '#ORD-${o['order_id']}',
                                              style: GoogleFonts.outfit(
                                                fontSize: 11.5,
                                                color: const Color(0xFF64748B),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const Divider(
                                          height: 16,
                                          color: Color(0xFFE2E8F0),
                                        ),

                                        // Bottom Row: Total Amount & View Details Arrow
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Total: ',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 12,
                                                    color: const Color(
                                                      0xFF64748B,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '৳${o['total_amount']}',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                      0xFF064E3B,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'View Details',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 11.5,
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(
                                                      0xFF059669,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 2),
                                                const Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: 11,
                                                  color: Color(0xFF059669),
                                                ),
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
}
