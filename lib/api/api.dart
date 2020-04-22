import 'dart:convert' as converter;

import 'package:http/http.dart' as http;
import 'package:patta/api/model/today.dart';
import 'package:patta/data_model/inspiration_card.dart';

const _BASE_URL = 'http://139.59.41.132';

Future<List<InspirationCardModel>> fetchToday() async {
  const TODAY_URL = '$_BASE_URL/api/today.json';

  final response = await http.get(TODAY_URL);

  if (response.statusCode == 200) {
    return _convertToInspirationCardModels(
      TodayResponse.fromJson(converter.jsonDecode(response.body)),
    );
  } else {
    return Future.error(response.body);
  }
}

List<InspirationCardModel> _convertToInspirationCardModels(
  TodayResponse response,
) {
  return response.cards
      .map((cardWrapper) => InspirationCardModel(
            id: cardWrapper.card.id,
            text: cardWrapper.card.text,
            imageUrl: '$_BASE_URL${cardWrapper.card.image.url}',
          ))
      .toList();
}
