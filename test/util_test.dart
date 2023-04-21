import 'package:flutter_test/flutter_test.dart';
import 'package:patta/util.dart';


void main() {
  test('does not permit null urls to become extensions', () {
    expect(extractFileExtension("http://solasa.local:3000null"), "jpg");
  });

  test('removes spaces from filenames', () {
    expect(toFilename("Daily Doha"), "Daily_Doha");
  });
  
  test('removes periods from filenames', () {
    expect(toFilename("Daily Dhamma Verse from S.N. Goenka"), "Daily_Dhamma_Verse_from_SN_Goenka");
  });

  test('removes diacritics', () {
    expect(toFilename("Pāli Word of the Day"), "Pali_Word_of_the_Day");
  });
}
