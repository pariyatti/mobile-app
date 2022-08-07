import 'package:patta/model/CardModel.dart';
import 'package:patta/model/Translations.dart';

class WordsOfBuddhaCardModel extends CardModel {
  final String? header;
  final String? words;
  final String? citepali;
  final Translations? translations;
  final String? imageUrl;
  final String? audioUrl;

  WordsOfBuddhaCardModel({
    required String id,
    required String url,
    required DateTime publishedAt,
    required bool isBookmarkable,
    required bool isShareable,
    this.header,
    this.words,
    this.citepali,
    this.translations,
    this.imageUrl,
    this.audioUrl
  }) : super(id, url, publishedAt, isBookmarkable, isShareable);

  @override
  List<Object?> get props => [id, url, publishedAt, header, words, citepali, translations, imageUrl, audioUrl, isBookmarkable, isShareable];
}
