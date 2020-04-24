import 'package:flutter/material.dart';
import 'package:patta/api/api.dart' as api;
import 'package:patta/data_model/inspiration_card.dart';
import 'package:patta/inspiration_card.dart';
import 'package:patta/local_database/database.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<PariyattiDatabase>(
      create: (context) => PariyattiDatabase(),
      dispose: (context, database) {
        database.close();
      },
      child: MaterialApp(
        title: 'Pariyatti',
        theme: ThemeData(
          primaryColor: Color(0xffdcd3c0),
          accentColor: Color(0xff6d695f),
        ),
        home: MyHomePage(title: 'Pariyatti'),
      ),
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
      body: FutureBuilder<List<CardModel>>(
        future: api.fetchToday(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<CardModel>> snapshot,
        ) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data
                  .map((card) {
                    if (card is InspirationCardModel) {
                      return InspirationCard(
                        card,
                        Provider.of<PariyattiDatabase>(context),
                      );
                    } else {
                      return null;
                    }
                  })
                  .where((widget) => (widget != null))
                  .toList(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.error,
                      color: Color(0xff6d695f),
                    ),
                  ),
                  Text(
                    'Some error occured, can you please try again later!',
                    style: TextStyle(
                      inherit: true,
                      color: Color(0xff6d695f),
                      fontSize: 16.0,
                    ),
                  )
                ],
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
