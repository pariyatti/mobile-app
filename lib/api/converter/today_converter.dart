import 'package:patta/api/model/today.dart';
import 'package:patta/ui/model/CardModel.dart';
import 'package:patta/ui/model/DohaCardModel.dart';
import 'package:patta/ui/model/OverlayInspirationCardModel.dart';
import 'package:patta/ui/model/PaliWordCardModel.dart';
import 'package:patta/ui/model/StackedInspirationCardModel.dart';
import 'package:patta/ui/model/WordsOfBuddhaCardModel.dart';
import 'package:patta/model/Translations.dart';

List<CardModel> convertJsonToCardModels(Iterable response, String baseUrl) {
  return response
      .map((apiCard) {
        final String cardType = apiCard['type'];
        ApiCard card = ApiCard.fromJson(apiCard);
        return _convertApiCardToCardModel(card, cardType, baseUrl);
      })
      .whereType<CardModel>() // was: .where((card) => (card != null))
      .toList();
}

CardModel? _convertApiCardToCardModel(
  ApiCard card,
  String cardType,
  String baseUrl,
) {
  switch (cardType) {
    case 'stacked_inspiration':
      {
        return StackedInspirationCardModel(
          id: card.id,
          url: card.url,
          publishedAt: card.publishedAt,
          header: card.header,
          text: card.text,
          imageUrl: '$baseUrl${card.image?.url}',
          isBookmarkable: card.isBookmarkable,
          isShareable: card.isShareable
        );
      }
    case 'overlay_inspiration':
      {
        return OverlayInspirationCardModel(
            id: card.id,
            url: card.url,
            publishedAt: card.publishedAt,
            header: card.header,
            text: card.text,
            imageUrl: '$baseUrl${card.image?.url}',
            textColor: card.textColor,
            isBookmarkable: card.isBookmarkable,
            isShareable: card.isShareable);
      }
    case 'pali_word':
      {
        PaliWordCardModel? model;
        if (card.translations!.isNotEmpty) {
          model = PaliWordCardModel(
            id: card.id,
            url: card.url,
            publishedAt: card.publishedAt,
            header: card.header,
            pali: card.pali,
            audioUrl: '$baseUrl${card.audio?.url}',
            translation: card.translations![0].translation,
            isBookmarkable: card.isBookmarkable,
            isShareable: card.isShareable
          );
        } else {
          model = null;
        }
        return model;
      }
    case 'words_of_buddha':
      {
        var translationMap = Map<String,String>.fromIterable(card.translations!, key: (e) => e.language, value: (e) => e.translation);
        return WordsOfBuddhaCardModel(
          id: card.id,
          url: card.url,
          publishedAt: card.publishedAt,
          header: card.header,
          words: card.words,
          translations: Translations(translationMap),
          audioUrl: card.audioUrl,
          imageUrl: '$baseUrl${card.image?.url}',
          isBookmarkable: card.isBookmarkable,
          isShareable: card.isShareable
        );
      }
    case 'doha':
      {
        var translationMap = Map<String,String>.fromIterable(card.translations!, key: (e) => e.language, value: (e) => e.translation);
        return DohaCardModel(
          id: card.id,
          url: card.url,
          publishedAt: card.publishedAt,
          header: card.header,
          doha: card.doha,
          translations: Translations(translationMap),
          audioUrl: card.audioUrl,
          imageUrl: '$baseUrl${card.image?.url}',
          isBookmarkable: card.isBookmarkable,
          isShareable: card.isShareable
        );
      }
    default:
      {
        return null;
      }
  }
}
