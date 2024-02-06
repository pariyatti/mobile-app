import 'package:patta/model/CardModel.dart';

class StackedInspirationCardModel extends CardModel {
  final String? header;
  final String? text;
  final String? imageUrl;

  StackedInspirationCardModel({
    required String id,
    required String url,
    required DateTime publishedDate,
    required DateTime publishedAt,
    required bool isBookmarkable,
    required bool isShareable,
    this.header,
    this.text,
    this.imageUrl,
  }) : super(id, url, publishedDate, publishedAt, isBookmarkable, isShareable);

  @override
  List<Object?> get props => [id, url, publishedDate, publishedAt, header, text, imageUrl, isBookmarkable, isShareable];
}
