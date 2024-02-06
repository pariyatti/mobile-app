import 'package:patta/model/CardModel.dart';
import 'package:patta/model/Translations.dart';

class PaliWordCardModel extends CardModel {
  final String? header;
  final String? pali;
  final String? translation; // legacy, from when only English was available
  final Translations? translations;
  final String? audioUrl;

  PaliWordCardModel({
    required String id,
    required String url,
    required DateTime publishedDate,
    required DateTime publishedAt,
    required bool isBookmarkable,
    required bool isShareable,
    this.header,
    this.pali,
    this.translation, // legacy
    this.translations,
    this.audioUrl,
  }) : super(id, url, publishedDate, publishedAt, isBookmarkable, isShareable);

  @override
  List<Object?> get props =>
      [id, url, publishedDate, publishedAt, header, pali, translation, translations, audioUrl, isBookmarkable, isShareable];
}
