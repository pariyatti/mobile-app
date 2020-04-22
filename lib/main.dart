import 'package:flutter/material.dart';
import 'package:patta/api/api.dart' as api;
import 'package:patta/data_model/inspiration_card.dart';
import 'package:patta/inspiration_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xffdcd3c0),
        accentColor: Color(0xff6d695f),
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
        title: Text(
          title,
          style: TextStyle(
            inherit: true,
            color: Color(0xff6d695f),
          ),
        ),
      ),
      body: FutureBuilder<List<InspirationCardModel>>(
        future: api.fetchToday(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<InspirationCardModel>> snapshot,
        ) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data
                  .map((card) => InspirationCard(data: card))
                  .toList(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Icon(
                Icons.error,
                color: Color(0xff6d695f),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
