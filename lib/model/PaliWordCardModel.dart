import 'package:patta/model/CardModel.dart';

class PaliWordCardModel extends CardModel {
  final String? header;
  final String? pali;
  final String? audioUrl;
  final String? translation;

  PaliWordCardModel({
    required String id,
    required String url,
    required DateTime publishedAt,
    required bool isBookmarkable,
    required bool isShareable,
    this.header,
    this.pali,
    this.audioUrl,
    this.translation,
  }) : super(id, url, publishedAt, isBookmarkable, isShareable);

  @override
  List<Object?> get props =>
      [id, url, publishedAt, header, pali, audioUrl, translation, isBookmarkable, isShareable];
}
