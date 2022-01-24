import 'package:flutter/material.dart';
import 'package:patta/model/Language.dart';

class SettingsTab extends StatefulWidget {
  SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  // TODO: select language from configuration
  Language selectedLanguage = Language.eng;

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
            onChanged: (Language? newValue) {
              setState(() {
                selectedLanguage = newValue!;
              });
            })
        ]
      ),
    );
  }
}
