import 'package:json_annotation/json_annotation.dart';

part 'today.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiCard {
  @JsonKey(
    name: 'id',
    disallowNullValue: true,
    required: true,
  )
  final String id;

  @JsonKey(
    name: 'text',
    disallowNullValue: true,
    required: true,
  )
  final String text;

  @JsonKey(
    name: 'image',
    disallowNullValue: true,
    required: true,
  )
  final Image image;

  ApiCard({
    this.id,
    this.text,
    this.image,
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
  final String url;

  const Image({
    this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
