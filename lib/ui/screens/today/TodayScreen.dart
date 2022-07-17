import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:patta/api/api.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/common_widgets/cards/DateCard.dart';
import 'package:patta/ui/common_widgets/cards/DohaCard.dart';
import 'package:patta/ui/common_widgets/cards/EmptyCard.dart';
import 'package:patta/ui/common_widgets/cards/OverlayInspirationCard.dart';
import 'package:patta/ui/common_widgets/cards/PaliWordCard.dart';
import 'package:patta/ui/common_widgets/cards/StackedInspirationCard.dart';
import 'package:patta/ui/common_widgets/cards/WordsOfBuddhaCard.dart';
import 'package:patta/ui/common_widgets/pariyatti_icons.dart';
import 'package:patta/ui/model/CardModel.dart';
import 'package:patta/ui/model/DateCardModel.dart';
import 'package:patta/ui/model/DohaCardModel.dart';
import 'package:patta/ui/model/OverlayInspirationCardModel.dart';
import 'package:patta/ui/model/PaliWordCardModel.dart';
import 'package:patta/ui/model/StackedInspirationCardModel.dart';
import 'package:patta/ui/model/WordsOfBuddhaCardModel.dart';
import 'package:provider/provider.dart';
import '../../model/NetworkErrorCardModel.dart';
import '../../model/TodayFeed.dart';

class TodayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CardModel>>(
      future: Provider.of<PariyattiApi>(context).fetchToday(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<CardModel>> snapshot,
      ) {
        if (snapshot.hasData && snapshot.data != null) {
          var firstCard = snapshot.data![0];
          if (firstCard is NetworkErrorCardModel) {
            return _buildError(new Exception(firstCard.errorMsg));
          }
          var feed = TodayFeed.from(snapshot.data!).filter().tagDates();
          return _buildCardsList(feed, context);
        } else if (snapshot.hasError) {
          //  TODO: Log the error
          log("Data from snapshot: ${snapshot.data.toString()}");
          return _buildError(snapshot.error!);
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

  Widget _buildCardsList(TodayFeed feed, BuildContext context) {
    return ListView.builder(
      itemCount: feed.length,
      itemBuilder: (context, index) {
        final card = feed.get(index);
        if (card is DateCardModel) {
          return DateCard(
            card,
            Provider.of<PariyattiDatabase>(context),
          );
        } else if (card is StackedInspirationCardModel) {
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
        } else if (card is WordsOfBuddhaCardModel) {
          return WordsOfBuddhaCard(
            card,
            Provider.of<PariyattiDatabase>(context),
          );
        } else if (card is DohaCardModel) {
          return DohaCard(
            card,
            Provider.of<PariyattiDatabase>(context),
          );
        }
        else {
          return EmptyCard(card, Provider.of<PariyattiDatabase>(context));
        }
      },
    );
  }

  Widget _buildError(Object error) {
    var errorMessage = AppStrings.get().errorMessageTryAgainLater
        + "\n\nError:\n"
        + error.toString()
        + "\n\nException Details:\n"
        + exceptionToString(error);
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
            errorMessage,
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

  String exceptionToString(Object error) {
    var exception = (error as Exception);
    if (exception.runtimeType is MissingRequiredKeysException)
    {
      var mrke = (exception as MissingRequiredKeysException);
      var s = mrke.missingKeys.toString() + " from "
      + mrke.message;
      return s;
    } else {
      return exception.toString();
    }
  }
}
