import 'package:flutter/material.dart';
import 'package:patta/api/api.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/model/CardModel.dart';
import 'package:patta/ui/model/StackedInspirationCardModel.dart';
import 'package:patta/ui/screens/today/cards/StackedInspirationCard.dart';
import 'package:provider/provider.dart';

class TodayScreen extends StatelessWidget {
  final String title;

  TodayScreen({Key key, this.title}) : super(key: key);

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
        future: PariyattiApi().fetchToday(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<CardModel>> snapshot,
        ) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data
                  .map((card) {
                    if (card is StackedInspirationCardModel) {
                      return StackedInspirationCard(
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
                    strings['en'].errorMessageTryAgainLater,
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
