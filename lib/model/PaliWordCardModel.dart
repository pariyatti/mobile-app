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
    required DateTime publishedAt,
    required bool isBookmarkable,
    required bool isShareable,
    this.header,
    this.pali,
    this.translation, // legacy
    this.translations,
    this.audioUrl,
  }) : super(id, url, publishedAt, isBookmarkable, isShareable);

  @override
  List<Object?> get props =>
      [id, url, publishedAt, header, pali, translation, translations, audioUrl, isBookmarkable, isShareable];
}
