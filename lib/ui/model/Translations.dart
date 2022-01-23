
class Translations {
  final Map<String, String> translations;

  Translations(this.translations);

  void add(String k, String v) {
    translations[k] = v;
  }

  String? operator[](String k) {
    return translations[k];
  }
}
