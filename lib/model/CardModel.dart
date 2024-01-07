import 'package:equatable/equatable.dart';

abstract class CardModel extends Equatable {
  final String id;
  final String url;
  final DateTime publishedAt;
  final bool isBookmarkable;
  final bool isShareable;

  CardModel(this.id, this.url, this.publishedAt, this.isBookmarkable, this.isShareable);

  static bool Function(CardModel value) laterThan(int maxDays) {
    var laterThanTime = DateTime.now().subtract(Duration(days: maxDays));
    return (model) { return model.publishedAt.isAfter(laterThanTime); };
  }
}
