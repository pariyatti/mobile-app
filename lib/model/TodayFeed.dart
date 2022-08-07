import 'package:patta/model/CardModel.dart';
import 'package:patta/model/DateCardModel.dart';

import 'package:patta/app/preferences.dart';
import 'Feed.dart';
import 'DohaCardModel.dart';
import 'OverlayInspirationCardModel.dart';
import 'PaliWordCardModel.dart';
import 'StackedInspirationCardModel.dart';
import 'WordsOfBuddhaCardModel.dart';

class TodayFeed {
  late List<CardModel> _list;
  TodayFeed(List<CardModel> list) {
    _list = list;
  }

  get length => _list.length;

  static TodayFeed from(List<CardModel> list) {
    return TodayFeed(list);
  }

  get(int index) {
    return _list[index];
  }

  TodayFeed filter() {
    List<CardModel> filtering = List.from(_list);
    filtering.retainWhere((card) => isCardVisible(card));
    return TodayFeed.from(filtering);
  }

  TodayFeed tagDates() {
    DateTime today = DateTime.now();
    var current = DateTime(today.year, today.month, today.day); // force to day only
    List<CardModel> tagging = [];
    _list.forEach((CardModel card) {
      if (!sameDay(current, card.publishedAt)) {
        var nextDay = DateTime(card.publishedAt.year, card.publishedAt.month, card.publishedAt.day);
        current = nextDay;
        tagging.add(DateCardModel(id: nextDay.toIso8601String(), url: "NONE", publishedAt: nextDay, isBookmarkable: false, isShareable: false));
      }
      tagging.add(card);
    });
    return TodayFeed.from(tagging);
  }

  isCardVisible(CardModel card) {
    // prepare for a horror show of poorly-managed types...
    return (card is PaliWordCardModel && isFeedEnabled(Feed.pali)) ||
        (card is WordsOfBuddhaCardModel && isFeedEnabled(Feed.buddha)) ||
        (card is DohaCardModel && isFeedEnabled(Feed.dohas)) ||
        (card is StackedInspirationCardModel && isFeedEnabled(Feed.inspiration)) ||
        (card is OverlayInspirationCardModel && isFeedEnabled(Feed.inspiration));
  }

  isFeedEnabled(feed) => Preferences.getBool(feed.key) ?? true;

  bool sameDay(DateTime current, DateTime publishedAt) {
    if (!publishedAt.isBefore(current)) {
      return true; // a small lie, since we don't care about dates in the future
    }
    DateTime publishDay = DateTime(publishedAt.year, publishedAt.month, publishedAt.day);
    return current == publishDay;
  }
}
