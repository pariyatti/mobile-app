import 'package:json_annotation/json_annotation.dart';

part 'today.g.dart';

@JsonSerializable(explicitToJson: true)
class TodayResponse {
  @JsonKey(
    name: 'today_cards',
    disallowNullValue: true,
    required: true,
  )
  final List<CardWrapper> cards;

  TodayResponse({this.cards});

  factory TodayResponse.fromJson(Map<String, dynamic> json) => _$TodayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TodayResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CardWrapper {
  @JsonKey(
    name: 'card',
    disallowNullValue: true,
    required: true,
  )
  final Card card;

  CardWrapper({this.card});

  factory CardWrapper.fromJson(Map<String, dynamic> json) => _$CardWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$CardWrapperToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Card {
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

  Card({
    this.id,
    this.text,
    this.image,
  });

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
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
