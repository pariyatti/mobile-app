import 'dart:convert' as converter;

import 'package:http/http.dart' as http;
import 'package:patta/api/model/today.dart';
import 'package:patta/data_model/inspiration_card.dart';

const _BASE_URL = 'http://kosa-sandbox.pariyatti.org';

Future<List<CardModel>> fetchToday() async {
  const TODAY_URL = '$_BASE_URL/api/today.json';

  final response = await http.get(TODAY_URL);

  if (response.statusCode == 200) {
    return _convertToCardModels(response);
  } else {
    return Future.error(response.body);
  }
}

List<CardModel> _convertToCardModels(http.Response response) {
  final Iterable iterable = converter.jsonDecode(response.body);
  return iterable
      .map((apiCard) {
        final String cardType = apiCard['type'];
        if (cardType == 'stacked_inspiration') {
          ApiCard card = ApiCard.fromJson(apiCard);
          return InspirationCardModel(
            id: card.id,
            text: card.text,
            imageUrl: '$_BASE_URL${card.image.url}',
          );
        } else {
          return null;
        }
      })
      .where((card) => (card != null))
      .toList();
}
