
class Language {
  final String code;
  final String name;

  const Language(this.code, this.name);

  static const List<Language> all = <Language>[Language.eng, Language.fra];
  static const eng = Language("eng", "English");
  static const fra = Language("fra", "French");
  // TODO: add the other languages :)
}
