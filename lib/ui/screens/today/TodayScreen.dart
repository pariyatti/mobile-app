import 'package:flutter/material.dart';
import 'package:patta/api/api.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/common_widgets/cards/PaliWordOfTheDayCard.dart';
import 'package:patta/ui/common_widgets/cards/StackedInspirationCard.dart';
import 'package:patta/ui/model/CardModel.dart';
import 'package:patta/ui/model/PaliWordOfTheDayCardModel.dart';
import 'package:patta/ui/model/StackedInspirationCardModel.dart';
import 'package:provider/provider.dart';

class TodayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CardModel>>(
      future: Provider.of<PariyattiApi>(context).fetchToday(),
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
                  } else if (card is PaliWordOfTheDayCardModel) {
                    return PaliWordOfTheDayCard(
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
    );
  }
}
