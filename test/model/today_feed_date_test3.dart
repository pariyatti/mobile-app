import 'package:flutter_test/flutter_test.dart';
import 'package:patta/model/TodayFeed.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('same day only cares about year/month/day', () {
    var same = DateTime(2022, 07, 10);
    var alsoSame = DateTime(2022, 07, 10);
    expect(same, alsoSame);
    expect(TodayFeed([]).sameDay(same, alsoSame), true);
  });

}
