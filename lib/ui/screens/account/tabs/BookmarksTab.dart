import 'package:flutter/material.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/local_database/moor_converters.dart' as moor_converters;
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/common_widgets/cards/OverlayInspirationCard.dart';
import 'package:patta/ui/common_widgets/cards/PaliWordCard.dart';
import 'package:patta/ui/common_widgets/cards/StackedInspirationCard.dart';
import 'package:patta/ui/common_widgets/pariyatti_icons.dart';
import 'package:patta/ui/model/OverlayInspirationCardModel.dart';
import 'package:patta/ui/model/PaliWordCardModel.dart';
import 'package:patta/ui/model/StackedInspirationCardModel.dart';
import 'package:provider/provider.dart';

class BookmarksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<PariyattiDatabase>(context);

    return StreamBuilder(
      stream: database.allCards,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<DatabaseCard>> snapshot,
      ) {
        if (snapshot.hasData) {
          return _buildCardsList(snapshot.data, database);
        } else if (snapshot.hasError) {
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

  Widget _buildCardsList(List<DatabaseCard> data, PariyattiDatabase database) {
    final cardModels = data
        .map((dbCard) => moor_converters.toCardModel(dbCard))
        .where((card) => (card != null))
        .toList();
    if (cardModels.isEmpty) {
      return Center(
        child: Text(
          strings['en'].messageNothingBookmarked,
          style: TextStyle(
            inherit: true,
            color: Color(0xff6d695f),
            fontSize: 16.0,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: cardModels.length,
        itemBuilder: (context, index) {
          final card = cardModels[index];
          if (card is StackedInspirationCardModel) {
            return StackedInspirationCard(card, database);
          } else if (card is PaliWordCardModel) {
            return PaliWordCard(card, database);
          } else if (card is OverlayInspirationCardModel) {
            return OverlayInspirationCard(card, database);
          } else {
            return null;
          }
        },
      );
    }
  }
}
