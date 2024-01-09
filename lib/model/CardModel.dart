import 'package:equatable/equatable.dart';

abstract class CardModel extends Equatable {
  final String id;
  final String url;
  final DateTime publishedDate;
  final DateTime publishedAt;
  final bool isBookmarkable;
  final bool isShareable;

  CardModel(this.id, this.url, this.publishedDate, this.publishedAt, this.isBookmarkable, this.isShareable);

  static bool Function(CardModel cm) inFuture() {
    DateTime now = DateTime.now();
    return (model) { return model.publishedDate.isAfter(DateTime(now.year, now.month, now.day)); };
  }

  static bool Function(CardModel cm) laterThan(int maxDays) {
    var laterThanTime = DateTime.now().subtract(Duration(days: maxDays));
    return (model) { return model.publishedAt.isAfter(laterThanTime); };
  }
}
