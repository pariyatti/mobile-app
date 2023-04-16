import 'package:flutter/material.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/local_database/drift_converters.dart' as drift_converters;
import 'package:patta/app/I18n.dart';
import 'package:patta/ui/common/pariyatti_icons.dart';
import 'package:patta/model/DohaCardModel.dart';
import 'package:patta/model/OverlayInspirationCardModel.dart';
import 'package:patta/model/PaliWordCardModel.dart';
import 'package:patta/model/StackedInspirationCardModel.dart';
import 'package:patta/model/WordsOfBuddhaCardModel.dart';
import 'package:patta/ui/widgets/cards/DohaCard.dart';
import 'package:patta/ui/widgets/cards/EmptyCard.dart';
import 'package:patta/ui/widgets/cards/OverlayInspirationCard.dart';
import 'package:patta/ui/widgets/cards/PaliWordCard.dart';
import 'package:patta/ui/widgets/cards/StackedInspirationCard.dart';
import 'package:patta/ui/widgets/cards/WordsOfBuddhaCard.dart';
import 'package:provider/provider.dart';

class BookmarksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<PariyattiDatabase>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(I18n.get().bookmarks),
          backgroundColor: Theme.of(context).colorScheme.secondary
      ),
      body: StreamBuilder(
        stream: database.allCards,
        builder: (
            BuildContext context,
            AsyncSnapshot<List<DatabaseCard>> snapshot,
            ) {
          if (snapshot.hasData && snapshot.data != null) {
            return _buildCardsList(context, snapshot.data!, database);
          } else if (snapshot.hasError) {
            return _buildError(context);
          } else {
            return _buildLoadingIndicator();
          }
        },
      )
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              PariyattiIcons.get(IconName.error),
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          Text(
            I18n.get().tryAgainLater,
            style: TextStyle(
              inherit: true,
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCardsList(BuildContext context, List<DatabaseCard> data, PariyattiDatabase database) {
    final cardModels = data
        .map((dbCard) => drift_converters.toCardModel(dbCard))
        .where((card) => (card != null))
        .toList();
    if (cardModels.isEmpty) {
      return Center(
        child: Text(
          I18n.get().nothingBookmarked,
          style: TextStyle(
            inherit: true,
            color: Theme.of(context).colorScheme.onBackground,
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
          } else if (card is WordsOfBuddhaCardModel) {
            return WordsOfBuddhaCard(card, database);
          } else if (card is DohaCardModel) {
            return DohaCard(card, database);
          }
          else {
            return EmptyCard(card!, database);
          }
        },
      );
    }
  }
}
