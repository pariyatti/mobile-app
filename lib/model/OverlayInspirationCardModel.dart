import 'package:patta/model/CardModel.dart';

class OverlayInspirationCardModel extends CardModel {
  final String? header;
  final String? text;
  final String? imageUrl;
  final String? textColor;

  OverlayInspirationCardModel({
    required String id,
    required String url,
    required DateTime publishedDate,
    required DateTime publishedAt,
    required bool isBookmarkable,
    required bool isShareable,
    this.textColor,
    this.header,
    this.text,
    this.imageUrl
  }) : super(id, url, publishedDate, publishedAt, isBookmarkable, isShareable);

  @override
  List<Object?> get props =>
      [id, url, publishedDate, publishedAt, header, text, imageUrl, textColor, isBookmarkable, isShareable];
}
