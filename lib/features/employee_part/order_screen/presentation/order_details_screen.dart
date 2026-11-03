import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List items = order['items'] ?? [];
    final bool isPaid = order['payment_status'] == 'paid';

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
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
          Positioned(
            top: -50,
            right: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF34D399).withOpacity(0.35),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF10B981).withOpacity(0.3), blurRadius: 90, spreadRadius: 25),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Text(
                        'Order #${order['order_id']}',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF064E3B),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                // Order Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shop & Order Header Card
                        ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.75),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          order['shop_name'] ?? 'Shop Name',
                                          style: GoogleFonts.outfit(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF064E3B),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: isPaid ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          isPaid ? 'PAID' : 'DUE',
                                          style: GoogleFonts.outfit(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.phone_outlined, size: 15, color: Color(0xFF059669)),
                                      const SizedBox(width: 6),
                                      Text(
                                        order['shop_phone'] ?? 'N/A',
                                        style: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF475569)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined, size: 15, color: Color(0xFF059669)),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          order['shop_address'] ?? 'N/A',
                                          style: GoogleFonts.outfit(fontSize: 12.5, color: const Color(0xFF64748B)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(height: 22, color: Color(0xFFE2E8F0)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Date: ${order['order_date']}',
                                        style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF64748B)),
                                      ),
                                      Text(
                                        'Status: ${order['order_status'] ?? 'Delivered'}',
                                        style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF047857)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        Text(
                          'ORDERED PRODUCTS',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: const Color(0xFF064E3B).withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Item List Card
                        ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.75),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                separatorBuilder: (context, index) => const Divider(height: 18, color: Color(0xFFE2E8F0)),
                                itemBuilder: (context, index) {
                                  final it = items[index];
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              it['product_name'] ?? 'Product',
                                              style: GoogleFonts.outfit(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF0F172A),
                                              ),
                                            ),
                                            Text(
                                              '${it['quantity']} pcs x ৳${it['unit_price']}',
                                              style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF64748B)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '৳${it['subtotal']}',
                                        style: GoogleFonts.outfit(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF064E3B),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Grand Total Calculation Card
                        ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Grand Total Amount',
                                    style: GoogleFonts.outfit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF064E3B),
                                    ),
                                  ),
                                  Text(
                                    '৳${order['total_amount']}',
                                    style: GoogleFonts.outfit(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF064E3B),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}