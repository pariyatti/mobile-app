import 'package:patta/ui/model/CardModel.dart';

class StackedInspirationCardModel extends CardModel {
  final String text;
  final String imageUrl;

  StackedInspirationCardModel({
    String id,
    this.text,
    this.imageUrl,
  }): super(id);

  @override
  List<Object> get props => [id, text, imageUrl];
}
