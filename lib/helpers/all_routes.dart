import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location_tracker/features/auth_screen/signin_screen.dart';
import 'package:location_tracker/features/auth_screen/signup_screen.dart';
import 'package:location_tracker/features/employee_part/catalog_screen/presentation/catalog_screen.dart';
import 'package:location_tracker/features/employee_part/employee_bottom_nav.dart';
import 'package:location_tracker/features/employee_part/home_screen/presentation/home_screen.dart';
import 'package:location_tracker/features/employee_part/leave_screen/presentation/leave_apply_screen.dart';
import 'package:location_tracker/features/employee_part/order_screen/presentation/collect_due_screen.dart';
import 'package:location_tracker/features/employee_part/order_screen/presentation/take_order_screen.dart';
import 'package:location_tracker/features/employee_part/profile_screen/presentation/edit_profile_screen.dart';
import 'package:location_tracker/features/employee_part/profile_screen/presentation/notification_screen.dart';
import 'package:location_tracker/features/employee_part/tour_plan_screen/presentation/tour_plan_screen.dart';
import 'package:location_tracker/features/supervisor_part/supervisor_bottom_nav.dart';
import 'package:location_tracker/features/supervisor_part/supervisor_home_screen/presentation/supervisor_dashboard_screen.dart';

enum RouteTransitionType { smoothFadeScale, slideRight, slideUp, cupertino }

final class Routes {
  static final Routes _routes = Routes._internal();

  Routes._internal();

  static Routes get instance => _routes;

  ///================== Auth & Bottom Nav ====================================
  static const splashScreen = '/splashScreen';
  static const bottomNavScreen = '/bottomNavScreen';
  static const employeeBottomNav = '/employeeBottomNav';
  static const supervisorBottomNav = '/supervisorBottomNav';
  static const logInScreen = '/logInScreen';
  static const signInScreen = '/signInScreen';
  static const signUpScreen = '/signUpScreen';
  static const notificationScreen = '/notificationScreen';
  static const homeScreen = '/homeScreen';
  static const takeOrder = '/takeOrder';
  static const profileScreen = '/profileScreen';
  static const editProfileScreen = '/editProfileScreen';
  static const collectDue = '/collectDue';
  static const catalogScreen = '/catalogScreen';
  static const tourPlanScreen = '/tourPlanScreen';
  static const leaveScreen = '/leaveScreen';
  static const supervisorDashboard = '/supervisorDashboard';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();

  RouteGenerator._internal();

  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.logInScreen:
      case Routes.signInScreen:
        return _buildSmoothRoute(
          widget: const LoginScreen(),
          settings: settings,
        );

      case Routes.signUpScreen:
        return _buildSmoothRoute(
          widget: const RegisterScreen(),
          settings: settings,
        );

      case Routes.bottomNavScreen:
      case Routes.employeeBottomNav:
        return _buildSmoothRoute(
          widget: const EmployeeBottomNav(),
          settings: settings,
        );

      case Routes.supervisorBottomNav:
        return _buildSmoothRoute(
          widget: const SupervisorBottomNav(),
          settings: settings,
        );

      case Routes.homeScreen:
        return _buildSmoothRoute(
          widget: const HomeScreen(),
          settings: settings,
        );

      case Routes.editProfileScreen:
        return _buildSmoothRoute(
          widget: const EditProfileScreen(),
          settings: settings,
        );

      case Routes.notificationScreen:
        return _buildSmoothRoute(
          widget: const NotificationScreen(),
          settings: settings,
        );

      case Routes.takeOrder:
        return _buildSmoothRoute(
          widget: const TakeOrderScreen(),
          settings: settings,
        );

      case Routes.collectDue:
        return _buildSmoothRoute(
          widget: const CollectDueScreen(),
          settings: settings,
        );

      case Routes.catalogScreen:
        return _buildSmoothRoute(
          widget: const CatalogScreen(),
          settings: settings,
        );

      case Routes.tourPlanScreen:
        return _buildSmoothRoute(
          widget: const TourPlanScreen(),
          settings: settings,
        );

      case Routes.leaveScreen:
        return _buildSmoothRoute(
          widget: const LeaveApplyScreen(),
          settings: settings,
        );

      case Routes.supervisorDashboard:
        return _buildSmoothRoute(
          widget: const SupervisorDashboardScreen(),
          settings: settings,
        );

      default:
        return _errorRoute(settings);
    }
  }

  static Route<dynamic> _buildSmoothRoute({
    required Widget widget,
    required RouteSettings settings,
    RouteTransitionType transitionType = RouteTransitionType.smoothFadeScale,
  }) {
    if (transitionType == RouteTransitionType.cupertino) {
      return CupertinoPageRoute(
        builder: (context) => widget,
        settings: settings,
      );
    }

    return FadedTransitionRoute(
      widget: widget,
      settings: settings,
      transitionType: transitionType,
    );
  }

  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return _buildSmoothRoute(
      widget: Scaffold(
        body: Center(child: Text('No route defined for ${settings.name}')),
      ),
      settings: settings,
    );
  }
}

/// Seamless, ultra-smooth page transition route that blends fade, micro-scale,
/// and subtle shared-axis motion so screen changes feel completely natural.
class FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;
  final RouteTransitionType transitionType;

  FadedTransitionRoute({
    required this.widget,
    required this.settings,
    this.transitionType = RouteTransitionType.smoothFadeScale,
    Duration duration = const Duration(milliseconds: 380),
    Duration reverseDuration = const Duration(milliseconds: 320),
  }) : super(
         settings: settings,
         transitionDuration: duration,
         reverseTransitionDuration: reverseDuration,
         pageBuilder:
             (
               BuildContext context,
               Animation<double> animation,
               Animation<double> secondaryAnimation,
             ) {
               return widget;
             },
         transitionsBuilder:
             (
               BuildContext context,
               Animation<double> animation,
               Animation<double> secondaryAnimation,
               Widget child,
             ) {
               final curvedAnimation = CurvedAnimation(
                 parent: animation,
                 curve: Curves.easeOutCubic,
                 reverseCurve: Curves.easeInCubic,
               );

               final secondaryCurvedAnimation = CurvedAnimation(
                 parent: secondaryAnimation,
                 curve: Curves.easeOutCubic,
                 reverseCurve: Curves.easeInCubic,
               );

               switch (transitionType) {
                 case RouteTransitionType.slideRight:
                   return SlideTransition(
                     position: Tween<Offset>(
                       begin: const Offset(0.08, 0.0),
                       end: Offset.zero,
                     ).animate(curvedAnimation),
                     child: FadeTransition(
                       opacity: curvedAnimation,
                       child: child,
                     ),
                   );

                 case RouteTransitionType.slideUp:
                   return SlideTransition(
                     position: Tween<Offset>(
                       begin: const Offset(0.0, 0.06),
                       end: Offset.zero,
                     ).animate(curvedAnimation),
                     child: FadeTransition(
                       opacity: curvedAnimation,
                       child: child,
                     ),
                   );

                 case RouteTransitionType.cupertino:
                 case RouteTransitionType.smoothFadeScale:
                   // Outgoing screen subtly scales down & fades slightly when a new route is pushed on top
                   return ScaleTransition(
                     scale: Tween<double>(
                       begin: 1.0,
                       end: 0.97,
                     ).animate(secondaryCurvedAnimation),
                     child: FadeTransition(
                       opacity: Tween<double>(
                         begin: 1.0,
                         end: 0.85,
                       ).animate(secondaryCurvedAnimation),
                       // Incoming screen smoothly fades in with a gentle micro-scale & vertical lift
                       child: FadeTransition(
                         opacity: Tween<double>(
                           begin: 0.0,
                           end: 1.0,
                         ).animate(curvedAnimation),
                         child: ScaleTransition(
                           scale: Tween<double>(
                             begin: 0.975,
                             end: 1.0,
                           ).animate(curvedAnimation),
                           child: SlideTransition(
                             position: Tween<Offset>(
                               begin: const Offset(0.0, 0.018),
                               end: Offset.zero,
                             ).animate(curvedAnimation),
                             child: child,
                           ),
                         ),
                       ),
                     ),
                   );
               }
             },
       );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 10),
            child: child,
          ),
        );
      },
      child: widget,
    );
  }
}
