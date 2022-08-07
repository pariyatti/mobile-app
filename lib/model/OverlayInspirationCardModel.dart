import 'package:patta/model/CardModel.dart';

class OverlayInspirationCardModel extends CardModel {
  final String? header;
  final String? text;
  final String? imageUrl;
  final String? textColor;

  OverlayInspirationCardModel({
    required String id,
    required String url,
    required DateTime publishedAt,
    required bool isBookmarkable,
    required bool isShareable,
    this.textColor,
    this.header,
    this.text,
    this.imageUrl
  }) : super(id, url, publishedAt, isBookmarkable, isShareable);

  @override
  List<Object?> get props =>
      [id, url, publishedAt, header, text, imageUrl, textColor, isBookmarkable, isShareable];
}
