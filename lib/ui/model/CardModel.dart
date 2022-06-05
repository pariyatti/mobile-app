import 'package:equatable/equatable.dart';

abstract class CardModel extends Equatable {
  final String id;
  final bool isBookmarkable;
  final bool isShareable;

  CardModel(this.id, this.isBookmarkable, this.isShareable);
}
