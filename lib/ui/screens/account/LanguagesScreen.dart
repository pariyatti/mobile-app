import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/model/Language.dart';
import 'package:patta/app/app_themes.dart';
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
    // TODO: SharedPreferences, Language.SETTINGS_KEY, I18n.set, etc. all belong in a wrapper (just "Preferences"?)
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = newValue!;
      I18n.set(newValue!);
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
          title: Text(I18n.get("languages")),
          backgroundColor: Theme.of(context).colorScheme.secondary
      ),
      body: SettingsList(
        lightTheme: AppThemes.version1SettingsThemeData,
        darkTheme: AppThemes.darkSettingsThemeData,
        sections: [
          SettingsSection(tiles: tiles),
        ],
      ),
    );
  }

  Widget trailingWidget(Language l) {
    return (selectedLanguage == l) ? AppThemes.checkIcon(context) : Icon(null);
  }
}
