// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Demo notification list (Backend API theke fetch hobe)
  final List _notifications = [
    {
      'id': 1,
      'title': 'Leave Approved',
      'message':
          'Your sick leave application for 3 days has been approved by Supervisor Nayem.',
      'time': '10 mins ago',
      'type': 'leave',
      'is_read': false,
    },
    {
      'id': 2,
      'title': 'Late Check-in Logged',
      'message':
          'You checked in at 09:35 AM today. Official grace period is 09:15 AM.',
      'time': '2 hours ago',
      'type': 'attendance',
      'is_read': false,
    },
    {
      'id': 3,
      'title': 'New Order Verified',
      'message':
          'Order #ORD-3 for Rahman Brothers General Store (৳2,800) is confirmed.',
      'time': 'Yesterday',
      'type': 'order',
      'is_read': true,
    },
    {
      'id': 4,
      'title': 'Due Collection Logged',
      'message':
          'Cash collection of ৳4,800 received from Bismillah General Store.',
      'time': '22 Oct, 2026',
      'type': 'collection',
      'is_read': true,
    },
    {
      'id': 5,
      'title': 'Tour Plan Assigned',
      'message':
          'Admin assigned your weekly field route for Tongi Station & Gazipur Bazar.',
      'time': '20 Oct, 2026',
      'type': 'tour',
      'is_read': true,
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var item in _notifications) {
        item['is_read'] = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'All notifications marked as read',
          style: GoogleFonts.outfit(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF059669),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // void _clearNotifications() {
  //   setState(() {
  //     _notifications.clear();
  //   });
  // }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'leave':
        return Icons.event_available_rounded;
      case 'attendance':
        return Icons.timer_outlined;
      case 'order':
        return Icons.shopping_bag_outlined;
      case 'collection':
        return Icons.account_balance_wallet_outlined;
      case 'tour':
        return Icons.route_outlined;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'leave':
        return const Color(0xFF10B981); // Emerald
      case 'attendance':
        return const Color(0xFFF59E0B); // Amber Warning
      case 'order':
        return const Color(0xFF059669); // Forest Green
      case 'collection':
        return const Color(0xFF0D9488); // Teal
      case 'tour':
        return const Color(0xFF0284C7); // Sky Blue
      default:
        return const Color(0xFF64748B);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unreadCount = _notifications.where((n) => !n['is_read']).length;

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
            top: -50,
            right: -40,
            child: Container(
              width: 230,
              height: 230,
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
            bottom: 40,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFA7F3D0).withOpacity(0.4),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF059669).withOpacity(0.2),
                    blurRadius: 110,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),

          // 3. Main Content
          SafeArea(
            child: Column(
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
                            'Notifications',
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF064E3B),
                            ),
                          ),
                          if (unreadCount > 0) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '$unreadCount New',
                                style: GoogleFonts.outfit(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      // Mark all read button
                      if (_notifications.isNotEmpty)
                        TextButton(
                          onPressed: _markAllAsRead,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          child: Text(
                            'Mark all read',
                            style: GoogleFonts.outfit(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF059669),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Notification List / Empty View
                Expanded(
                  child: _notifications.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF10B981,
                                  ).withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.notifications_off_outlined,
                                  size: 48,
                                  color: Color(0xFF059669),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'No Notifications Yet',
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "You're completely up to date with official alerts.",
                                style: GoogleFonts.outfit(
                                  fontSize: 12.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          itemCount: _notifications.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final item = _notifications[index];
                            final bool isUnread = !item['is_read'];
                            final Color typeColor = _getTypeColor(item['type']);

                            return Dismissible(
                              key: Key(item['id'].toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEE2E2),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Color(0xFFDC2626),
                                ),
                              ),
                              onDismissed: (direction) {
                                setState(() {
                                  _notifications.removeAt(index);
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 14,
                                    sigmaY: 14,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: isUnread
                                          ? Colors.white.withOpacity(0.9)
                                          : Colors.white.withOpacity(0.68),
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: isUnread
                                            ? const Color(
                                                0xFF10B981,
                                              ).withOpacity(0.4)
                                            : Colors.white,
                                        width: isUnread ? 1.6 : 1.2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFF064E3B,
                                          ).withOpacity(0.05),
                                          blurRadius: 18,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Notification Type Icon
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: typeColor.withOpacity(0.12),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            _getTypeIcon(item['type']),
                                            color: typeColor,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 12),

                                        // Text Content
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      item['title'],
                                                      style: GoogleFonts.outfit(
                                                        fontSize: 14,
                                                        fontWeight: isUnread
                                                            ? FontWeight.bold
                                                            : FontWeight.w600,
                                                        color: const Color(
                                                          0xFF0F172A,
                                                        ),
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    item['time'],
                                                    style: GoogleFonts.outfit(
                                                      fontSize: 11,
                                                      color: const Color(
                                                        0xFF94A3B8,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                item['message'],
                                                style: GoogleFonts.outfit(
                                                  fontSize: 12.5,
                                                  height: 1.35,
                                                  color: const Color(
                                                    0xFF475569,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Unread Indicator Dot
                                        if (isUnread) ...[
                                          const SizedBox(width: 8),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              top: 4,
                                            ),
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF10B981),
                                            ),
                                          ),
                                        ],
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
