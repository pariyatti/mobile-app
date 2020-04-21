import 'package:flutter/material.dart';
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
            text:
                '\"We are shaped by our thoughts; we become what we think. When the mind is pure, joy follows like a shadow that never leaves.\"',
//                    imageUrl: 'http://139.59.41.132/uploads/card/image/393b47a8-b002-4ff5-95f6-dd6df497cf69/bluesky.jpeg',
//            imageUrl: 'https://images.unsplash.com/photo-1587321819113-cc19ebc6e5e3',
//                    imageUrl: 'https://i.picsum.photos/id/9/250/250.jpg',
            imageUrl:
                'https://images.fatherly.com/wp-content/uploads/2019/01/scooby.jpg?q=65&enable=upscale&w=600',
          ),
        ],
      ),
    );
  }
}
