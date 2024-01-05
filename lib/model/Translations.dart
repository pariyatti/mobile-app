import 'package:equatable/equatable.dart';

import 'Language.dart';

class Translations extends Equatable {
  final Map<String, String> translations;

  Translations(this.translations);

  static Translations fromJson(Map<String, dynamic> json) {
    // TODO: there really must be a sensible way to map over a collection of k/v
    //       pairs and turn it into another map, which would allow `translations`
    //       to be Map<Language, String> instead? -sd
    return Translations(Map<String,String>.from(json));
  }

  void add(String k, String v) {
    translations[k] = v;
  }

  String? operator[](String k) {
    return translations[k] ?? translations[Language.eng.code];
  }

  Map<String, String> toJson() {
    return translations;
  }

  @override
  List<Object?> get props => [translations];
}
