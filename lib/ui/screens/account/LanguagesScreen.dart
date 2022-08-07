import 'package:flutter/material.dart';
import 'package:patta/model/Language.dart';
import 'package:patta/ui/themes/app_themes.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  Language selectedLanguage = Language.eng;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  void _loadLanguage() async {
    // TODO: use 'Preferences' to remove duplication between this and WordsOfBuddhaCard.dart
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = Language.from(prefs.getString(Language.SETTINGS_KEY));
    });
  }

  void _setLanguage(Language? newValue) async {
    // TODO: SharedPreferences, Language.SETTINGS_KEY, etc. all belong in a wrapper (just "Preferences"?)
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = newValue!;
      prefs.setString(Language.SETTINGS_KEY, newValue.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<SettingsTile> tiles =
    Language.all.map((Language l) => SettingsTile(
        title: Text(l.name),
        trailing: trailingWidget(l),
        onPressed: (BuildContext context) { _setLanguage(l); }
    )).toList();

    return Scaffold(
      appBar: AppBar(
          title: Text('Languages'),
          backgroundColor: Theme.of(context).colorScheme.secondary
      ),
      body: SettingsList(
        lightTheme: AppThemes.version1SettingsThemeData,
        sections: [
          SettingsSection(tiles: tiles),
        ],
      ),
    );
  }

  Widget trailingWidget(Language l) {
    // TODO: centralize colours for light / dark mode
    return (selectedLanguage == l)
        ? Icon(Icons.check, color: Color.fromARGB(255, 186, 86, 38))
        : Icon(null);
  }
}
