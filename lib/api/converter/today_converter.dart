import 'package:patta/api/model/today.dart';
import 'package:patta/ui/model/CardModel.dart';
import 'package:patta/ui/model/OverlayInspirationCardModel.dart';
import 'package:patta/ui/model/PaliWordCardModel.dart';
import 'package:patta/ui/model/StackedInspirationCardModel.dart';

List<CardModel> convertJsonToCardModels(Iterable response, String baseUrl) {
  return response
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
          isBookmarkable: card.isBookmarkable,
        );
      }
    case 'overlay_inspiration':
      {
        return OverlayInspirationCardModel(
            id: card.id,
            header: card.header,
            text: card.text,
            imageUrl: '$baseUrl${card.image.url}',
            textColor: card.textColor,
            isBookmarkable: card.isBookmarkable);
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
            isBookmarkable: card.isBookmarkable,
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
