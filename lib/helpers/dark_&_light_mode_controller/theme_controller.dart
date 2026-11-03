import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends ChangeNotifier {
  Color _appColor = Colors.blue;
  String _currentRoute = '/home';
  bool _isDarkMode = false;

  ThemeController() {
    if (GetStorage().hasData('appColor')) {
      _appColor = Color(GetStorage().read('appColor'));
    }
    if (GetStorage().hasData('isDarkMode')) {
      _isDarkMode = GetStorage().read('isDarkMode');
    }
  }

  Color get appColor => _appColor;
  String get currentRoute => _currentRoute;
  bool get isDarkMode => _isDarkMode;

  void changeColor(Color color) {
    _appColor = color;
    GetStorage().write('appColor', color.toARGB32());
    notifyListeners();
  }

  void changeRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    GetStorage().write('isDarkMode', value);
    notifyListeners();
  }
}
