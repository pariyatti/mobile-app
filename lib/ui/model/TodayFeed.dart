import 'package:patta/ui/model/CardModel.dart';

import '../../app/preferences.dart';
import '../../model/Feed.dart';
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

  isCardVisible(CardModel card) {
    // prepare for a horror show of poorly-managed types...
    return (card is PaliWordCardModel && isFeedEnabled(Feed.pali)) ||
        (card is WordsOfBuddhaCardModel && isFeedEnabled(Feed.buddha)) ||
        (card is DohaCardModel && isFeedEnabled(Feed.dohas)) ||
        (card is StackedInspirationCardModel && isFeedEnabled(Feed.inspiration)) ||
        (card is OverlayInspirationCardModel && isFeedEnabled(Feed.inspiration));
  }

  isFeedEnabled(feed) => Preferences.getBool(feed.key) ?? true;
}
