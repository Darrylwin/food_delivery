import 'package:flutter/material.dart';
import 'package:food_delivery/services/theme/dark_theme.dart';
import 'package:food_delivery/services/theme/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isLightMode = true;

  get isLightMode => _isLightMode;

  ThemeData get currentTheme => _isLightMode ? lightMode : darkMode;

  void toggleTheme() {
    _isLightMode = !isLightMode;
    notifyListeners();
  }
}
