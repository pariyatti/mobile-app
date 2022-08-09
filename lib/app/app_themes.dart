import 'package:flutter/material.dart';
import 'package:patta/app/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class AppThemes {

  static const SETTINGS_KEY = "APP_THEME";

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

  static final darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      inversePrimary: const Color(0xffBA5626),
      inverseSurface: const Color(0xff8f7140),
      primary: const Color(0xff8f7140), // ok
      onPrimary: const Color(0xffeae9e7), // ok
      secondary: const Color(0xff8f7140), // ok
      onSecondary: const Color(0xffc1b196), // ok  c1b196 / 89857d
      surface: const Color(0xff524025), // ok
      onSurface: const Color(0xffcbc7be), // ok
      background: const Color(0xff292112), // ok
      onBackground: const Color(0xff908573), // ok
      error: const Color(0xffBA5626), // ok
      onError: const Color(0xfff4efe7) // ok
  );

  static final dark = ThemeData(colorScheme: darkColorScheme);

  static final darkSettingsThemeData = SettingsThemeData(
      trailingTextColor: darkColorScheme.onBackground,
      settingsSectionBackground: darkColorScheme.surface,
      settingsListBackground: darkColorScheme.background,
      dividerColor: darkColorScheme.background,
      tileHighlightColor: darkColorScheme.inverseSurface,
      titleTextColor: darkColorScheme.onBackground,
      leadingIconsColor: darkColorScheme.onSecondary,
      tileDescriptionTextColor: darkColorScheme.onBackground,
      settingsTileTextColor: darkColorScheme.onPrimary,
      inactiveTitleColor: darkColorScheme.inverseSurface,
      inactiveSubtitleColor: darkColorScheme.inverseSurface
  );

  static Image quoteBackground(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return themeProvider.isLight(context)
        ? Image.asset("assets/images/quote-bg-light-700px.png", fit: BoxFit.fitWidth)
        : Image.asset("assets/images/quote-bg-dark-brown-700px.png", fit: BoxFit.fitWidth);
  }

  static Color contextFreeDefault = const Color(0xff8f7140);

  static Color overlayText(String? hex) {
    var i = int.tryParse(hex?.replaceFirst('#', '0xFF') ?? "0xFFFFFFFF");
    return Color(i ?? 0xFFFFFFFF);
  }

  static checkIcon(BuildContext context) {
    return Icon(Icons.check, color: Theme.of(context).colorScheme.inversePrimary);
  }
}
