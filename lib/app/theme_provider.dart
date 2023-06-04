import 'package:flutter/material.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/app/preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  ThemeProvider() {
    init();
  }

  bool isLight(BuildContext context) {
    if (themeMode == ThemeMode.system) {
      return Theme.of(context).brightness == Brightness.light;
    }
    return themeMode == ThemeMode.light;
  }

  Future<void> init() async {
    final themeStr = Preferences.getString(AppThemes.SETTINGS_KEY) ?? ThemeMode.system.toString();
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
