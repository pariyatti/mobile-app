import 'package:json_annotation/json_annotation.dart';

part 'today.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiCard {
  @JsonKey(name: 'id', disallowNullValue: true, required: true)
  late final String id;

  @JsonKey(name: 'bookmarkable', disallowNullValue: true, required: true)
  late final bool isBookmarkable;

  @JsonKey(name: 'header', disallowNullValue: true, required: true)
  final String? header;

  @JsonKey(name: 'text', disallowNullValue: true, required: false)
  final String? text;

  @JsonKey(name: 'image', disallowNullValue: true, required: false)
  final Image? image;

  @JsonKey(name: 'pali', disallowNullValue: true, required: false)
  final String? pali;

  @JsonKey(name: 'audio', disallowNullValue: true, required: false)
  final Audio? audio;

  @JsonKey(name: 'translations', disallowNullValue: true, required: false)
  final List<Translation>? translations;

  @JsonKey(name: 'text_color', disallowNullValue: true, required: false)
  final String? textColor;

  ApiCard({
    required this.id,
    required this.isBookmarkable,
    this.header,
    this.text,
    this.image,
    this.pali,
    this.audio,
    this.translations,
    this.textColor,
  });

  factory ApiCard.fromJson(Map<String, dynamic> json) => _$ApiCardFromJson(json);

  Map<String, dynamic> toJson() => _$ApiCardToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Image {
  @JsonKey(
    name: 'url',
    disallowNullValue: true,
    required: true,
  )
  final String? url;

  const Image({
    this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Audio {
  @JsonKey(
    name: 'url',
    disallowNullValue: true,
    required: true,
  )
  final String? url;

  const Audio({this.url});

  factory Audio.fromJson(Map<String, dynamic> json) => _$AudioFromJson(json);

  Map<String, dynamic> toJson() => _$AudioToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Translation {
  @JsonKey(
    name: 'language',
    disallowNullValue: true,
    required: true,
  )
  final String? language;
  @JsonKey(
    name: 'translation',
    disallowNullValue: true,
    required: true,
  )
  final String? translation;
  @JsonKey(
    name: 'id',
    disallowNullValue: true,
    required: true,
  )
  final String? id;

  const Translation({
    this.language,
    this.translation,
    this.id,
  });

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationToJson(this);
}
