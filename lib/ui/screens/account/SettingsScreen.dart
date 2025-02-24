import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/preferences.dart';
import 'package:patta/model/Language.dart';
import 'package:patta/ui/screens/account/FeedsScreen.dart';
import 'package:patta/ui/screens/account/LanguagesScreen.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/ui/screens/account/ThemesScreen.dart';
import 'package:patta/ui/screens/logs/LogsScreen.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsTab extends StatefulWidget {
  SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  Language selectedLanguage = Language.eng;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  void _loadLanguage() async {
    if (mounted) {
      setState(() {
        selectedLanguage = Preferences.getLanguage(Language.SETTINGS_KEY);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadLanguage();

    // example: https://github.com/yako-dev/flutter-settings-ui/blob/master/example/lib/screens/settings_screen.dart
    return Scaffold(
      appBar: AppBar(
          title: Text(I18n.get("settings")),
          backgroundColor: Theme.of(context).colorScheme.secondary
      ),
      body: SettingsList(
        lightTheme: AppThemes.version1SettingsThemeData,
        darkTheme: AppThemes.darkSettingsThemeData,
        sections: [
          SettingsSection(
            // title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                // TODO: use PariyattiIcon
                leading: Icon(Icons.language),
                title: Text(I18n.get("language")),
                value: Text(selectedLanguage.name),
                onPressed: (context) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => LanguagesScreen(),
                  ));
                },
              ),
              SettingsTile.navigation(
                // TODO: use PariyattiIcon
                  leading: Icon(Icons.language),
                  title: Text(I18n.get("language_alternate")),
                  value: Text(Language.eng.name),
                  onPressed: _showToast
              ),
              SettingsTile.navigation(
                // TODO: use PariyattiIcon
                leading: Icon(Icons.feed),
                title: Text(I18n.get("feeds")),
                value: Text(''),
                onPressed: (context) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => FeedsScreen(),
                  ));
                },
              ),
              SettingsTile.navigation(
                // TODO: use PariyattiIcon
                leading: Icon(Icons.nightlight_round),
                title: Text(I18n.get("theme")),
                value: Text(''),
                onPressed: (context) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ThemesScreen(),
                  ));
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.list_alt),
                title: Text(I18n.get("logs")),
                value: Text(''),
                onPressed: (context) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => LogsScreen(),
                  ));
                },
              ),
            ],
          ),
        ],
      )
    );

  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(I18n.get("only_english")),
        action: SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
