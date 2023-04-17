import 'package:flutter_test/flutter_test.dart';
import 'package:patta/model/Language.dart';
import 'package:patta/app/I18n.dart';


void main() {
  test('sanity: all languages the user can select return something meaningful (non-English) for "Today"', () {
    for (var l in Language.all) {
      if (l != Language.eng) {
        expect(I18n.getForced(l, "today"), isNot(equals("Today")));
      }
    }
  });
}
