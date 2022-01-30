import 'package:flutter/material.dart';
import 'package:patta/model/Language.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    List<DropdownMenuItem<Language>> items =
    Language.all.map<DropdownMenuItem<Language>>((Language l) {
      return DropdownMenuItem<Language>(
          value: l,
          child: Text(l.name));
    }).toList();
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      child: Row(
        children: [
          Text("Language:"),
          DropdownButton<Language>(
            icon: const Icon(Icons.arrow_downward),
            items: items,
            value: selectedLanguage,
            onChanged: _setLanguage
          )
        ]
      ),
    );
  }
}
