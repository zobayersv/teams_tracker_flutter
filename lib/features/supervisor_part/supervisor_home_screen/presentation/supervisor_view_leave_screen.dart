import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupervisorViewLeaveScreen extends StatefulWidget {
  const SupervisorViewLeaveScreen({super.key});

  @override
  State<SupervisorViewLeaveScreen> createState() =>
      _SupervisorViewLeaveScreenState();
}

class _SupervisorViewLeaveScreenState extends State<SupervisorViewLeaveScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter =
      'Pending'; // 'Pending', 'Approved', 'Rejected', 'All'

  // Demo Leave Applications Database (api_supervisor_leaves.php theke dynamic hobe)
  final List _leaveRequests = [
    {
      'id': 'LEV-101',
      'officer_name': 'Mehedi Hasan',
      'officer_id': 'EMP-104',
      'designation': 'Junior Sales Officer',
      'territory': 'Konabari Industrial Market',
      'leave_type': 'Sick Leave',
      'from_date': '2026-11-05',
      'to_date': '2026-11-07',
      'days': 3,
      'reason':
          'Severe seasonal viral fever and acute throat infection. Prescribed bed rest.',
      'applied_date': '2026-11-03',
      'status': 'pending', // 'pending', 'approved', 'rejected'
      'supervisor_remarks': null,
    },
    {
      'id': 'LEV-102',
      'officer_name': 'Kamrul Hasan',
      'officer_id': 'EMP-102',
      'designation': 'Senior Sales Officer',
      'territory': 'Gazipur Chowrasta',
      'leave_type': 'Casual Leave',
      'from_date': '2026-11-09',
      'to_date': '2026-11-10',
      'days': 2,
      'reason':
          'Family emergency and land registration matter at hometown village.',
      'applied_date': '2026-11-02',
      'status': 'pending',
      'supervisor_remarks': null,
    },
    {
      'id': 'LEV-103',
      'officer_name': 'Rahim Ahmed',
      'officer_id': 'EMP-101',
      'designation': 'Field Sales Executive',
      'territory': 'Tongi Station Road',
      'leave_type': 'Casual Leave',
      'from_date': '2026-10-24',
      'to_date': '2026-10-25',
      'days': 2,
      'reason': 'Sister wedding ceremony invitation and management.',
      'applied_date': '2026-10-20',
      'status': 'approved',
      'supervisor_remarks': 'Approved with coverage handover to Tanvir.',
    },
    {
      'id': 'LEV-104',
      'officer_name': 'Tanvir Hossain',
      'officer_id': 'EMP-103',
      'designation': 'Field Executive',
      'territory': 'Board Bazar Zone',
      'leave_type': 'Emergency Leave',
      'from_date': '2026-10-18',
      'to_date': '2026-10-18',
      'days': 1,
      'reason': 'Personal bank and official documentation errand.',
      'applied_date': '2026-10-18',
      'status': 'rejected',
      'supervisor_remarks':
          'Peak weekly collection day. Route visit cannot be skipped.',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List get _filteredLeaves {
    final query = _searchController.text.toLowerCase().trim();
    return _leaveRequests.where((leave) {
      final matchesSearch =
          leave['officer_name'].toString().toLowerCase().contains(query) ||
          leave['officer_id'].toString().toLowerCase().contains(query) ||
          leave['territory'].toString().toLowerCase().contains(query) ||
          leave['leave_type'].toString().toLowerCase().contains(query);

      final matchesFilter =
          _selectedFilter == 'All' ||
          leave['status'].toString().toLowerCase() ==
              _selectedFilter.toLowerCase();

      return matchesSearch && matchesFilter;
    }).toList();
  }

  // Status Change Dialog with Optional Remarks
  void _openStatusChangeModal(Map<String, dynamic> leave) {
    final remarksController = TextEditingController(
      text: leave['supervisor_remarks'] ?? '',
    );
    String currentAction = leave['status'] == 'pending'
        ? 'approved'
        : leave['status'];

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

                        // Title
                        Text(
                          'Update Leave Status',
                          style: GoogleFonts.outfit(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF064E3B),
                          ),
                        ),
                        Text(
                          'Officer: ${leave['officer_name']} (${leave['officer_id']})',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Application Overview Card
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${leave['leave_type']} (${leave['days']} Days)',
                                    style: GoogleFonts.outfit(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  Text(
                                    '${leave['from_date']} to ${leave['to_date']}',
                                    style: GoogleFonts.outfit(
                                      fontSize: 11.5,
                                      color: const Color(0xFF059669),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Reason: "${leave['reason']}"',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: const Color(0xFF475569),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Action Selection (Approve / Reject / Pending)
                        Text(
                          'SELECT NEW STATUS',
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
                                onTap: () => setModalState(
                                  () => currentAction = 'approved',
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: currentAction == 'approved'
                                        ? const Color(0xFF10B981)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: currentAction == 'approved'
                                          ? const Color(0xFF10B981)
                                          : const Color(0xFFE2E8F0),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check_circle_rounded,
                                        size: 16,
                                        color: currentAction == 'approved'
                                            ? Colors.white
                                            : const Color(0xFF10B981),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Approve',
                                        style: GoogleFonts.outfit(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.bold,
                                          color: currentAction == 'approved'
                                              ? Colors.white
                                              : const Color(0xFF10B981),
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
                                onTap: () => setModalState(
                                  () => currentAction = 'rejected',
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: currentAction == 'rejected'
                                        ? const Color(0xFFEF4444)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: currentAction == 'rejected'
                                          ? const Color(0xFFEF4444)
                                          : const Color(0xFFE2E8F0),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cancel_rounded,
                                        size: 16,
                                        color: currentAction == 'rejected'
                                            ? Colors.white
                                            : const Color(0xFFEF4444),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Reject',
                                        style: GoogleFonts.outfit(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.bold,
                                          color: currentAction == 'rejected'
                                              ? Colors.white
                                              : const Color(0xFFEF4444),
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
                                onTap: () => setModalState(
                                  () => currentAction = 'pending',
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: currentAction == 'pending'
                                        ? const Color(0xFFF59E0B)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: currentAction == 'pending'
                                          ? const Color(0xFFF59E0B)
                                          : const Color(0xFFE2E8F0),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.hourglass_top_rounded,
                                        size: 16,
                                        color: currentAction == 'pending'
                                            ? Colors.white
                                            : const Color(0xFFF59E0B),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Hold',
                                        style: GoogleFonts.outfit(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.bold,
                                          color: currentAction == 'pending'
                                              ? Colors.white
                                              : const Color(0xFFF59E0B),
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

                        // Supervisor Remarks / Decision Note
                        Text(
                          'Supervisor Remark / Note (Optional)',
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
                            controller: remarksController,
                            maxLines: 2,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              color: const Color(0xFF0F172A),
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  'e.g. Approved. Rahim will handle market coverage.',
                              hintStyle: GoogleFonts.outfit(
                                fontSize: 12,
                                color: const Color(0xFF94A3B8),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Confirm Update Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);

                            setState(() {
                              leave['status'] = currentAction;
                              leave['supervisor_remarks'] =
                                  remarksController.text.trim().isNotEmpty
                                  ? remarksController.text.trim()
                                  : (currentAction == 'approved'
                                        ? 'Approved by Supervisor'
                                        : 'Rejected by Supervisor');
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Leave application for ${leave['officer_name']} marked as ${currentAction.toUpperCase()}!',
                                  style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                backgroundColor: currentAction == 'approved'
                                    ? const Color(0xFF059669)
                                    : (currentAction == 'rejected'
                                          ? const Color(0xFFDC2626)
                                          : const Color(0xFFD97706)),
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
                            'Confirm & Save Status',
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
    final leaves = _filteredLeaves;

    final int pendingCount = _leaveRequests
        .where((l) => l['status'] == 'pending')
        .length;
    final int approvedCount = _leaveRequests
        .where((l) => l['status'] == 'approved')
        .length;
    final int rejectedCount = _leaveRequests
        .where((l) => l['status'] == 'rejected')
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
                                'Staff Leave Requests',
                                style: GoogleFonts.outfit(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              Text(
                                'Review & change field team leave status',
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
                          color: const Color(0xFFF59E0B).withOpacity(0.14),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFF59E0B).withOpacity(0.3),
                          ),
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

                // Leave Portfolio Overview KPI
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
                              'Pending',
                              '$pendingCount',
                              const Color(0xFFF59E0B),
                            ),
                            Container(
                              width: 1,
                              height: 28,
                              color: const Color(0xFFE2E8F0),
                            ),
                            _buildKPIStat(
                              'Approved',
                              '$approvedCount',
                              const Color(0xFF10B981),
                            ),
                            Container(
                              width: 1,
                              height: 28,
                              color: const Color(0xFFE2E8F0),
                            ),
                            _buildKPIStat(
                              'Rejected',
                              '$rejectedCount',
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
                        hintText: 'Search officer, leave type or area...',
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

                // Leave Requests List
                Expanded(
                  child: leaves.isEmpty
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
                                  Icons.event_available_outlined,
                                  size: 40,
                                  color: Color(0xFF059669),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No Leave Requests Found',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'No applications under $_selectedFilter filter',
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
                          itemCount: leaves.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = leaves[index];
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
                              onTap: () => _openStatusChangeModal(item),
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
                                        // Top Row: Officer Name & Current Status Badge
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                      0xFF10B981,
                                                    ).withOpacity(0.14),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons
                                                        .person_outline_rounded,
                                                    size: 18,
                                                    color: Color(0xFF059669),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item['officer_name'],
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
                                                      '${item['officer_id']} • ${item['territory']}',
                                                      style: GoogleFonts.outfit(
                                                        fontSize: 11,
                                                        color: const Color(
                                                          0xFF64748B,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                                          height: 18,
                                          color: Color(0xFFE2E8F0),
                                        ),

                                        // Leave Details Row
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today_outlined,
                                              size: 14,
                                              color: Color(0xFF059669),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${item['leave_type']}: ${item['from_date']} to ${item['to_date']}',
                                              style: GoogleFonts.outfit(
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF064E3B),
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 1.5,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF1F5F9),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                '${item['days']} Days',
                                                style: GoogleFonts.outfit(
                                                  fontSize: 10.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(
                                                    0xFF475569,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),

                                        // Reason Description
                                        Text(
                                          'Reason: ${item['reason']}',
                                          style: GoogleFonts.outfit(
                                            fontSize: 12,
                                            color: const Color(0xFF475569),
                                            height: 1.3,
                                          ),
                                        ),

                                        // Supervisor Remarks (if present)
                                        if (item['supervisor_remarks'] !=
                                            null) ...[
                                          const SizedBox(height: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFECFDF5),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(
                                                  0xFF10B981,
                                                ).withOpacity(0.25),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.comment_outlined,
                                                  size: 13,
                                                  color: Color(0xFF059669),
                                                ),
                                                const SizedBox(width: 6),
                                                Expanded(
                                                  child: Text(
                                                    'Remarks: ${item['supervisor_remarks']}',
                                                    style: GoogleFonts.outfit(
                                                      fontSize: 11,
                                                      color: const Color(
                                                        0xFF047857,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],

                                        const SizedBox(height: 10),

                                        // Bottom Action Trigger Row
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Applied: ${item['applied_date']}',
                                              style: GoogleFonts.outfit(
                                                fontSize: 11,
                                                color: const Color(0xFF94A3B8),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Change Status',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                      0xFF059669,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                const Icon(
                                                  Icons.edit_note_rounded,
                                                  size: 16,
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

  Widget _buildKPIStat(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 16,
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
            color: isSelected
                ? const Color(0xFF059669)
                : Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF059669)
                  : const Color(0xFFE2E8F0),
            ),
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
