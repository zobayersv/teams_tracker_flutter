import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupervisorViewCatalogScreen extends StatefulWidget {
  const SupervisorViewCatalogScreen({super.key});

  @override
  State<SupervisorViewCatalogScreen> createState() =>
      _SupervisorViewCatalogScreenState();
}

class _SupervisorViewCatalogScreenState
    extends State<SupervisorViewCatalogScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  // Demo Product Catalog Database (api_supervisor_catalog.php থেকে ডাইনামিক হবে)
  final List _catalogProducts = [
    {
      'id': 'PRD-01',
      'sku': 'EGG-BR-01',
      'name': 'Brown Farm Egg (Large Grade-A)',
      'category': 'Farm Egg',
      'unit': 'Piece',
      'unit_price': 11.50,
      'crate_price': 1120.00,
      'crate_size': '100 Pcs Crate',
      'stock': 4200,
      'min_alert_stock': 800,
      'is_available': true,
      'last_restocked': '2026-11-02',
    },
    {
      'id': 'PRD-02',
      'sku': 'EGG-BR-02',
      'name': 'Brown Farm Egg (Medium Standard)',
      'category': 'Farm Egg',
      'unit': 'Piece',
      'unit_price': 10.80,
      'crate_price': 1050.00,
      'crate_size': '100 Pcs Crate',
      'stock': 2800,
      'min_alert_stock': 600,
      'is_available': true,
      'last_restocked': '2026-11-01',
    },
    {
      'id': 'PRD-03',
      'sku': 'EGG-WH-01',
      'name': 'White Premium Poultry Egg',
      'category': 'Premium',
      'unit': 'Piece',
      'unit_price': 10.20,
      'crate_price': 990.00,
      'crate_size': '100 Pcs Crate',
      'stock': 1950,
      'min_alert_stock': 500,
      'is_available': true,
      'last_restocked': '2026-10-30',
    },
    {
      'id': 'PRD-04',
      'sku': 'EGG-DK-01',
      'name': 'Native Duck Egg (Shonali Grade)',
      'category': 'Duck Egg',
      'unit': 'Piece',
      'unit_price': 15.00,
      'crate_price': 1450.00,
      'crate_size': '100 Pcs Crate',
      'stock': 320, // Low Stock Demo
      'min_alert_stock': 400,
      'is_available': true,
      'last_restocked': '2026-10-28',
    },
    {
      'id': 'PRD-05',
      'sku': 'EGG-ORG-01',
      'name': 'Organic Deshi Free-Range Egg',
      'category': 'Premium',
      'unit': 'Piece',
      'unit_price': 16.50,
      'crate_price': 1600.00,
      'crate_size': '100 Pcs Crate',
      'stock': 0, // Stock Out Demo
      'min_alert_stock': 300,
      'is_available': false,
      'last_restocked': '2026-10-20',
    },
    {
      'id': 'PRD-06',
      'sku': 'PKG-TRY-30',
      'name': 'Paper Egg Tray (30 Slot Standard)',
      'category': 'Packaging',
      'unit': 'Pack',
      'unit_price': 48.00,
      'crate_price': 450.00,
      'crate_size': '10 Packs Bundle',
      'stock': 450,
      'min_alert_stock': 150,
      'is_available': true,
      'last_restocked': '2026-10-25',
    },
    {
      'id': 'PRD-07',
      'sku': 'PKG-CRT-HD',
      'name': 'Plastic Crates (Transport Heavy Grade)',
      'category': 'Packaging',
      'unit': 'Piece',
      'unit_price': 350.00,
      'crate_price': 3400.00,
      'crate_size': '10 Pcs Set',
      'stock': 85,
      'min_alert_stock': 30,
      'is_available': true,
      'last_restocked': '2026-10-15',
    },
  ];

  final List _categories = [
    'All',
    'Farm Egg',
    'Premium',
    'Duck Egg',
    'Packaging',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List get _filteredProducts {
    final query = _searchController.text.toLowerCase().trim();
    return _catalogProducts.where((p) {
      final matchesSearch =
          p['name'].toString().toLowerCase().contains(query) ||
          p['sku'].toString().toLowerCase().contains(query);

      final matchesCategory =
          _selectedCategory == 'All' || p['category'] == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  // Supervisor Stock Audit Modal
  void _showProductAuditModal(Map<String, dynamic> item) {
    final int stock = item['stock'] as int;
    final int alertStock = item['min_alert_stock'] as int;
    final bool isOut = stock == 0;
    final bool isLow = stock > 0 && stock <= alertStock;

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
              color: Colors.white.withOpacity(0.96),
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

                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.14),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item['sku'],
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF047857),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isOut
                            ? const Color(0xFFFEE2E2)
                            : (isLow
                                  ? const Color(0xFFFEF3C7)
                                  : const Color(0xFFD1FAE5)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isOut
                            ? 'OUT OF STOCK'
                            : (isLow
                                  ? 'LOW STOCK ($stock)'
                                  : 'HEALTHY ($stock)'),
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: isOut
                              ? const Color(0xFFDC2626)
                              : (isLow
                                    ? const Color(0xFFB45309)
                                    : const Color(0xFF047857)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Text(
                  item['name'],
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF064E3B),
                  ),
                ),
                Text(
                  'Category: ${item['category']}  •  Unit: ${item['unit']}  •  Restocked: ${item['last_restocked']}',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 16),

                // Pricing Oversight Grid
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BASE UNIT RATE',
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '৳${item['unit_price']} / ${item['unit']}',
                              style: GoogleFonts.outfit(
                                fontSize: 15,
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
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFF10B981).withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BULK / CRATE RATE',
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF047857),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '৳${item['crate_price']} (${item['crate_size']})',
                              style: GoogleFonts.outfit(
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF047857),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Stock Health Alert Bar
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CENTRAL HUB STOCK',
                            style: GoogleFonts.outfit(
                              fontSize: 10.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          Text(
                            '$stock Units',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'MINIMUM BUFFER',
                            style: GoogleFonts.outfit(
                              fontSize: 10.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          Text(
                            '$alertStock Units',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Close Button
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF059669),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Done Oversight',
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final products = _filteredProducts;

    // Inventory KPI Counts
    final int totalSkus = _catalogProducts.length;
    final int totalUnits = _catalogProducts.fold(
      0,
      (sum, p) => sum + (p['stock'] as int),
    );
    final int lowStockCount = _catalogProducts.where((p) {
      final int s = p['stock'] as int;
      final int m = p['min_alert_stock'] as int;
      return s > 0 && s <= m;
    }).length;
    final int stockOutCount = _catalogProducts
        .where((p) => (p['stock'] as int) == 0)
        .length;

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
                                'Inventory Catalog',
                                style: GoogleFonts.outfit(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              Text(
                                'Central warehouse stock & crate rates',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: const Color(0xFF059669),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.14),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFF10B981).withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          '$totalSkus SKUs',
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

                // Inventory Health KPI Card
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 4,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.76),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            _buildKPIStat(
                              'Total Units',
                              '$totalUnits',
                              const Color(0xFF064E3B),
                            ),
                            Container(
                              width: 1,
                              height: 28,
                              color: const Color(0xFFE2E8F0),
                            ),
                            _buildKPIStat(
                              'Low Stock',
                              '$lowStockCount Items',
                              const Color(0xFFF59E0B),
                            ),
                            Container(
                              width: 1,
                              height: 28,
                              color: const Color(0xFFE2E8F0),
                            ),
                            _buildKPIStat(
                              'Stock Out',
                              '$stockOutCount Items',
                              const Color(0xFFEF4444),
                            ),
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
                      style: GoogleFonts.outfit(
                        fontSize: 13.5,
                        color: const Color(0xFF0F172A),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        hintText: 'Search products by title or SKU...',
                        hintStyle: GoogleFonts.outfit(
                          fontSize: 13,
                          color: const Color(0xFF94A3B8),
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Color(0xFF059669),
                          size: 20,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear_rounded,
                                  size: 18,
                                  color: Color(0xFF64748B),
                                ),
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

                // Category Filter Chips
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    itemCount: _categories.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final cat = _categories[index];
                      final bool isSelected = _selectedCategory == cat;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = cat;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF059669)
                                : Colors.white.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF059669)
                                  : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              cat,
                              style: GoogleFonts.outfit(
                                fontSize: 11.5,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF475569),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // Products Oversight List
                Expanded(
                  child: products.isEmpty
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
                                  Icons.inventory_2_outlined,
                                  size: 40,
                                  color: Color(0xFF059669),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No Products Found',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Try another keyword or category filter',
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
                          itemCount: products.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = products[index];
                            final int stock = item['stock'] as int;
                            final int alertStock =
                                item['min_alert_stock'] as int;
                            final bool isOut = stock == 0;
                            final bool isLow = stock > 0 && stock <= alertStock;

                            Color statusColor;
                            String statusLabel;

                            if (isOut) {
                              statusColor = const Color(0xFFEF4444);
                              statusLabel = 'STOCK OUT';
                            } else if (isLow) {
                              statusColor = const Color(0xFFF59E0B);
                              statusLabel = 'LOW: $stock';
                            } else {
                              statusColor = const Color(0xFF10B981);
                              statusLabel = '$stock IN STOCK';
                            }

                            return InkWell(
                              onTap: () => _showProductAuditModal(item),
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
                                        // Header: Product Name, SKU, and Stock Badge
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
                                              child: const Icon(
                                                Icons.egg_alt_rounded,
                                                size: 22,
                                                color: Color(0xFF059669),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item['name'],
                                                    style: GoogleFonts.outfit(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: const Color(
                                                        0xFF0F172A,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${item['sku']} • ${item['category']}',
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
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 3,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: statusColor.withOpacity(
                                                  0.14,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                statusLabel,
                                                style: GoogleFonts.outfit(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: statusColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const Divider(
                                          height: 16,
                                          color: Color(0xFFE2E8F0),
                                        ),

                                        // Rates Comparison Row
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'UNIT RATE',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 9.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                      0xFF64748B,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '৳${item['unit_price']} / ${item['unit']}',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                      0xFF064E3B,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'BULK CRATE RATE',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 9.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                      0xFF047857,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '৳${item['crate_price']} (${item['crate_size']})',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                      0xFF047857,
                                                    ),
                                                  ),
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

  Widget _buildKPIStat(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 15.5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}
