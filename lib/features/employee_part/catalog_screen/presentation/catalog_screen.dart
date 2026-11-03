import 'dart:core';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  // Demo Product Inventory (api_products.php theke fetch hobe)
  final List<Map<String, dynamic>> _allProducts = [
    {
      'id': 1,
      'name': 'Brown Farm Egg (Large Grade-A)',
      'category': 'Farm Egg',
      'unit': 'Piece',
      'price_per_unit': 11.50,
      'box_price': 1120.00, // 100 pcs crate
      'box_size': '100 Pcs Box',
      'stock': 4200,
      'is_available': true,
      'sku': 'EGG-BR-01',
      'image':
          'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?auto=format&fit=crop&w=400&q=80',
    },
    {
      'id': 2,
      'name': 'Brown Farm Egg (Medium Standard)',
      'category': 'Farm Egg',
      'unit': 'Piece',
      'price_per_unit': 10.80,
      'box_price': 1050.00,
      'box_size': '100 Pcs Box',
      'stock': 2800,
      'is_available': true,
      'sku': 'EGG-BR-02',
      'image':
          'https://images.unsplash.com/photo-1506976785307-8732e854ad03?auto=format&fit=crop&w=400&q=80',
    },
    {
      'id': 3,
      'name': 'White Poultry Premium Egg',
      'category': 'Premium',
      'unit': 'Piece',
      'price_per_unit': 10.20,
      'box_price': 990.00,
      'box_size': '100 Pcs Box',
      'stock': 1950,
      'is_available': true,
      'sku': 'EGG-WH-01',
      'image':
          'https://images.unsplash.com/photo-1587486913049-53fc88980cfc?auto=format&fit=crop&w=400&q=80',
    },
    {
      'id': 4,
      'name': 'Native Duck Egg (Shonali Grade)',
      'category': 'Duck Egg',
      'unit': 'Piece',
      'price_per_unit': 15.00,
      'box_price': 1450.00,
      'box_size': '100 Pcs Box',
      'stock': 620,
      'is_available': true,
      'sku': 'EGG-DK-01',
      'image':
          'https://images.unsplash.com/photo-1569288052389-dac9b01c9c05?auto=format&fit=crop&w=400&q=80',
    },
    {
      'id': 5,
      'name': 'Organic Deshi Free-Range Egg',
      'category': 'Premium',
      'unit': 'Piece',
      'price_per_unit': 16.50,
      'box_price': 1600.00,
      'box_size': '100 Pcs Box',
      'stock': 0, // Stock Out demo
      'is_available': false,
      'sku': 'EGG-ORG-01',
      'image':
          'https://images.unsplash.com/photo-1498654077810-12c21d4d6dc3?auto=format&fit=crop&w=400&q=80',
    },
    {
      'id': 6,
      'name': 'Egg Paper Tray (30 Slot Molded)',
      'category': 'Packaging',
      'unit': 'Pack',
      'price_per_unit': 48.00,
      'box_price': 450.00,
      'box_size': '10 Packs Bundle',
      'stock': 450,
      'is_available': true,
      'sku': 'PKG-TRY-30',
      'image':
          'https://images.unsplash.com/photo-1516684669134-de6f7c473a2a?auto=format&fit=crop&w=400&q=80',
    },
    {
      'id': 7,
      'name': 'Heavy Duty Plastic Egg Crate',
      'category': 'Packaging',
      'unit': 'Piece',
      'price_per_unit': 350.00,
      'box_price': 3400.00,
      'box_size': '10 Pcs Set',
      'stock': 85,
      'is_available': true,
      'sku': 'PKG-CRT-HD',
      'image':
          'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&w=400&q=80',
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

  // Filtered Products onujayi search & category sorting
  List get _filteredProducts {
    final query = _searchController.text.toLowerCase().trim();
    return _allProducts.where((p) {
      final matchesCategory =
          _selectedCategory == 'All' || p['category'] == _selectedCategory;
      final matchesSearch =
          p['name'].toString().toLowerCase().contains(query) ||
          p['sku'].toString().toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  // Quick Product Detail / Stock Preview Modal
  void _showProductDetailsModal(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (context) {
        final bool inStock = item['is_available'] && (item['stock'] as int) > 0;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item['sku'] ?? 'SKU',
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
                        color: inStock
                            ? const Color(0xFFD1FAE5)
                            : const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        inStock ? 'IN STOCK (${item['stock']})' : 'STOCK OUT',
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: inStock
                              ? const Color(0xFF047857)
                              : const Color(0xFFDC2626),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: 60,
                        height: 60,
                        color: const Color(0xFFECFDF5),
                        child: CachedNetworkImage(
                          imageUrl: item['image']?.toString() ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF059669),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.image_outlined,
                            color: Color(0xFF059669),
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'],
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF064E3B),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Category: ${item['category']}  •  Unit: ${item['unit']}',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Multi-Tier Price Grid
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
                              'RETAIL PRICE',
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '৳${item['price_per_unit']} / ${item['unit']}',
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
                              'BULK / CRATE PRICE',
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF047857),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '৳${item['box_price']} (${item['box_size']})',
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
                const SizedBox(height: 20),

                // Book Order Button
                ElevatedButton.icon(
                  onPressed: inStock
                      ? () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${item['name']} added to order list!',
                                style: GoogleFonts.outfit(),
                              ),
                              backgroundColor: const Color(0xFF059669),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        }
                      : null,
                  icon: const Icon(
                    Icons.add_shopping_cart_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: Text(
                    'Book for Shop Order',
                    style: GoogleFonts.outfit(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final products = _filteredProducts;

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

          // 3. Main Catalog View
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
                            'Product Catalog',
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
                          '${_allProducts.length} Products',
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

                // Search Bar (Glossy Frosted)
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
                        hintText: 'Search products by name or SKU...',
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

                const SizedBox(height: 12),

                // Horizontal Category Filter Chips
                SizedBox(
                  height: 38,
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
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF059669)
                                : Colors.white.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF059669)
                                  : const Color(0xFFE2E8F0),
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF059669,
                                      ).withOpacity(0.28),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Text(
                            cat,
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF475569),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 14),

                // Product Items List / Empty View
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
                                'Try searching with another keyword or category',
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
                            final bool inStock =
                                item['is_available'] &&
                                (item['stock'] as int) > 0;

                            return InkWell(
                              onTap: () => _showProductDetailsModal(item),
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
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Product Image
                                            Container(
                                              width: 56,
                                              height: 56,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFECFDF5),
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                border: Border.all(
                                                  color: const Color(
                                                    0xFF10B981,
                                                  ).withOpacity(0.25),
                                                  width: 1.2,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      item['image']
                                                          ?.toString() ??
                                                      '',
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                        child: SizedBox(
                                                          width: 18,
                                                          height: 18,
                                                          child:
                                                              CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                color: Color(
                                                                  0xFF059669,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Icon(
                                                            Icons
                                                                .image_outlined,
                                                            size: 24,
                                                            color: Color(
                                                              0xFF059669,
                                                            ),
                                                          ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),

                                            // Product Title & SKU
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item['name'],
                                                    style: GoogleFonts.outfit(
                                                      fontSize: 14.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: const Color(
                                                        0xFF0F172A,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
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

                                            // Stock Badge
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 3,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: inStock
                                                    ? const Color(
                                                        0xFF10B981,
                                                      ).withOpacity(0.15)
                                                    : const Color(
                                                        0xFFEF4444,
                                                      ).withOpacity(0.15),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                inStock
                                                    ? '${item['stock']} In Stock'
                                                    : 'Out of Stock',
                                                style: GoogleFonts.outfit(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: inStock
                                                      ? const Color(0xFF047857)
                                                      : const Color(0xFFDC2626),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const Divider(
                                          height: 18,
                                          color: Color(0xFFE2E8F0),
                                        ),

                                        // Pricing Multi-Tier Row
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
                                                  '৳${item['price_per_unit']} / ${item['unit']}',
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
                                                  'WHOLESALE CRATE',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 9.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                      0xFF047857,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '৳${item['box_price']} (${item['box_size']})',
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
}
