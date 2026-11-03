import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CollectDueScreen extends StatefulWidget {
  const CollectDueScreen({super.key});

  @override
  State<CollectDueScreen> createState() => _CollectDueScreenState();
}

class _CollectDueScreenState extends State<CollectDueScreen> {
  // Demo Customer List with Due Amounts (api_collections.php theke fetch hobe)
  final List<Map<String, dynamic>> _shopsWithDue = [
    {
      'name': 'Rahman Brothers General Store',
      'phone': '01755667788',
      'address': 'Shop #14, Mohakhali Kacha Bazar, Dhaka',
      'total_due': 5600.0,
      'last_collection': '2026-10-20 (৳2,000)',
    },
    {
      'name': 'Janata Super Shop',
      'phone': '01922334455',
      'address': 'Banani Super Market, Dhaka',
      'total_due': 7500.0,
      'last_collection': '2026-10-18 (৳3,500)',
    },
    {
      'name': 'Bismillah Groceries & Store',
      'phone': '01811223344',
      'address': 'Mirpur 10 Circle, Dhaka',
      'total_due': 2800.0,
      'last_collection': '2026-10-22 (৳4,800)',
    },
    {
      'name': 'Tongi Mart (Wholesale Outlet)',
      'phone': '01711002233',
      'address': 'Station Road, Tongi, Gazipur',
      'total_due': 12400.0,
      'last_collection': '2026-10-15 (৳10,000)',
    },
  ];

  late Map<String, dynamic> _selectedShop;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _refNoController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _paymentMethod = 'cash'; // 'cash', 'bkash', 'nagad', 'bank'
  double _enteredAmount = 0.0;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _selectedShop = _shopsWithDue.first;
    _amountController.addListener(() {
      final val = double.tryParse(_amountController.text.trim()) ?? 0.0;
      setState(() {
        _enteredAmount = val;
      });
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _refNoController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  double get _currentDue => (_selectedShop['total_due'] as double);

  double get _newRemainingDue {
    final remaining = _currentDue - _enteredAmount;
    return remaining < 0 ? 0.0 : remaining;
  }

  void _handleCollectDue() async {
    final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Shothik collection amount likhun (Minimum ৳1)!',
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF064E3B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    if (amount > _currentDue) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Amount total due (৳$_currentDue) er cheye beshi hote parbe na!',
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // API Simulation (api_collections.php action: create_collection)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Collection of ৳${amount.toStringAsFixed(0)} received from ${_selectedShop['name']}!',
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
                colors: [Color(0xFFECFDF5), Color(0xFFF0FDF4), Color(0xFFFFFFFF)],
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
                  BoxShadow(color: const Color(0xFF10B981).withOpacity(0.35), blurRadius: 90, spreadRadius: 25),
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
                  BoxShadow(color: const Color(0xFF059669).withOpacity(0.2), blurRadius: 100, spreadRadius: 30),
                ],
              ),
            ),
          ),

          // 3. Main Form Area
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
                              child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: Color(0xFF064E3B)),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Collect Due Cash',
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF064E3B),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF059669).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFF059669).withOpacity(0.3)),
                        ),
                        child: Text(
                          'Payment Audit',
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

                // Form Scrollable Area
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Target Shop Dropdown Card
                        _buildShopSelectorCard(),
                        const SizedBox(height: 16),

                        // Due Balance Summary Live Card
                        _buildDueSummaryCard(),
                        const SizedBox(height: 20),

                        // Collection Amount Input Field
                        Text(
                          'COLLECTION AMOUNT (BDT)',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: const Color(0xFF064E3B).withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildAmountInputField(),
                        const SizedBox(height: 18),

                        // Payment Method Selection
                        Text(
                          'PAYMENT METHOD',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: const Color(0xFF064E3B).withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildPaymentMethodChips(),
                        const SizedBox(height: 18),

                        // Reference No & Receipt Note
                        if (_paymentMethod != 'cash') ...[
                          _buildTextField(
                            label: 'Reference / TrxID / Check No',
                            hint: 'e.g. TRX9823482 or Slip #23',
                            icon: Icons.tag_rounded,
                            controller: _refNoController,
                          ),
                          const SizedBox(height: 14),
                        ],

                        _buildTextField(
                          label: 'Payment Note / Memo Remark',
                          hint: 'e.g. Received partial cash at market',
                          icon: Icons.note_alt_outlined,
                          controller: _noteController,
                        ),

                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 4. Floating Bottom Submission Action
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 22),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.92),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
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
                      // Collected Preview
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'COLLECTING TODAY',
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                            Text(
                              '৳${_enteredAmount.toStringAsFixed(2)}',
                              style: GoogleFonts.outfit(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF064E3B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Submit Collection Button
                      InkWell(
                        onTap: _isSubmitting ? null : _handleCollectDue,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF10B981), Color(0xFF047857)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF10B981).withOpacity(0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                            border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
                          ),
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : Row(
                                  children: [
                                    const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 18),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Save Collection',
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
                      const Icon(Icons.storefront_rounded, size: 18, color: Color(0xFF059669)),
                      const SizedBox(width: 6),
                      Text(
                        'Select Customer Shop',
                        style: GoogleFonts.outfit(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF064E3B),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Tap to switch',
                    style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF059669)),
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
                  child: DropdownButton<Map<String, dynamic>>(
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF064E3B),
                    ),
                    value: _selectedShop,
                    items: _shopsWithDue.map((shop) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: shop,
                        child: Text(
                          shop['name']!,
                          style: GoogleFonts.outfit(fontSize: 13.5, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedShop = val;
                          _amountController.clear();
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.phone_outlined, size: 13, color: Color(0xFF64748B)),
                  const SizedBox(width: 4),
                  Text(
                    _selectedShop['phone']!,
                    style: GoogleFonts.outfit(fontSize: 11.5, color: const Color(0xFF64748B)),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.location_on_outlined, size: 13, color: Color(0xFF64748B)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      _selectedShop['address']!,
                      style: GoogleFonts.outfit(fontSize: 11.5, color: const Color(0xFF64748B)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Due Balance & Remaining Balance Live Card
  Widget _buildDueSummaryCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2).withOpacity(0.85),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFFCA5A5).withOpacity(0.5), width: 1.5),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL PREVIOUS DUE',
                        style: GoogleFonts.outfit(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF991B1B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '৳${_currentDue.toStringAsFixed(0)}',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFDC2626),
                        ),
                      ),
                    ],
                  ),
                  Container(width: 1, height: 35, color: const Color(0xFFFCA5A5)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'NEW BALANCE AFTER CASH',
                        style: GoogleFonts.outfit(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF064E3B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '৳${_newRemainingDue.toStringAsFixed(0)}',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF047857),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 18, color: Color(0xFFFECACA)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last Payment Record:',
                    style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF7F1D1D)),
                  ),
                  Text(
                    _selectedShop['last_collection'] ?? 'N/A',
                    style: GoogleFonts.outfit(fontSize: 11.5, fontWeight: FontWeight.bold, color: const Color(0xFF7F1D1D)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Amount Input
  Widget _buildAmountInputField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _amountController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF064E3B),
        ),
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              '৳',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF059669)),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: TextButton(
            onPressed: () {
              // Quick full pay
              _amountController.text = _currentDue.toStringAsFixed(0);
            },
            child: Text(
              'FULL PAY',
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF059669),
              ),
            ),
          ),
          hintText: '0.00',
          hintStyle: GoogleFonts.outfit(fontSize: 22, color: const Color(0xFFCBD5E1)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  // Payment Method Chips
  Widget _buildPaymentMethodChips() {
    final methods = [
      {'key': 'cash', 'label': 'Cash', 'icon': Icons.payments_outlined},
      {'key': 'bkash', 'label': 'bKash', 'icon': Icons.mobile_friendly_rounded},
      {'key': 'nagad', 'label': 'Nagad', 'icon': Icons.phone_android_rounded},
      {'key': 'bank', 'label': 'Bank', 'icon': Icons.account_balance_rounded},
    ];

    return Row(
      children: methods.map((m) {
        final bool isSelected = _paymentMethod == m['key'];
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _paymentMethod = m['key'] as String;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF059669) : Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? const Color(0xFF059669) : const Color(0xFFE2E8F0),
                  width: 1.2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF059669).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : [],
              ),
              child: Column(
                children: [
                  Icon(
                    m['icon'] as IconData,
                    size: 18,
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    m['label'] as String,
                    style: GoogleFonts.outfit(
                      fontSize: 11.5,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? Colors.white : const Color(0xFF475569),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // General Text Field Helper
  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
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
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextField(
            controller: controller,
            style: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF0F172A)),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              hintText: hint,
              hintStyle: GoogleFonts.outfit(fontSize: 12.5, color: const Color(0xFF94A3B8)),
              prefixIcon: Icon(icon, size: 18, color: const Color(0xFF059669)),
            ),
          ),
        ),
      ],
    );
  }
}