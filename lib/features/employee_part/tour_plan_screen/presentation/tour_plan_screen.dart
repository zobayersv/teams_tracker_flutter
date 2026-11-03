import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TourPlanScreen extends StatefulWidget {
  const TourPlanScreen({super.key});

  @override
  State<TourPlanScreen> createState() => _TourPlanScreenState();
}

class _TourPlanScreenState extends State<TourPlanScreen> {
  int _selectedTab = 0; // 0: Upcoming / Active, 1: History / Completed

  // Demo Tour Plans (api_tours.php theke fetch hobe)
  final List _tourPlans = [
    {
      'id': 1,
      'title': 'Tongi Bazar & Station Road Market Audit',
      'area': 'Tongi & Gazipur Sadar',
      'tour_date': '2026-11-05',
      'target_shops': 14,
      'objective': 'Egg retailer expansion & outstanding due collection',
      'status': 'approved', // 'approved', 'pending', 'completed'
      'supervisor_remarks': 'Focus on large grocery wholesalers.',
    },
    {
      'id': 2,
      'title': 'Mohakhali Kacha Bazar & Wireless Gate',
      'area': 'Mohakhali C/A, Dhaka',
      'tour_date': '2026-11-07',
      'target_shops': 10,
      'objective': 'New client onboarding for Brown Farm eggs',
      'status': 'pending',
      'supervisor_remarks': null,
    },
    {
      'id': 3,
      'title': 'Banani Super Market & Chairman Bari Route',
      'area': 'Banani, Dhaka',
      'tour_date': '2026-10-28',
      'target_shops': 12,
      'objective': 'Regular weekly supply replenishment',
      'status': 'completed',
      'supervisor_remarks': 'Target accomplished successfully.',
    },
    {
      'id': 4,
      'title': 'Mirpur 10 & 11 Wholesale Circle',
      'area': 'Mirpur, Dhaka',
      'tour_date': '2026-10-22',
      'target_shops': 16,
      'objective': 'Paper tray and crate bulk distribution',
      'status': 'completed',
      'supervisor_remarks': 'Satisfactory recovery rate.',
    },
  ];

  // Open Create Tour Modal
  void _showCreateTourModal() {
    final titleController = TextEditingController();
    final areaController = TextEditingController();
    final shopsCountController = TextEditingController();
    final objectiveController = TextEditingController();
    DateTime selectedTourDate = DateTime.now().add(const Duration(days: 1));

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
                          'Submit New Tour Plan',
                          style: GoogleFonts.outfit(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF064E3B),
                          ),
                        ),
                        Text(
                          'Send your field visiting route for supervisor approval',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Tour Title
                        _buildModalTextField(
                          'Tour / Route Title',
                          'e.g. Uttara Sector 3 to 7 Visit',
                          Icons.route_outlined,
                          titleController,
                        ),
                        const SizedBox(height: 12),

                        // Target Area
                        _buildModalTextField(
                          'Target Territory / Market Area',
                          'e.g. Tongi Station Road, Gazipur',
                          Icons.location_city_rounded,
                          areaController,
                        ),
                        const SizedBox(height: 12),

                        // Date Selector Row
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Planned Tour Date',
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedTourDate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 90),
                                  ),
                                );
                                if (picked != null) {
                                  setModalState(() {
                                    selectedTourDate = picked;
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${selectedTourDate.year}-${selectedTourDate.month.toString().padLeft(2, '0')}-${selectedTourDate.day.toString().padLeft(2, '0')}",
                                      style: GoogleFonts.outfit(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.calendar_month_rounded,
                                      size: 18,
                                      color: Color(0xFF059669),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Target Shops Count
                        _buildModalTextField(
                          'Estimated Target Shops',
                          'e.g. 15',
                          Icons.storefront_rounded,
                          shopsCountController,
                          isNumber: true,
                        ),
                        const SizedBox(height: 12),

                        // Purpose / Objective
                        _buildModalTextField(
                          'Field Objective / Purpose',
                          'e.g. Due recovery and egg carton onboarding',
                          Icons.assignment_outlined,
                          objectiveController,
                        ),
                        const SizedBox(height: 20),

                        // Submit Button
                        ElevatedButton(
                          onPressed: () {
                            if (titleController.text.trim().isEmpty ||
                                areaController.text.trim().isEmpty) {
                              return;
                            }
                            Navigator.pop(context);

                            setState(() {
                              _tourPlans.insert(0, {
                                'id': DateTime.now().millisecondsSinceEpoch,
                                'title': titleController.text.trim(),
                                'area': areaController.text.trim(),
                                'tour_date':
                                    "${selectedTourDate.year}-${selectedTourDate.month.toString().padLeft(2, '0')}-${selectedTourDate.day.toString().padLeft(2, '0')}",
                                'target_shops':
                                    int.tryParse(
                                      shopsCountController.text.trim(),
                                    ) ??
                                    10,
                                'objective':
                                    objectiveController.text.trim().isNotEmpty
                                    ? objectiveController.text.trim()
                                    : 'Market expansion',
                                'status': 'pending',
                                'supervisor_remarks': null,
                              });
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Tour Plan submitted! Supervisor approval pending.',
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
                            'Submit for Approval',
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

  Widget _buildModalTextField(
    String label,
    String hint,
    IconData icon,
    TextEditingController controller, {
    bool isNumber = false,
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
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
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

    final filteredTours = _tourPlans.where((t) {
      if (_selectedTab == 0) {
        return t['status'] == 'approved' || t['status'] == 'pending';
      } else {
        return t['status'] == 'completed';
      }
    }).toList();

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
                          const SizedBox(width: 6),
                          Text(
                            'Tour Plans',
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF064E3B),
                            ),
                          ),
                        ],
                      ),

                      // Add Tour Button
                      InkWell(
                        onTap: _showCreateTourModal,
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
                                'New Plan',
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

                // Tab Switcher (Active vs History)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 6,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        _buildTabButton(0, 'Active & Upcoming'),
                        _buildTabButton(1, 'Completed Tours'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Tour Plans List / Empty View
                Expanded(
                  child: filteredTours.isEmpty
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
                                  Icons.map_outlined,
                                  size: 40,
                                  color: Color(0xFF059669),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No Tour Plans Found',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _selectedTab == 0
                                    ? 'Submit your field route by tapping + New Plan'
                                    : 'Completed tour reports will appear here',
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
                          itemCount: filteredTours.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = filteredTours[index];
                            final status = item['status'] as String;

                            Color statusColor;
                            String statusLabel;

                            if (status == 'approved') {
                              statusColor = const Color(0xFF10B981);
                              statusLabel = 'APPROVED';
                            } else if (status == 'pending') {
                              statusColor = const Color(0xFFF59E0B);
                              statusLabel = 'PENDING APPROVAL';
                            } else {
                              statusColor = const Color(0xFF0D9488);
                              statusLabel = 'COMPLETED';
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
                                      // Top Row: Title & Status Badge
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item['title'],
                                              style: GoogleFonts.outfit(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF0F172A),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
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
                                      const SizedBox(height: 6),

                                      // Area and Target Shops
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            size: 14,
                                            color: Color(0xFF059669),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              item['area'],
                                              style: GoogleFonts.outfit(
                                                fontSize: 12,
                                                color: const Color(0xFF475569),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),

                                      // Purpose
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.flag_outlined,
                                            size: 14,
                                            color: Color(0xFF64748B),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              item['objective'],
                                              style: GoogleFonts.outfit(
                                                fontSize: 12,
                                                color: const Color(0xFF64748B),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const Divider(
                                        height: 18,
                                        color: Color(0xFFE2E8F0),
                                      ),

                                      // Bottom Metadata (Date & Target Count)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_today_outlined,
                                                size: 13,
                                                color: Color(0xFF059669),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Date: ${item['tour_date']}',
                                                style: GoogleFonts.outfit(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color(
                                                    0xFF064E3B,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF1F5F9),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              'Target: ${item['target_shops']} Shops',
                                              style: GoogleFonts.outfit(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF1E293B),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Supervisor Remarks (if any)
                                      if (item['supervisor_remarks'] !=
                                          null) ...[
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.all(8),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons
                                                    .chat_bubble_outline_rounded,
                                                size: 14,
                                                color: Color(0xFF059669),
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  'Supervisor: ${item['supervisor_remarks']}',
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

  Widget _buildTabButton(int index, String title) {
    final bool isSelected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF059669) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 12.5,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }
}
