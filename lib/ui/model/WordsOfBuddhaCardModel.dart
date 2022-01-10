import 'package:patta/ui/model/CardModel.dart';

class WordsOfBuddhaCardModel extends CardModel {
  final String? header;
  final String? words;
  final String? imageUrl;
  final String? audioUrl;

  WordsOfBuddhaCardModel({
    required String id,
    required bool isBookmarkable,
    this.header,
    this.words,
    this.imageUrl,
    this.audioUrl
  }) : super(id, isBookmarkable);

  @override
  List<Object?> get props => [id, header, words, imageUrl, audioUrl, isBookmarkable];
}
