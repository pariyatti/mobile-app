import 'package:patta/data_model/inspiration_card.dart';
import 'package:patta/local_database/database.dart';

DatabaseCard toDatabaseCard(
  CardModel cardModel,
  DateTime createdAt,
) {
  if (cardModel is InspirationCardModel) {
    return DatabaseCard(
      id: cardModel.id,
      type: 'stacked_inspiration',
      textData: cardModel.text,
      imageUrl: cardModel.imageUrl,
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
        card = InspirationCardModel(
          id: databaseCard.id,
          text: databaseCard.textData,
          imageUrl: databaseCard.imageUrl,
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
