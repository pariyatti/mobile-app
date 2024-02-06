import 'package:flutter_test/flutter_test.dart';
import 'package:patta/model/DateCardModel.dart';
import 'package:patta/model/DohaCardModel.dart';
import 'package:patta/model/PaliWordCardModel.dart';
import 'package:patta/model/TodayFeed.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('does not insert date cards between same days', () {
    var lastWeek = DateTime(2022, 7, 10);
    var pali = PaliWordCardModel(id: "b4285e6a-ea3c-4fc1-a7f4-4de3f1ed8ca4", url: "https://something", publishedDate: lastWeek, publishedAt: lastWeek, isBookmarkable: true, isShareable: true);
    var doha = DohaCardModel(id: "f9a2cc0f-915f-4a9a-a049-77bbb9be1fc7", url: "https://something", publishedDate: lastWeek, publishedAt: lastWeek, isBookmarkable: true, isShareable: true);
    var feed = TodayFeed.from([pali, doha]).tagDates();
    expect(feed.get(0) is DateCardModel, true);
    expect(feed.get(1) is PaliWordCardModel, true);
    expect(feed.get(2) is DohaCardModel, true);
  });

}
