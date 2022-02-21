import 'package:patta/ui/model/CardModel.dart';
import 'package:patta/model/Translations.dart';

class DohaCardModel extends CardModel {
  final String? header;
  final String? doha;
  final Translations? translations;
  final String? imageUrl;
  final String? audioUrl;

  DohaCardModel({
    required String id,
    required bool isBookmarkable,
    this.header,
    this.doha,
    this.translations,
    this.imageUrl,
    this.audioUrl
  }) : super(id, isBookmarkable);

  @override
  List<Object?> get props => [id, header, doha, translations, imageUrl, audioUrl, isBookmarkable];
}
