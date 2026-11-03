import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:location_tracker/assets_helper/app_colors.dart';
import 'package:location_tracker/helpers/dark_&_light_mode_controller/theme_controller.dart';
import 'package:location_tracker/helpers/navigation_service.dart';

class UiThemeHelper {
  static const List<Color> availableColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.amber,
    Colors.cyan,
    Colors.indigo,
  ];

  // static const List<Map<String, String>> availableRoutes = [
  //   {'name': 'Home Screen', 'route': '/home'},
  //   {'name': 'Profile Screen', 'route': '/profile'},
  //   {'name': 'Dashboard Screen', 'route': '/dashboard'},
  //   {'name': 'Settings Screen', 'route': '/settings'},
  //   {'name': 'Explore Screen', 'route': '/explore'},
  // ];

  static void setColor(BuildContext context, Color color) {
    Provider.of<ThemeController>(context, listen: false).changeColor(color);
  }

  static Color getCurrentColor(BuildContext context) {
    return Provider.of<ThemeController>(context, listen: false).isDarkMode
        ? AppColors.c2F2F2F
        : Provider.of<ThemeController>(context, listen: false).appColor;
  }

  static void navigateToScreen(BuildContext context, String route) {
    Provider.of<ThemeController>(context, listen: false).changeRoute(route);
    NavigationService.navigateTo(route);
  }

  static Color getRandomColor() {
    return availableColors[DateTime.now().millisecond % availableColors.length];
  }

  static void setDarkMode(BuildContext context, bool value) {
    Provider.of<ThemeController>(context, listen: false).setDarkMode(value);
    if (!value) {
      Provider.of<ThemeController>(
        context,
        listen: false,
      ).changeColor(getRandomColor());
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Provider.of<ThemeController>(context, listen: false).isDarkMode;
  }
}
