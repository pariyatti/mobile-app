import 'dart:developer';

class Language {
  final String code;
  final String name;

  const Language(this.code, this.name);

  get getCode => code;

  static const List<Language> all = <Language>[Language.eng, Language.fra];
  static const eng = Language("eng", "English");
  static const fra = Language("fra", "French");
  // TODO: add the other languages :)

  static Language from(String? code) {
    if (code == null) {
      log("Language.from 'code' was null. Assuming English.", level: 1, name: "language");
      return Language.eng;
    }
    return all.firstWhere((lang) => lang.code == code);
  }
}
