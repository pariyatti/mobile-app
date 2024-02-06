import 'dart:convert';

import 'package:patta/local_database/database.dart';
import 'package:patta/model/CardModel.dart';
import 'package:patta/model/DohaCardModel.dart';
import 'package:patta/model/OverlayInspirationCardModel.dart';
import 'package:patta/model/PaliWordCardModel.dart';
import 'package:patta/model/StackedInspirationCardModel.dart';
import 'package:patta/model/Translations.dart';
import 'package:patta/model/WordsOfBuddhaCardModel.dart';

DatabaseCard toDatabaseCard(
  CardModel? cardModel,
  DateTime createdAt,
) {
  if (cardModel is StackedInspirationCardModel) {
    return DatabaseCard(
      id: cardModel.id,
      url: cardModel.url,
      publishedDate: cardModel.publishedDate,
      publishedAt: cardModel.publishedAt,
      isBookmarkable: cardModel.isBookmarkable,
      isShareable: cardModel.isShareable,
      type: 'stacked_inspiration',
      header: cardModel.header,
      textData: cardModel.text,
      imageUrl: cardModel.imageUrl,
      createdAt: createdAt,
    );
  } else if (cardModel is PaliWordCardModel) {
    return DatabaseCard(
      id: cardModel.id,
      url: cardModel.url,
      publishedDate: cardModel.publishedDate,
      publishedAt: cardModel.publishedAt,
      isBookmarkable: cardModel.isBookmarkable,
      isShareable: cardModel.isShareable,
      type: 'pali_word',
      header: cardModel.header,
      paliWord: cardModel.pali,
      audioUrl: cardModel.audioUrl,
      translation: cardModel.translation,
      translations: jsonEncode(cardModel.translations),
      createdAt: createdAt,
    );
  } else if (cardModel is OverlayInspirationCardModel) {
    return DatabaseCard(
      id: cardModel.id,
      url: cardModel.url,
      publishedDate: cardModel.publishedDate,
      publishedAt: cardModel.publishedAt,
      isBookmarkable: cardModel.isBookmarkable,
      isShareable: cardModel.isShareable,
      type: 'overlay_inspiration',
      header: cardModel.header,
      textData: cardModel.text,
      imageUrl: cardModel.imageUrl,
      textColor: cardModel.textColor,
      createdAt: createdAt,
    );
  } else if (cardModel is WordsOfBuddhaCardModel) {
    return DatabaseCard(
      id: cardModel.id,
      url: cardModel.url,
      publishedDate: cardModel.publishedDate,
      publishedAt: cardModel.publishedAt,
      isBookmarkable: cardModel.isBookmarkable,
      isShareable: cardModel.isShareable,
      type: 'words_of_buddha',
      header: cardModel.header,
      imageUrl: cardModel.imageUrl,
      audioUrl: cardModel.audioUrl,
      words: cardModel.words,
      translations: jsonEncode(cardModel.translations),
      createdAt: createdAt,
    );
  } else if (cardModel is DohaCardModel) {
    return DatabaseCard(
      id: cardModel.id,
      url: cardModel.url,
      publishedDate: cardModel.publishedDate,
      publishedAt: cardModel.publishedAt,
      isBookmarkable: cardModel.isBookmarkable,
      isShareable: cardModel.isShareable,
      type: 'doha',
      header: cardModel.header,
      imageUrl: cardModel.imageUrl,
      audioUrl: cardModel.audioUrl,
      doha: cardModel.doha,
      translations: jsonEncode(cardModel.translations),
      createdAt: createdAt,
    );
  } else {
    // TODO: Create an `EmptyDatabaseCard` sentinel value
    return DatabaseCard(
      id: "NULL",
      url: "NULL",
      publishedDate: DateTime.now(),
      publishedAt: DateTime.now(),
      isBookmarkable: false,
      isShareable: false,
      type: "null",
      header: "null",
      textData: "null",
      imageUrl: "null",
      textColor: "#0000000000",
      createdAt: DateTime.now(),
    );
  }
}

CardModel? toCardModel(DatabaseCard databaseCard) {
  switch (databaseCard.type) {
    case 'stacked_inspiration':
      {
        return StackedInspirationCardModel(
          id: databaseCard.id,
          url: databaseCard.url,
          publishedDate: databaseCard.publishedDate,
          publishedAt: databaseCard.publishedAt,
          isBookmarkable: databaseCard.isBookmarkable,
          isShareable: databaseCard.isShareable,
          header: databaseCard.header,
          text: databaseCard.textData,
          imageUrl: databaseCard.imageUrl,
        );
      }
    case 'overlay_inspiration':
      {
        return OverlayInspirationCardModel(
          id: databaseCard.id,
          url: databaseCard.url,
          publishedDate: databaseCard.publishedDate,
          publishedAt: databaseCard.publishedAt,
          header: databaseCard.header,
          text: databaseCard.textData,
          isBookmarkable: databaseCard.isBookmarkable,
          isShareable: databaseCard.isShareable,
          imageUrl: databaseCard.imageUrl,
          textColor: databaseCard.textColor,
        );
      }
    case 'pali_word':
      {
        return PaliWordCardModel(
          id: databaseCard.id,
          url: databaseCard.url,
          publishedDate: databaseCard.publishedDate,
          publishedAt: databaseCard.publishedAt,
          isBookmarkable: databaseCard.isBookmarkable,
          isShareable: databaseCard.isShareable,
          header: databaseCard.header,
          pali: databaseCard.paliWord,
          audioUrl: databaseCard.audioUrl,
          translation: databaseCard.translation,
          translations: Translations.fromJson(jsonDecode(databaseCard.translations!))
        );
      }
    case 'words_of_buddha':
      {
        return WordsOfBuddhaCardModel(
          id: databaseCard.id,
          url: databaseCard.url,
          publishedDate: databaseCard.publishedDate,
          publishedAt: databaseCard.publishedAt,
          header: databaseCard.header,
          isBookmarkable: databaseCard.isBookmarkable,
          isShareable: databaseCard.isShareable,
          imageUrl: databaseCard.imageUrl,
          audioUrl: databaseCard.audioUrl,
          words: databaseCard.words,
          translations: Translations.fromJson(jsonDecode(databaseCard.translations!))
        );
      }
    case 'doha':
      {
        return DohaCardModel(
          id: databaseCard.id,
          url: databaseCard.url,
          publishedDate: databaseCard.publishedDate,
          publishedAt: databaseCard.publishedAt,
          header: databaseCard.header,
          isBookmarkable: databaseCard.isBookmarkable,
          isShareable: databaseCard.isShareable,
          imageUrl: databaseCard.imageUrl,
          audioUrl: databaseCard.audioUrl,
          doha: databaseCard.doha,
          translations: Translations.fromJson(jsonDecode(databaseCard.translations!))
        );
      }
    default:
      {
        return null;
      }
  }
}
