import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupervisorViewTourScreen extends StatefulWidget {
  const SupervisorViewTourScreen({super.key});

  @override
  State<SupervisorViewTourScreen> createState() => _SupervisorViewTourScreenState();
}

class _SupervisorViewTourScreenState extends State<SupervisorViewTourScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Pending'; // 'Pending', 'Approved', 'Rejected', 'All'

  // Demo Tour Plans Database (api_supervisor_tours.php theke dynamic hobe)
  final List _tourRequests = [
    {
      'id': 'TOUR-401',
      'officer_name': 'Rahim Ahmed',
      'officer_id': 'EMP-101',
      'designation': 'Field Sales Executive',
      'territory': 'Tongi Station Road',
      'tour_title': 'Tongi Bazar & Station Wholesale Audit',
      'target_area': 'Tongi Station Road & Mill Gate Market',
      'tour_date': '2026-11-06',
      'target_shops': 16,
      'objective': 'Egg carton wholesale client onboarding and recovering overdue credits',
      'status': 'pending', // 'pending', 'approved', 'rejected'
      'supervisor_remarks': null,
    },
    {
      'id': 'TOUR-402',
      'officer_name': 'Kamrul Hasan',
      'officer_id': 'EMP-102',
      'designation': 'Senior Sales Officer',
      'territory': 'Gazipur Chowrasta',
      'tour_title': 'Chowrasta to Chandana Retail Blitz',
      'target_area': 'Chandana & Joydebpur Rail Gate Crossing',
      'tour_date': '2026-11-07',
      'target_shops': 20,
      'objective': 'Expanding White Poultry Egg supply to 12 new general stores',
      'status': 'pending',
      'supervisor_remarks': null,
    },
    {
      'id': 'TOUR-403',
      'officer_name': 'Tanvir Hossain',
      'officer_id': 'EMP-103',
      'designation': 'Field Executive',
      'territory': 'Board Bazar Zone',
      'tour_title': 'National University & Campus Route',
      'target_area': 'Board Bazar Super Market & Campus Outlet',
      'tour_date': '2026-11-02',
      'target_shops': 14,
      'objective': 'Plastic crate delivery and regular batch restock',
      'status': 'approved',
      'supervisor_remarks': 'Approved. Ensure high-grade tray safety during delivery.',
    },
    {
      'id': 'TOUR-404',
      'officer_name': 'Mehedi Hasan',
      'officer_id': 'EMP-104',
      'designation': 'Junior Sales Officer',
      'territory': 'Konabari Market',
      'tour_title': 'Konabari Outer Mill Belt Expansion',
      'target_area': 'Konabari Bypass & Factory Gate Stalls',
      'tour_date': '2026-10-31',
      'target_shops': 18,
      'objective': 'Exploring non-registered retailer counters for bulk orders',
      'status': 'rejected',
      'supervisor_remarks': 'High travel expense with low trade density. Re-align closer to main bazar.',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List get _filteredTours {
    final query = _searchController.text.toLowerCase().trim();
    return _tourRequests.where((tour) {
      final matchesSearch = tour['officer_name'].toString().toLowerCase().contains(query) ||
          tour['officer_id'].toString().toLowerCase().contains(query) ||
          tour['tour_title'].toString().toLowerCase().contains(query) ||
          tour['target_area'].toString().toLowerCase().contains(query);

      final matchesFilter = _selectedFilter == 'All' ||
          tour['status'].toString().toLowerCase() == _selectedFilter.toLowerCase();

      return matchesSearch && matchesFilter;
    }).toList();
  }

  // Interactive Tour Status Change Modal
  void _openTourStatusModal(Map<String, dynamic> tour) {
    final remarksController = TextEditingController(text: tour['supervisor_remarks'] ?? '');
    String currentAction = tour['status'] == 'pending' ? 'approved' : tour['status'];

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
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.96),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
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

                        // Title
                        Text(
                          'Review Field Tour Route',
                          style: GoogleFonts.outfit(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF064E3B),
                          ),
                        ),
                        Text(
                          'Officer: ${tour['officer_name']} (${tour['officer_id']})',
                          style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF64748B)),
                        ),
                        const SizedBox(height: 16),

                        // Tour Details Overview Box
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      tour['tour_title'],
                                      style: GoogleFonts.outfit(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981).withOpacity(0.14),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Target: ${tour['target_shops']} Shops',
                                      style: GoogleFonts.outfit(fontSize: 10.5, fontWeight: FontWeight.bold, color: const Color(0xFF047857)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF059669)),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      tour['target_area'],
                                      style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF475569)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month_rounded, size: 14, color: Color(0xFF059669)),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Date: ${tour['tour_date']}',
                                    style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF064E3B)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Objective: "${tour['objective']}"',
                                style: GoogleFonts.outfit(fontSize: 11.5, color: const Color(0xFF64748B), fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Action Selection (Approve / Reject / Hold)
                        Text(
                          'ASSIGN DECISION STATUS',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: const Color(0xFF064E3B).withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            // Approve Button
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setModalState(() => currentAction = 'approved'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: currentAction == 'approved' ? const Color(0xFF10B981) : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: currentAction == 'approved' ? const Color(0xFF10B981) : const Color(0xFFE2E8F0),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check_circle_rounded,
                                        size: 16,
                                        color: currentAction == 'approved' ? Colors.white : const Color(0xFF10B981),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Approve',
                                        style: GoogleFonts.outfit(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.bold,
                                          color: currentAction == 'approved' ? Colors.white : const Color(0xFF10B981),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Reject Button
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setModalState(() => currentAction = 'rejected'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: currentAction == 'rejected' ? const Color(0xFFEF4444) : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: currentAction == 'rejected' ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cancel_rounded,
                                        size: 16,
                                        color: currentAction == 'rejected' ? Colors.white : const Color(0xFFEF4444),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Reject',
                                        style: GoogleFonts.outfit(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.bold,
                                          color: currentAction == 'rejected' ? Colors.white : const Color(0xFFEF4444),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Pending Keep Button
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setModalState(() => currentAction = 'pending'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: currentAction == 'pending' ? const Color(0xFFF59E0B) : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: currentAction == 'pending' ? const Color(0xFFF59E0B) : const Color(0xFFE2E8F0),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.hourglass_top_rounded,
                                        size: 16,
                                        color: currentAction == 'pending' ? Colors.white : const Color(0xFFF59E0B),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Hold',
                                        style: GoogleFonts.outfit(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.bold,
                                          color: currentAction == 'pending' ? Colors.white : const Color(0xFFF59E0B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Supervisor Remarks / Route Instruction
                        Text(
                          'Route Guidance / Remarks (Optional)',
                          style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: TextField(
                            controller: remarksController,
                            maxLines: 2,
                            style: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF0F172A)),
                            decoration: InputDecoration(
                              hintText: 'e.g. Approved. Prioritize big wholesalers on station road.',
                              hintStyle: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF94A3B8)),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Confirm Save Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);

                            setState(() {
                              tour['status'] = currentAction;
                              tour['supervisor_remarks'] = remarksController.text.trim().isNotEmpty
                                  ? remarksController.text.trim()
                                  : (currentAction == 'approved' ? 'Tour Route Approved' : 'Tour Route Rejected');
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Tour Plan for ${tour['officer_name']} updated to ${currentAction.toUpperCase()}!',
                                  style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                                ),
                                backgroundColor: currentAction == 'approved'
                                    ? const Color(0xFF059669)
                                    : (currentAction == 'rejected' ? const Color(0xFFDC2626) : const Color(0xFFD97706)),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF059669),
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Text(
                            'Confirm & Save Status',
                            style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
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
    final tours = _filteredTours;

    final int pendingCount = _tourRequests.where((t) => t['status'] == 'pending').length;
    final int approvedCount = _tourRequests.where((t) => t['status'] == 'approved').length;
    final int rejectedCount = _tourRequests.where((t) => t['status'] == 'rejected').length;

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
                                'Tour Plan Requests',
                                style: GoogleFonts.outfit(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              Text(
                                'Verify & approve field officer travel routes',
                                style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF059669)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B).withOpacity(0.14),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFF59E0B).withOpacity(0.3)),
                        ),
                        child: Text(
                          '$pendingCount Pending',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFB45309),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Tour Route Overview KPI
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.76),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            _buildKPIStat('Pending', '$pendingCount', const Color(0xFFF59E0B)),
                            Container(width: 1, height: 28, color: const Color(0xFFE2E8F0)),
                            _buildKPIStat('Approved', '$approvedCount', const Color(0xFF10B981)),
                            Container(width: 1, height: 28, color: const Color(0xFFE2E8F0)),
                            _buildKPIStat('Rejected', '$rejectedCount', const Color(0xFFEF4444)),
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
                      style: GoogleFonts.outfit(fontSize: 13.5, color: const Color(0xFF0F172A)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        hintText: 'Search officer, route or market area...',
                        hintStyle: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF94A3B8)),
                        prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF059669), size: 20),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded, size: 18, color: Color(0xFF64748B)),
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

                // Filter Tabs (Pending, Approved, Rejected, All)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      _buildFilterChip('Pending'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Approved'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Rejected'),
                      const SizedBox(width: 8),
                      _buildFilterChip('All'),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Tour Requests List
                Expanded(
                  child: tours.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.map_outlined, size: 40, color: Color(0xFF059669)),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No Tour Requests Found',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'No plans listed under $_selectedFilter status',
                                style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF64748B)),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                          itemCount: tours.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = tours[index];
                            final status = item['status'] as String;

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

                            return InkWell(
                              onTap: () => _openTourStatusModal(item),
                              borderRadius: BorderRadius.circular(20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.76),
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
                                        // Header Row: Officer Name & Status
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFF10B981).withOpacity(0.14),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(Icons.route_outlined, size: 18, color: Color(0xFF059669)),
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item['officer_name'],
                                                      style: GoogleFonts.outfit(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        color: const Color(0xFF0F172A),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${item['officer_id']} • ${item['territory']}',
                                                      style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF64748B)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                              decoration: BoxDecoration(
                                                color: statusColor.withOpacity(0.14),
                                                borderRadius: BorderRadius.circular(8),
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

                                        const Divider(height: 18, color: Color(0xFFE2E8F0)),

                                        // Tour Title & Target Area
                                        Text(
                                          item['tour_title'],
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF064E3B),
                                          ),
                                        ),
                                        const SizedBox(height: 4),

                                        Row(
                                          children: [
                                            const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF059669)),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                item['target_area'],
                                                style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF475569)),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),

                                        // Objective Note
                                        Text(
                                          'Objective: ${item['objective']}',
                                          style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF64748B), height: 1.3),
                                        ),

                                        // Supervisor Remarks if any
                                        if (item['supervisor_remarks'] != null) ...[
                                          const SizedBox(height: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFECFDF5),
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: const Color(0xFF10B981).withOpacity(0.25)),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.comment_outlined, size: 13, color: Color(0xFF059669)),
                                                const SizedBox(width: 6),
                                                Expanded(
                                                  child: Text(
                                                    'Remarks: ${item['supervisor_remarks']}',
                                                    style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF047857), fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],

                                        const SizedBox(height: 10),

                                        // Bottom Action Trigger Row (Date & Target Shops)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.calendar_today_outlined, size: 12, color: Color(0xFF64748B)),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '${item['tour_date']}  •  Target: ${item['target_shops']} Shops',
                                                  style: GoogleFonts.outfit(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Change Status',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(0xFF059669),
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                const Icon(Icons.edit_note_rounded, size: 16, color: Color(0xFF059669)),
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
            style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
          Text(
            label,
            style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final bool isSelected = _selectedFilter == label;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = label;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF059669) : Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: isSelected ? const Color(0xFF059669) : const Color(0xFFE2E8F0)),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 11.5,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFF475569),
            ),
          ),
        ),
      ),
    );
  }
}