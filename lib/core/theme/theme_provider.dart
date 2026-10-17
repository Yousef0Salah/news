import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode theme = ThemeMode.light;

  void changeTheme(ThemeMode newTheme) {
    theme = newTheme;
    notifyListeners();
  }
}
