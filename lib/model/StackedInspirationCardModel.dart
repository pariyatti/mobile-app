import 'package:patta/model/CardModel.dart';

class StackedInspirationCardModel extends CardModel {
  final String? header;
  final String? text;
  final String? imageUrl;

  StackedInspirationCardModel({
    required String id,
    required String url,
    required DateTime publishedAt,
    required bool isBookmarkable,
    required bool isShareable,
    this.header,
    this.text,
    this.imageUrl,
  }) : super(id, url, publishedAt, isBookmarkable, isShareable);

  @override
  List<Object?> get props => [id, url, publishedAt, header, text, imageUrl, isBookmarkable, isShareable];
}
