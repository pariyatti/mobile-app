import 'package:patta/ui/model/CardModel.dart';

class OverlayInspirationCardModel extends CardModel {
  final String header;
  final String text;
  final String imageUrl;
  final String textColor;

  OverlayInspirationCardModel(
      {String id, this.textColor, this.header, this.text, this.imageUrl})
      : super(id);

  @override
  List<Object> get props => [id, header, text, imageUrl, textColor];
}
