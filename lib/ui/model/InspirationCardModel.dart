import 'package:patta/ui/model/CardModel.dart';

class InspirationCardModel extends CardModel {
  final String text;
  final String imageUrl;

  InspirationCardModel({
    String id,
    this.text,
    this.imageUrl,
  }): super(id);
}
