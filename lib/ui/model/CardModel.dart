import 'package:equatable/equatable.dart';

abstract class CardModel extends Equatable {
  final String id;
  final String url;
  final bool isBookmarkable;
  final bool isShareable;

  CardModel(this.id, this.url, this.isBookmarkable, this.isShareable);
}
