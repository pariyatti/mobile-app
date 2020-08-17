import 'package:flutter/material.dart';
import 'package:patta/api/api.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/common_widgets/cards/OverlayInspirationCard.dart';
import 'package:patta/ui/common_widgets/cards/PaliWordCard.dart';
import 'package:patta/ui/common_widgets/cards/StackedInspirationCard.dart';
import 'package:patta/ui/common_widgets/pariyatti_icons.dart';
import 'package:patta/ui/model/CardModel.dart';
import 'package:patta/ui/model/OverlayInspirationCardModel.dart';
import 'package:patta/ui/model/PaliWordCardModel.dart';
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
          return _buildCardsList(snapshot.data, context);
        } else if (snapshot.hasError) {
          //  TODO: Log the error
          return _buildError();
        } else {
          return _buildLoadingIndicator();
        }
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildCardsList(List<CardModel> data, BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final card = data[index];
        if (card is StackedInspirationCardModel) {
          return StackedInspirationCard(
            card,
            Provider.of<PariyattiDatabase>(context),
          );
        } else if (card is OverlayInspirationCardModel) {
          return OverlayInspirationCard(
            card,
            Provider.of<PariyattiDatabase>(context),
          );
        } else if (card is PaliWordCardModel) {
          return PaliWordCard(
            card,
            Provider.of<PariyattiDatabase>(context),
          );
        } else {
          return null;
        }
      },
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              PariyattiIcons.get(IconName.error),
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
  }
}
