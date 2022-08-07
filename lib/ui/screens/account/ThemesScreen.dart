import 'package:flutter/material.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/app/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class ThemesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen:false);

    return Scaffold(
      appBar: AppBar(
          title: Text('Theme'),
          backgroundColor: Theme.of(context).colorScheme.secondary
      ),
      body: SettingsList(
        lightTheme: AppThemes.version1SettingsThemeData,
        darkTheme: AppThemes.darkSettingsThemeData,
        sections: [
          SettingsSection(tiles:
          [
            tile(context, themeProvider, "Light Theme", ThemeMode.light),
            tile(context, themeProvider, "Dark Theme", ThemeMode.dark),
            tile(context, themeProvider, "System Default", ThemeMode.system)
          ]),
        ],
      ),
    );
  }

  SettingsTile tile(BuildContext context, ThemeProvider themeProvider, String title, ThemeMode mode) {
    return SettingsTile(
        title: Text(title),
        trailing: trailingWidget(context, themeProvider, mode),
        onPressed: (BuildContext context) { themeProvider.setTheme(mode); }
    );
  }

  Widget trailingWidget(BuildContext context, ThemeProvider themeProvider, ThemeMode mode) {
    return (themeProvider.themeMode == mode) ? AppThemes.checkIcon(context) : Icon(null);
  }
}
