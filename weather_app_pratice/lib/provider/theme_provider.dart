import 'package:flutter/material.dart';
import 'package:weather_app_pratice/utils/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool _isSelected = false;
  bool get isSelected => _isSelected;

  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;

  void toggleThemefn() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }

    _isSelected = !_isSelected;
    notifyListeners();
  }
}
