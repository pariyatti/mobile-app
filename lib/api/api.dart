import 'dart:convert' as converter;

import 'package:http/http.dart';
import 'package:patta/api/model/today.dart';
import 'package:patta/ui/model/CardModel.dart';
import 'package:patta/ui/model/StackedInspirationCardModel.dart';

class PariyattiApi {
  static const BASE_URL = 'http://kosa-sandbox.pariyatti.org';

  Client _client;

  PariyattiApi() {
    this._client = Client();
  }

  PariyattiApi.withClient(Client client) {
    this._client = client;
  }

  Future<List<CardModel>> fetchToday() async {
    const TODAY_URL = '$BASE_URL/api/today.json';

    final response = await _client.get(TODAY_URL);

    if (response.statusCode == 200) {
      return _convertToCardModels(response.body);
    } else {
      return Future.error(response.body);
    }
  }

  static List<CardModel> _convertToCardModels(
    String responseBody,
  ) {
    final Iterable iterable = converter.jsonDecode(responseBody);
    return iterable
        .map((apiCard) {
          final String cardType = apiCard['type'];
          if (cardType == 'stacked_inspiration') {
            ApiCard card = ApiCard.fromJson(apiCard);
            return StackedInspirationCardModel(
              id: card.id,
              text: card.text,
              imageUrl: '$BASE_URL${card.image.url}',
            );
          } else {
            return null;
          }
        })
        .where((card) => (card != null))
        .toList();
  }
}
