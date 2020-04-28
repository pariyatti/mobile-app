import 'package:flutter/material.dart';
import 'package:patta/Environment.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/screens/today/TodayScreen.dart';
import 'package:provider/provider.dart';

void mainCommon(Environment environment) => runApp(PariyattiApp(environment));

class PariyattiApp extends StatelessWidget {
  final Environment _environment;

  const PariyattiApp(this._environment, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<PariyattiDatabase>(
      create: (context) => PariyattiDatabase(),
      dispose: (context, database) {
        database.close();
      },
      child: MaterialApp(
        title: strings['en'].appName,
        theme: ThemeData(
          primaryColor: Color(0xffdcd3c0),
          accentColor: Color(0xff6d695f),
        ),
        home: TodayScreen(title: strings['en'].appName),
      ),
    );
  }
}
