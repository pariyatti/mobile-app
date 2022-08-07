import 'package:flutter/material.dart';
import 'package:patta/model/Language.dart';
import 'package:patta/ui/screens/account/FeedsScreen.dart';
import 'package:patta/ui/screens/account/LanguagesScreen.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/ui/screens/account/ThemesScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    // TODO: use 'Preferences' to remove duplication between this and WordsOfBuddhaCard.dart
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        selectedLanguage =
            Language.from(prefs.getString(Language.SETTINGS_KEY));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadLanguage();

    // example: https://github.com/yako-dev/flutter-settings-ui/blob/master/example/lib/screens/settings_screen.dart
    return SettingsList(
      lightTheme: AppThemes.version1SettingsThemeData,
      darkTheme: AppThemes.darkSettingsThemeData,
      sections: [
        SettingsSection(
          // title: Text('Common'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              // TODO: use PariyattiIcon
              leading: Icon(Icons.language),
              title: Text('Language'),
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
              title: Text('Alternate'),
              value: Text(Language.eng.name),
              onPressed: _showToast
            ),
            SettingsTile.navigation(
              // TODO: use PariyattiIcon
              leading: Icon(Icons.feed),
              title: Text('Feeds'),
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
              title: Text('Theme'),
              value: Text(''),
              onPressed: (context) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ThemesScreen(),
                ));
              },
            ),
          ],
        ),
      ],
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Only English is available as an Alternate Language at this time.'),
        action: SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
