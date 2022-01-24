import 'package:flutter/material.dart';
import 'package:patta/model/Language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsTab extends StatefulWidget {
  SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  static const String SETTINGS_KEY = 'language';
  Language selectedLanguage = Language.eng;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  void _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = Language.from(prefs.getString(SETTINGS_KEY));
    });
  }

  void _setLanguage(Language? newValue) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = newValue!;
      prefs.setString(SETTINGS_KEY, newValue.code);
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
