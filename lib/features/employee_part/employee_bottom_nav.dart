// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location_tracker/features/employee_part/attendence_screen/presentation/attendance_list_screen.dart';
import 'package:location_tracker/features/employee_part/home_screen/presentation/home_screen.dart';
import 'package:location_tracker/features/employee_part/order_screen/presentation/order_screen.dart';
import 'package:location_tracker/features/employee_part/profile_screen/presentation/profile_screen.dart';
import 'package:location_tracker/helpers/all_routes.dart';
import 'package:location_tracker/helpers/navigation_service.dart';

class EmployeeBottomNav extends StatefulWidget {
  const EmployeeBottomNav({super.key});

  @override
  State<EmployeeBottomNav> createState() => _EmployeeBottomNavState();
}

class _EmployeeBottomNavState extends State<EmployeeBottomNav> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      const OrderListScreen(),
      const AttendanceListScreen(),
      const ProfileScreen(),
    ];
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _openQuickActionModal() {
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
              color: Colors.white.withOpacity(0.94),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Quick Field Actions',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF064E3B),
                  ),
                ),
                const SizedBox(height: 18),
                _buildQuickActionItem(
                  icon: Icons.add_shopping_cart_rounded,
                  title: 'New Order Booking',
                  subtitle: 'Select shop and take product orders',
                  color: const Color(0xFF10B981),
                  onTap: () {
                    Navigator.pop(context);
                    NavigationService.navigateTo(Routes.takeOrder);
                  },
                ),
                const SizedBox(height: 10),
                _buildQuickActionItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Collect Due Payment',
                  subtitle: 'Receive shop collection & issue receipt',
                  color: const Color(0xFF047857),
                  onTap: () {
                    Navigator.pop(context);
                    NavigationService.navigateTo(Routes.collectDue);
                  },
                ),
                const SizedBox(height: 10),
                _buildQuickActionItem(
                  icon: Icons.add_location_alt_outlined,
                  title: 'New Tour Plan',
                  subtitle: 'Submit daily market visiting route',
                  color: const Color(0xFF0D9488),
                  onTap: () {
                    Navigator.pop(context);
                    NavigationService.navigateTo(Routes.tourPlanScreen);
                  },
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: color.withOpacity(0.16),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _pages),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFF34D399), Color(0xFF059669)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF059669).withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 7),
            ),
          ],
          border: Border.all(color: Colors.white, width: 3.5),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _openQuickActionModal,
            customBorder: const CircleBorder(),
            child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        height: 72,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF064E3B).withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildNavItem(0, Icons.grid_view_rounded, "Home"),
                      const SizedBox(width: 8),
                      _buildNavItem(1, Icons.shopping_bag_outlined, "Orders"),
                    ],
                  ),
                  const SizedBox(width: 48),
                  Row(
                    children: [
                      _buildNavItem(2, Icons.access_time_rounded, "Attendance"),
                      const SizedBox(width: 8),
                      _buildNavItem(3, Icons.person_outline_rounded, "Profile"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = _currentIndex == index;

    return InkWell(
      onTap: () => _onTabSelected(index),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF10B981).withOpacity(0.14)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 21,
              color: isSelected
                  ? const Color(0xFF047857)
                  : const Color(0xFF94A3B8),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF047857)
                    : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
