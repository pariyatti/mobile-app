import 'package:flutter_test/flutter_test.dart';
import 'package:patta/model/DateCardModel.dart';
import 'package:patta/model/DohaCardModel.dart';
import 'package:patta/model/PaliWordCardModel.dart';
import 'package:patta/model/TodayFeed.dart';

void main() {
  test('insert date cards between different days', () {
    var thisWeek = DateTime(2022, 7, 10);
    var lastWeek = DateTime(2022, 7, 3);
    var pali = PaliWordCardModel(id: "b4285e6a-ea3c-4fc1-a7f4-4de3f1ed8ca4", url: "https://something", publishedAt: thisWeek, isBookmarkable: true, isShareable: true);
    var doha = DohaCardModel(id: "f9a2cc0f-915f-4a9a-a049-77bbb9be1fc7", url: "https://something", publishedAt: lastWeek, isBookmarkable: true, isShareable: true);
    var feed = TodayFeed.from([pali, doha]).tagDates();
    expect(feed.get(0) is DateCardModel, true);
    expect(feed.get(1) is PaliWordCardModel, true);
    expect(feed.get(2) is DateCardModel, true);
    expect(feed.get(3) is DohaCardModel, true);
  });

  test('does not insert date cards between same days', () {
    var lastWeek = DateTime(2022, 7, 10);
    var pali = PaliWordCardModel(id: "b4285e6a-ea3c-4fc1-a7f4-4de3f1ed8ca4", url: "https://something", publishedAt: lastWeek, isBookmarkable: true, isShareable: true);
    var doha = DohaCardModel(id: "f9a2cc0f-915f-4a9a-a049-77bbb9be1fc7", url: "https://something", publishedAt: lastWeek, isBookmarkable: true, isShareable: true);
    var feed = TodayFeed.from([pali, doha]).tagDates();
    expect(feed.get(0) is DateCardModel, true);
    expect(feed.get(1) is PaliWordCardModel, true);
    expect(feed.get(2) is DohaCardModel, true);
  });

  test('same day only cares about year/month/day', () {
    var same = DateTime(2022, 07, 10);
    var alsoSame = DateTime(2022, 07, 10);
    expect(same, alsoSame);
    expect(TodayFeed([]).sameDay(same, alsoSame), true);
  });

  test('date cards return human-readable dates', () {
    expect('sunday 17 july, 2022', DateCardModel(id: "ignore", url: "ignore", publishedAt: DateTime(2022, 07, 17), isBookmarkable: false, isShareable: false).humanDate);
  });
}
