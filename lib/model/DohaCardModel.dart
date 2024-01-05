import 'package:patta/model/CardModel.dart';
import 'package:patta/model/KosaAudio.dart';
import 'package:patta/model/Translations.dart';

class DohaCardModel extends CardModel {
  final String? header;
  final String? doha;
  final Translations? translations;
  final String? imageUrl;
  final String? audioUrl;
  final KosaAudio? kosaAudio;

  DohaCardModel({
    required String id,
    required String url,
    required DateTime publishedAt,
    required bool isBookmarkable,
    required bool isShareable,
    this.header,
    this.doha,
    this.translations,
    this.imageUrl,
    this.audioUrl,
    this.kosaAudio
  }) : super(id, url, publishedAt, isBookmarkable, isShareable);

  @override
  List<Object?> get props => [id, url, publishedAt, header, doha, translations,
    imageUrl, audioUrl, kosaAudio, isBookmarkable, isShareable];
}
