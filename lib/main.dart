import 'package:flutter/material.dart';
import 'package:patta/data_model/inspiration_card.dart';
import 'package:patta/inspiration_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
      body: Column(
        children: <Widget>[
          InspirationCard(
            data: InspirationCardModel(
              text:
                  '\"We are shaped by our thoughts; we become what we think. When the mind is pure, joy follows like a shadow that never leaves.\"',
              imageUrl:
                  'https://images.fatherly.com/wp-content/uploads/2019/01/scooby.jpg?q=65&enable=upscale&w=600',
            ),
          ),
        ],
      ),
    );
  }
}
