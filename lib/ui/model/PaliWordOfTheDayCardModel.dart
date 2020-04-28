import 'package:patta/ui/model/CardModel.dart';

class PaliWordOfTheDayCardModel extends CardModel {
  final String header;
  final String pali;
  final String audioUrl;
  final String translation;

  PaliWordOfTheDayCardModel({
    String id,
    this.header,
    this.pali,
    this.audioUrl,
    this.translation,
  }) : super(id);

  @override
  List<Object> get props => [id, header, pali, audioUrl, translation];
}
