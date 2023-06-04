import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/preferences.dart';
import 'package:patta/model/Language.dart';
import 'package:patta/app/app_themes.dart';
import 'package:settings_ui/settings_ui.dart';

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
    setState(() {
      selectedLanguage = Preferences.getLanguage(Language.SETTINGS_KEY);
    });
  }

  void _setLanguage(Language? newValue) async {
    setState(() {
      selectedLanguage = newValue!;
      I18n.set(newValue);
      Preferences.setLanguage(Language.SETTINGS_KEY, newValue);
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
