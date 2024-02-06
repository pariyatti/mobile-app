import 'package:flutter_test/flutter_test.dart';
import 'package:patta/model/DateCardModel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('date cards return human-readable dates', () {
    expect('sunday 17 july, 2022', DateCardModel(id: "ignore", url: "ignore", publishedDate: DateTime(2022, 07, 17), publishedAt: DateTime(2022, 07, 17), isBookmarkable: false, isShareable: false).humanDate);
  });
}
