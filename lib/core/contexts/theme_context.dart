import 'package:flutter/material.dart';

class ThemeContext extends ChangeNotifier {
  int _selectedTheme = 0;
  bool _isDark = false;

  int get selectedTheme => _selectedTheme;
  bool get isDark => _isDark;

  void setTheme(int theme) {
    _selectedTheme = theme;
    notifyListeners();
  }

  void setDark(bool dark) {
    _isDark = dark;
    notifyListeners();
  }
}
