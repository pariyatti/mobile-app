import 'package:flutter/material.dart';
import 'package:patta/api/api.dart' as api;
import 'package:patta/inspiration_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xffdcd3c0),
      ),
      home: MyHomePage(title: 'Pariyatti'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4efe7),
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: api
            .fetchToday()
            .map((cardData) => InspirationCard(data: cardData))
            .toList(),
      ),
    );
  }
}
