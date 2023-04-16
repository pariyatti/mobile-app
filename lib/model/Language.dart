import 'dart:developer';

import 'package:patta/app/log.dart';

class Language {
  static const String SETTINGS_KEY = 'language';

  final String code; // ISO 639-3
  final String name;

  const Language(this.code, this.name);

  get getCode => code;

  static const List<Language> all
    = <Language>[eng, fra, ita, por, spa, srp, zho_hant];
  static const eng = Language("eng", "English");
  static const fra = Language("fra", "français");
  static const ita = Language("ita", "italiano");
  static const lit = Language("lit", "lietuvių kalba");
  static const por = Language("por", "português");
  static const spa = Language("spa", "español");
  static const srp = Language("srp", "Srpsko-Hrvatski");
  static const zho_hant = Language("zho-hant", "中文");

  static Language from(String? code) {
    if (code == null) {
      log2("Language.from 'code' was null. Assuming English.");
      return Language.eng;
    }
    return all.firstWhere((lang) => lang.code == code);
  }

  @override
  String toString() {
    return 'Language{code: $code, name: $name}';
  }
}
