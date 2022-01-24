class Translations {
  final Map<String, String> translations;

  Translations(this.translations);

  static Translations fromJson(Map<String, dynamic> json) {
    return Translations(Map<String,String>.from(json));
  }

  void add(String k, String v) {
    translations[k] = v;
  }

  String? operator[](String k) {
    return translations[k];
  }

  Map<String, String> toJson() {
    return translations;
  }
}
