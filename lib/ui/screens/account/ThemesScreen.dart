import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/app/preferences.dart';
import 'package:patta/app/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class ThemesScreen extends StatefulWidget {
  @override
  _ThemesScreenState createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  late ThemeProvider themeProvider;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    setState(() {
      themeProvider.setThemeByString(Preferences.getString(AppThemes.SETTINGS_KEY));
    });
  }

  void _setLanguage(ThemeMode newValue) async {
    setState(() {
      themeProvider.setTheme(newValue);
      Preferences.setString(AppThemes.SETTINGS_KEY, newValue.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context, listen:false);
    return Scaffold(
      appBar: AppBar(
          title: Text(I18n.get("theme")),
          backgroundColor: Theme.of(context).colorScheme.secondary
      ),
      body: SettingsList(
        lightTheme: AppThemes.version1SettingsThemeData,
        darkTheme: AppThemes.darkSettingsThemeData,
        sections: [
          SettingsSection(tiles:
          [
            tile(context, themeProvider, I18n.get("light_theme"), ThemeMode.light),
            tile(context, themeProvider, I18n.get("dark_theme"), ThemeMode.dark),
            tile(context, themeProvider, I18n.get("system_default"), ThemeMode.system)
          ]),
        ],
      ),
    );
  }

  SettingsTile tile(BuildContext context, ThemeProvider themeProvider, String title, ThemeMode mode) {
    return SettingsTile(
        title: Text(title),
        trailing: trailingWidget(context, themeProvider, mode),
        onPressed: (BuildContext context) { _setLanguage(mode); }
    );
  }

  Widget trailingWidget(BuildContext context, ThemeProvider themeProvider, ThemeMode mode) {
    return (themeProvider.themeMode == mode) ? AppThemes.checkIcon(context) : Icon(null);
  }
}
