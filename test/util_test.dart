import 'package:flutter_test/flutter_test.dart';
import 'package:patta/util.dart';


void main() {
  test('does not permit null urls to become extensions', () {
    expect(extractFileExtension("http://solasa.local:3000null"), "jpg");
  });

  test('removes spaces from filenames', () {
    expect(toFilename("Daily Doha"), "Daily_Doha");
  });
}
