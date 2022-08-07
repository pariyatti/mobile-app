import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class AppThemes {

  static final version1ColorScheme = ColorScheme(
    brightness: Brightness.light,
    inversePrimary: const Color(0xffBA5626),
    inverseSurface: const Color(0xffd6d6d6),
    primary: const Color(0xffdcd3c0),
    onPrimary: const Color(0xff000000),
    secondary: const Color(0xffdcd3c0),
    onSecondary: const Color(0xff6d695f),
    surface: const Color(0xffffffff),
    onSurface: const Color(0xff000000),
    background: const Color(0xfff4efe7),
    onBackground: const Color(0xff6d695f),
    error: const Color(0xffBA5626),
    onError: const Color(0xfff4efe7)
  );

  static final version1 = ThemeData(colorScheme: version1ColorScheme);

  static final version1SettingsThemeData = SettingsThemeData(
    trailingTextColor: version1ColorScheme.onBackground,
    settingsSectionBackground: version1ColorScheme.surface,
    settingsListBackground: version1ColorScheme.background,
    dividerColor: version1ColorScheme.background,
    tileHighlightColor: version1ColorScheme.inverseSurface,
    titleTextColor: version1ColorScheme.onBackground,
    leadingIconsColor: version1ColorScheme.onSecondary,
    tileDescriptionTextColor: version1ColorScheme.onBackground,
    settingsTileTextColor: version1ColorScheme.onPrimary,
    inactiveTitleColor: version1ColorScheme.inverseSurface,
    inactiveSubtitleColor: version1ColorScheme.inverseSurface
  );

}
