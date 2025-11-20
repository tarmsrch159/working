import 'package:flutter/material.dart';
import 'package:weather_app/utils/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool _isSelected = false;
  bool get isSelected => _isSelected;

  ThemeData _themeData = lightmode;
  ThemeData get themeData => _themeData;

  //void funtion สำหรับ เช็คเงื่อนไขและเปลี่ยน theme
  void toggleTheme() {
    if (_themeData == lightmode) {
      _themeData = darkmode;
    } else {
      _themeData = lightmode;
    }

    //เช็คเงื่อนไขแล้ว convert ตรงกันข้าม สำหรับเช็คเงื่อนไขปุ่มเปลี่ยนธีม
    _isSelected = !_isSelected;
    notifyListeners();
  }
}
