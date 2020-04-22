import 'dart:convert' as converter;

import 'package:patta/api/model/today.dart';
import 'package:patta/data_model/inspiration_card.dart';

const _TODAY_JSON =
    '{"today_cards":[{"card":{"published":true,"bookmarkable":true,"shareable":true,"alignment":null,"flag":"","title":"","header":"","text":"Blue skiiiieeeeesssssss smiling at meeeeeeeeee.","image":{"url":"/uploads/card/image/393b47a8-b002-4ff5-95f6-dd6df497cf69/bluesky.jpeg"},"type":"inspiration","id":"393b47a8-b002-4ff5-95f6-dd6df497cf69"}},{"card":{"published":true,"bookmarkable":true,"shareable":true,"alignment":null,"flag":"","title":"","header":"","text":"Enjoy some beautiful red flowers on the ground did you know you can also turn them into jam but you have to dry them on your rootop first which maybe you don\'t have the time for and you\'d rather buy jam from a store.","image":{"url":"/uploads/card/image/67f4000a-d6f8-4138-9365-d20758ff7a72/flowers.jpeg"},"type":"inspiration","id":"67f4000a-d6f8-4138-9365-d20758ff7a72"}},{"card":{"published":true,"bookmarkable":true,"shareable":true,"alignment":null,"flag":"","title":"","header":"","text":"This card has a Peepal leaf on it because if there\'s one thing we know about meditation it\'s that it involves a lot of Peepal leaves, right?","image":{"url":"/uploads/card/image/8a1ceabb-1229-4e1f-bf19-7f3ae516e173/leaf.jpg"},"type":"inspiration","id":"8a1ceabb-1229-4e1f-bf19-7f3ae516e173"}}]}';

List<InspirationCardModel> fetchToday() {
  return _convertToInspirationCardModels(
    TodayResponse.fromJson(converter.jsonDecode(_TODAY_JSON)),
  );
}

List<InspirationCardModel> _convertToInspirationCardModels(
  TodayResponse response,
) {
  return response.cards
      .map((cardWrapper) => InspirationCardModel(
            id: cardWrapper.card.id,
            text: cardWrapper.card.text,
            imageUrl: cardWrapper.card.image.url,
          ))
      .toList();
}
