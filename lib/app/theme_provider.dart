import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  void setTheme(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }

  void setThemeByString(String? mode) {
    var themes = {"ThemeMode.light": ThemeMode.light, "ThemeMode.dark": ThemeMode.dark, "ThemeMode.system": ThemeMode.system};
    setTheme(themes[mode]!);
  }
}
