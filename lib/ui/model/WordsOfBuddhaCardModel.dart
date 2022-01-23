import 'package:patta/ui/model/CardModel.dart';
import 'package:patta/ui/model/Translations.dart';

class WordsOfBuddhaCardModel extends CardModel {
  final String? header;
  final String? words;
  final Translations? translations;
  final String? imageUrl;
  final String? audioUrl;

  WordsOfBuddhaCardModel({
    required String id,
    required bool isBookmarkable,
    this.header,
    this.words,
    this.translations,
    this.imageUrl,
    this.audioUrl
  }) : super(id, isBookmarkable);

  @override
  List<Object?> get props => [id, header, words, translations, imageUrl, audioUrl, isBookmarkable];
}
