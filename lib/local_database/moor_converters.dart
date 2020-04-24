import 'package:patta/data_model/inspiration_card.dart';
import 'package:patta/local_database/database.dart';

DatabaseCard toDatabaseCard(
    InspirationCardModel cardModel, DateTime createdAt) {
  return DatabaseCard(
    id: cardModel.id,
    type: 'inspiration',
    textData: cardModel.text,
    imageUrl: cardModel.imageUrl,
    createdAt: createdAt,
  );
}

CardModel toCardModel(DatabaseCard databaseCard) {
  CardModel card;
  switch (databaseCard.type) {
    case 'inspiration':
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
