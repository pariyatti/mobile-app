import 'package:flutter/material.dart';
import 'package:patta/app/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  ThemeProvider() {
    init();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final themeStr = prefs.getString(AppThemes.SETTINGS_KEY) ?? ThemeMode.system.toString();
    setThemeByString(themeStr);
  }

  void setTheme(ThemeMode mode) async {
    themeMode = mode;
    notifyListeners();
  }

  void setThemeByString(String? mode) async {
    var themes = {"ThemeMode.light": ThemeMode.light, "ThemeMode.dark": ThemeMode.dark, "ThemeMode.system": ThemeMode.system};
    setTheme(themes[mode] ?? ThemeMode.system);
  }
}
