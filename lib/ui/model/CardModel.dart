import 'package:equatable/equatable.dart';

abstract class CardModel extends Equatable {
  final String id;

  CardModel(this.id);
}
