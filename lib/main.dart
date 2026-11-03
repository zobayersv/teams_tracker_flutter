import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location_tracker/assets_helper/app_colors.dart';
import 'package:location_tracker/constants/app_constants.dart';
import 'package:location_tracker/features/auth_screen/signin_screen.dart';
import 'package:location_tracker/features/employee_part/employee_bottom_nav.dart';
import 'package:location_tracker/features/supervisor_part/supervisor_bottom_nav.dart';
import 'package:location_tracker/helpers/all_routes.dart';
import 'package:location_tracker/helpers/di.dart';
import 'package:location_tracker/helpers/navigation_service.dart';
import 'package:location_tracker/networks/dio/dio.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage
  await GetStorage.init();

  // Setup Dependency Injection
  diSetup();

  // Initialize Dio Client
  DioSingleton.instance.create();

  // Configure Status Bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget _resolveInitialScreen() {
    final bool isLoggedIn = appData.read(kKeyIsLoggedIn) == true;
    final String? userRole = appData.read(kKeyUserRole)?.toString();

    if (isLoggedIn) {
      if (userRole == 'supervisor') {
        return const SupervisorBottomNav();
      } else if (userRole == 'employee') {
        return const EmployeeBottomNav();
      }
    }
    return const LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'TeamsLocator',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColors.c0D0F18,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              brightness: Brightness.dark,
            ),
          ),
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          home: _resolveInitialScreen(),
        );
      },
    );
  }
}
