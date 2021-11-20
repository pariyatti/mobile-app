import 'package:patta/ui/model/CardModel.dart';

class OverlayInspirationCardModel extends CardModel {
  final String? header;
  final String? text;
  final String? imageUrl;
  final String? textColor;

  OverlayInspirationCardModel({
    required String id,
    required bool isBookmarkable,
    this.textColor,
    this.header,
    this.text,
    this.imageUrl,
  }) : super(id, isBookmarkable);

  @override
  List<Object?> get props =>
      [id, header, text, imageUrl, textColor, isBookmarkable];
}
