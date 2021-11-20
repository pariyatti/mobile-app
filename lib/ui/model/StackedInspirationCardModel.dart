import 'package:patta/ui/model/CardModel.dart';

class StackedInspirationCardModel extends CardModel {
  final String? header;
  final String? text;
  final String? imageUrl;

  StackedInspirationCardModel({
    required String id,
    required bool isBookmarkable,
    this.header,
    this.text,
    this.imageUrl,
  }) : super(id, isBookmarkable);

  @override
  List<Object?> get props => [id, header, text, imageUrl, isBookmarkable];
}
