abstract class CardModel {
  final String id;

  CardModel(this.id);
}

class InspirationCardModel extends CardModel {
  final String text;
  final String imageUrl;

  InspirationCardModel({
    String id,
    this.text,
    this.imageUrl,
  }): super(id);
}
