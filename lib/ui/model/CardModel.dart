import 'package:equatable/equatable.dart';

abstract class CardModel extends Equatable {
  final String id;
  final bool isBookmarkable;

  CardModel(this.id, this.isBookmarkable);
}
