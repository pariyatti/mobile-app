import 'package:patta/ui/model/CardModel.dart';

class PaliWordCardModel extends CardModel {
  final String? header;
  final String? pali;
  final String? audioUrl;
  final String? translation;

  PaliWordCardModel({
    required String id,
    required bool isBookmarkable,
    required bool isShareable,
    this.header,
    this.pali,
    this.audioUrl,
    this.translation,
  }) : super(id, isBookmarkable, isShareable);

  @override
  List<Object?> get props =>
      [id, header, pali, audioUrl, translation, isBookmarkable, isShareable];
}
