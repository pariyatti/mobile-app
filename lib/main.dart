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
      home: MyHomePage(title: 'Pariyatti'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  final List<InspirationCardModel> cards = [
    InspirationCardModel(
      id: '393b47a8-b002-4ff5-95f6-dd6df497cf69',
      text: 'Blue skiiiieeeeesssssss smiling at meeeeeeeeee.',
      imageUrl:
          'http://139.59.41.132/uploads/card/image/393b47a8-b002-4ff5-95f6-dd6df497cf69/bluesky.jpeg',
    ),
    InspirationCardModel(
      id: '67f4000a-d6f8-4138-9365-d20758ff7a72',
      text:
          'Enjoy some beautiful red flowers on the ground did you know you can also turn them into jam but you have to dry them on your rootop first which maybe you don\'t have the time for and you\'d rather buy jam from a store.',
      imageUrl:
          'http://139.59.41.132/uploads/card/image/67f4000a-d6f8-4138-9365-d20758ff7a72/flowers.jpeg',
    ),
    InspirationCardModel(
      id: '8a1ceabb-1229-4e1f-bf19-7f3ae516e173',
      text:
          'This card has a Peepal leaf on it because if there\'s one thing we know about meditation it\'s that it involves a lot of Peepal leaves, right?',
      imageUrl:
          'http://139.59.41.132/uploads/card/image/8a1ceabb-1229-4e1f-bf19-7f3ae516e173/leaf.jpg',
    ),
  ];

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4efe7),
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children:
            cards.map((cardData) => InspirationCard(data: cardData)).toList(),
      ),
    );
  }
}
