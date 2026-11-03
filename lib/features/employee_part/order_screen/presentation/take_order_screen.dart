import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TakeOrderScreen extends StatefulWidget {
  const TakeOrderScreen({super.key});

  @override
  State<TakeOrderScreen> createState() => _TakeOrderScreenState();
}

class _TakeOrderScreenState extends State<TakeOrderScreen> {
  // Demo Customer List (api_shops.php theke fetch hobe)
  final List _shops = [
    {
      'name': 'Rahman Brothers General Store',
      'phone': '01755667788',
      'address': 'Shop #14, Mohakhali Kacha Bazar, Dhaka',
    },
    {
      'name': 'Bismillah Groceries & Store',
      'phone': '01811223344',
      'address': 'Mirpur 10 Circle, Dhaka',
    },
    {
      'name': 'Janata Super Shop',
      'phone': '01922334455',
      'address': 'Banani Super Market, Dhaka',
    },
    {
      'name': 'Tongi Mart (Wholesale Outlet)',
      'phone': '01711002233',
      'address': 'Station Road, Tongi, Gazipur',
    },
  ];

  Map<String, String>? _selectedShop;

  // Demo Product Catalog (api_products.php theke ashbe)
  final List _products = [
    {
      'id': 1,
      'name': 'Brown Farm Egg (Large Grade-A)',
      'unit': 'Piece',
      'price': 11.50,
      'stock': 2400,
      'qty': 0,
    },
    {
      'id': 2,
      'name': 'White Premium Poultry Egg',
      'unit': 'Piece',
      'price': 10.20,
      'stock': 1800,
      'qty': 0,
    },
    {
      'id': 3,
      'name': 'Native Duck Egg (Shonali Grade)',
      'unit': 'Piece',
      'price': 15.00,
      'stock': 650,
      'qty': 0,
    },
    {
      'id': 4,
      'name': 'Paper Egg Tray (30 Slot Standard)',
      'unit': 'Pack',
      'price': 48.00,
      'stock': 320,
      'qty': 0,
    },
    {
      'id': 5,
      'name': 'Plastic Crates (Transport Grade)',
      'unit': 'Box',
      'price': 350.00,
      'stock': 85,
      'qty': 0,
    },
  ];

  String _paymentStatus = 'due'; // 'paid', 'due', 'partial'
  final TextEditingController _paidAmountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _selectedShop = _shops.first;
  }

  @override
  void dispose() {
    _paidAmountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  double get _totalAmount {
    double total = 0.0;
    for (var p in _products) {
      total += (p['qty'] as int) * (p['price'] as double);
    }
    return total;
  }

  int get _totalItemsCount {
    int count = 0;
    for (var p in _products) {
      count += (p['qty'] as int);
    }
    return count;
  }

  void _updateQuantity(int index, int change) {
    setState(() {
      int current = _products[index]['qty'] as int;
      int maxStock = _products[index]['stock'] as int;
      int next = current + change;

      if (next >= 0 && next <= maxStock) {
        _products[index]['qty'] = next;
      }
    });
  }

  void _handleConfirmOrder() async {
    if (_totalAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Kono product select kora hoyni! Onnotomo 1 ti item jog korun.',
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF064E3B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // API Simulation (api_orders.php action: create_order)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Order #ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)} booked successfully!',
          style: GoogleFonts.outfit(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF059669),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    Navigator.pop(context);
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
            bottom: 80,
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

          // 3. Main Screen Form View
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
                          const SizedBox(width: 6),
                          Text(
                            'Take New Order',
                            style: GoogleFonts.outfit(
                              fontSize: 22,
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
                          color: const Color(0xFF10B981).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFF10B981).withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          'Live Booking',
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

                // Scrollable Products & Shop List
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shop Selector Card
                        _buildShopSelectorCard(),
                        const SizedBox(height: 18),

                        // Section Title: Products
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PRODUCT CATALOG',
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                                color: const Color(0xFF064E3B).withOpacity(0.7),
                              ),
                            ),
                            Text(
                              '${_products.length} Items Available',
                              style: GoogleFonts.outfit(
                                fontSize: 11.5,
                                color: const Color(0xFF059669),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Product Items List
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _products.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final prod = _products[index];
                            final int qty = prod['qty'];

                            return ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 14,
                                  sigmaY: 14,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.76),
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: qty > 0
                                          ? const Color(
                                              0xFF10B981,
                                            ).withOpacity(0.5)
                                          : Colors.white,
                                      width: qty > 0 ? 1.6 : 1.2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF064E3B,
                                        ).withOpacity(0.04),
                                        blurRadius: 14,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      // Product Icon
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF10B981,
                                          ).withOpacity(0.12),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.egg_outlined,
                                          color: Color(0xFF059669),
                                          size: 22,
                                        ),
                                      ),
                                      const SizedBox(width: 12),

                                      // Details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              prod['name'],
                                              style: GoogleFonts.outfit(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF0F172A),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'Price: ৳${prod['price']} / ${prod['unit']}  •  Stock: ${prod['stock']}',
                                              style: GoogleFonts.outfit(
                                                fontSize: 11,
                                                color: const Color(0xFF64748B),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Stepper Counter (+ / -)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: const Color(0xFFE2E8F0),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  _updateQuantity(index, -10),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 6,
                                                    ),
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 16,
                                                  color: Color(0xFF064E3B),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              constraints: const BoxConstraints(
                                                minWidth: 32,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '$qty',
                                                style: GoogleFonts.outfit(
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: qty > 0
                                                      ? const Color(0xFF059669)
                                                      : const Color(0xFF0F172A),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  _updateQuantity(index, 10),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 6,
                                                    ),
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 16,
                                                  color: Color(0xFF064E3B),
                                                ),
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
                          },
                        ),

                        const SizedBox(height: 18),

                        // Payment Status Selection
                        _buildPaymentMethodSection(),

                        const SizedBox(height: 14),

                        // Special Delivery Instructions / Note
                        _buildOrderNoteInput(),

                        const SizedBox(height: 110), // Bottom sheet gap
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 4. Floating Bottom Action Calculation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(26),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 22),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.92),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(26),
                    ),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF064E3B).withOpacity(0.12),
                        blurRadius: 20,
                        offset: const Offset(0, -6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Total Breakdown
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TOTAL ORDER VALUE',
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '৳${_totalAmount.toStringAsFixed(2)}',
                                  style: GoogleFonts.outfit(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF064E3B),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF10B981,
                                    ).withOpacity(0.14),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '$_totalItemsCount pcs',
                                    style: GoogleFonts.outfit(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF047857),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Confirm Order Button
                      InkWell(
                        onTap: _isSubmitting ? null : _handleConfirmOrder,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF10B981), Color(0xFF047857)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF10B981,
                                ).withOpacity(0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 1,
                            ),
                          ),
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Confirm Order',
                                      style: GoogleFonts.outfit(
                                        fontSize: 15,
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Shop Selector Widget
  Widget _buildShopSelectorCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.78),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 2),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.storefront_rounded,
                        size: 18,
                        color: Color(0xFF059669),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Target Shop / Retailer',
                        style: GoogleFonts.outfit(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF064E3B),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Change',
                    style: GoogleFonts.outfit(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF059669),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF064E3B),
                    ),
                    value: _selectedShop,
                    items: _shops.map((shop) {
                      return DropdownMenuItem(
                        value: shop,
                        child: Text(
                          shop['name']!,
                          style: GoogleFonts.outfit(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedShop = val as Map<String, String>?;
                      });
                    },
                  ),
                ),
              ),
              if (_selectedShop != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.phone_outlined,
                      size: 13,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _selectedShop!['phone']!,
                      style: GoogleFonts.outfit(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.location_on_outlined,
                      size: 13,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        _selectedShop!['address']!,
                        style: GoogleFonts.outfit(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Payment Selection Widget
  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PAYMENT TERMS',
          style: GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            color: const Color(0xFF064E3B).withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildPaymentTypeChip('Full Due', 'due', const Color(0xFFEF4444)),
            const SizedBox(width: 10),
            _buildPaymentTypeChip('Cash Paid', 'paid', const Color(0xFF10B981)),
            const SizedBox(width: 10),
            _buildPaymentTypeChip(
              'Partial',
              'partial',
              const Color(0xFFF59E0B),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentTypeChip(String title, String val, Color activeColor) {
    final bool isSelected = _paymentStatus == val;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _paymentStatus = val;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? activeColor.withOpacity(0.14)
                : Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? activeColor : const Color(0xFFE2E8F0),
              width: isSelected ? 1.6 : 1,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 12.5,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? activeColor : const Color(0xFF475569),
            ),
          ),
        ),
      ),
    );
  }

  // Order Note Input Widget
  Widget _buildOrderNoteInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _noteController,
        style: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF0F172A)),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          hintText: 'Add special delivery instruction or note...',
          hintStyle: GoogleFonts.outfit(
            fontSize: 12.5,
            color: const Color(0xFF94A3B8),
          ),
          prefixIcon: const Icon(
            Icons.note_alt_outlined,
            color: Color(0xFF059669),
            size: 18,
          ),
        ),
      ),
    );
  }
}
