import 'package:patta/local_database/database.dart';
import 'package:patta/ui/model/CardModel.dart';
import 'package:patta/ui/model/OverlayInspirationCardModel.dart';
import 'package:patta/ui/model/PaliWordCardModel.dart';
import 'package:patta/ui/model/StackedInspirationCardModel.dart';

DatabaseCard toDatabaseCard(
  CardModel cardModel,
  DateTime createdAt,
) {
  if (cardModel is StackedInspirationCardModel) {
    return DatabaseCard(
      id: cardModel.id,
      isBookmarkable: cardModel.isBookmarkable,
      type: 'stacked_inspiration',
      header: cardModel.header,
      textData: cardModel.text,
      imageUrl: cardModel.imageUrl,
      createdAt: createdAt,
    );
  } else if (cardModel is PaliWordCardModel) {
    return DatabaseCard(
      id: cardModel.id,
      isBookmarkable: cardModel.isBookmarkable,
      type: 'pali_word',
      header: cardModel.header,
      paliWord: cardModel.pali,
      audioUrl: cardModel.audioUrl,
      translation: cardModel.translation,
      createdAt: createdAt,
    );
  } else if (cardModel is OverlayInspirationCardModel) {
    return DatabaseCard(
      id: cardModel.id,
      isBookmarkable: cardModel.isBookmarkable,
      type: 'overlay_inspiration',
      header: cardModel.header,
      textData: cardModel.text,
      imageUrl: cardModel.imageUrl,
      textColor: cardModel.textColor,
      createdAt: createdAt,
    );
  } else {
    return null;
  }
}

CardModel toCardModel(DatabaseCard databaseCard) {
  CardModel card;
  switch (databaseCard.type) {
    case 'stacked_inspiration':
      {
        card = StackedInspirationCardModel(
          id: databaseCard.id,
          isBookmarkable: databaseCard.isBookmarkable,
          header: databaseCard.header,
          text: databaseCard.textData,
          imageUrl: databaseCard.imageUrl,
        );
        break;
      }
    case 'pali_word':
      {
        card = PaliWordCardModel(
          id: databaseCard.id,
          isBookmarkable: databaseCard.isBookmarkable,
          header: databaseCard.header,
          pali: databaseCard.paliWord,
          audioUrl: databaseCard.audioUrl,
          translation: databaseCard.translation,
        );
        break;
      }
    case 'overlay_inspiration':
      {
        card = OverlayInspirationCardModel(
          id: databaseCard.id,
          header: databaseCard.header,
          text: databaseCard.textData,
          isBookmarkable: databaseCard.isBookmarkable,
          imageUrl: databaseCard.imageUrl,
          textColor: databaseCard.textColor,
        );
        break;
      }
    default:
      {
        card = null;
        break;
      }
  }

  return card;
}
