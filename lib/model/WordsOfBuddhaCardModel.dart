import 'package:patta/model/CardModel.dart';
import 'package:patta/model/KosaAudio.dart';
import 'package:patta/model/Translations.dart';

class WordsOfBuddhaCardModel extends CardModel {
  final String? header;
  final String? words;
  final String? citepali;
  final String? citepali_url;
  final String? citebook;
  final String? citebook_url;
  final Translations? translations;
  final String? imageUrl;
  final String? audioUrl;
  final KosaAudio? kosaAudio;

  WordsOfBuddhaCardModel({
    required String id,
    required String url,
    required DateTime publishedDate,
    required DateTime publishedAt,
    required bool isBookmarkable,
    required bool isShareable,
    this.header,
    this.words,
    this.translations,
    this.citepali,
    this.citepali_url,
    this.citebook,
    this.citebook_url,
    this.imageUrl,
    this.audioUrl,
    this.kosaAudio
  }) : super(id, url, publishedDate, publishedAt, isBookmarkable, isShareable);

  @override
  List<Object?> get props => [id, url, publishedDate, publishedAt, header, words, citepali, citepali_url, citebook, citebook_url,
    translations, imageUrl, audioUrl, kosaAudio, isBookmarkable, isShareable];
}

