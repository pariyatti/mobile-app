import 'package:flutter_test/flutter_test.dart';
import 'package:patta/model/Language.dart';
import 'package:patta/model/translations.dart';


void main() {
  test('uses English as a fallback language if the desired translation does not exist', () {
    var t = new Translations({Language.eng.code: "Hello", Language.fra.code: "Bonjour"});
    expect(t[Language.zho_hant.code], "Hello");
  });
}
