import 'dart:convert' as converter;

import 'package:patta/api/model/today.dart';
import 'package:patta/ui/model/CardModel.dart';
import 'package:patta/ui/model/PaliWordCardModel.dart';
import 'package:patta/ui/model/StackedInspirationCardModel.dart';

List<CardModel> convertJsonToCardModels(String responseBody, String baseUrl) {
  final Iterable iterable = converter.jsonDecode(responseBody);
  return iterable
      .map((apiCard) {
        final String cardType = apiCard['type'];
        ApiCard card = ApiCard.fromJson(apiCard);
        return _convertApiCardToCardModel(card, cardType, baseUrl);
      })
      .where((card) => (card != null))
      .toList();
}

CardModel _convertApiCardToCardModel(
  ApiCard card,
  String cardType,
  String baseUrl,
) {
  switch (cardType) {
    case 'stacked_inspiration':
      {
        return StackedInspirationCardModel(
          id: card.id,
          header: card.header,
          text: card.text,
          imageUrl: '$baseUrl${card.image.url}',
        );
      }
    case 'pali_word':
      {
        PaliWordCardModel model;
        if (card.translations.isNotEmpty) {
          model = PaliWordCardModel(
            id: card.id,
            header: card.header,
            pali: card.pali,
            audioUrl: '$baseUrl${card.audio.url}',
            translation: card.translations[0].translation,
          );
        } else {
          model = null;
        }
        return model;
      }
    default:
      {
        return null;
      }
  }
}
