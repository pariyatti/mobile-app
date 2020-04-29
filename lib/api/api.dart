import 'dart:convert' as converter;

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:patta/api/model/today.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/ui/model/CardModel.dart';
import 'package:patta/ui/model/PaliWordOfTheDayCardModel.dart';
import 'package:patta/ui/model/StackedInspirationCardModel.dart';

class PariyattiApi {
  // TODO: Get base-url from environment
  static const BASE_URL = 'http://kosa-sandbox.pariyatti.org';

  PariyattiDatabase _database;
  Client _client;

  PariyattiApi(this._database) {
    this._client = Client();
  }

  PariyattiApi.withClient(this._database, Client client) {
    this._client = client;
  }

  Future<List<CardModel>> fetchToday() async {
    const TODAY_URL = '$BASE_URL/api/today.json';

    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      final List<String> cachedResponses = await _database.retrieveFromCache(TODAY_URL);
      if (cachedResponses.isNotEmpty) {
        return _convertToCardModels(cachedResponses.first);
      } else {
        return Future.error('No network available, please try again after connecting to a network.');
      }
    } else {
      final response = await _client.get(TODAY_URL);

      if (response.statusCode == 200) {
        final String responseBody = response.body;
        await _database.addToCache(TODAY_URL, responseBody);

        return _convertToCardModels(responseBody);
      } else {
        return Future.error(response.body);
      }
    }
  }

  // TODO: Extract the parsing logic to a separate class/function
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
              header: card.header,
              text: card.text,
              imageUrl: '$BASE_URL${card.image.url}',
            );
          } else if (cardType == 'pali_word') {
            ApiCard card = ApiCard.fromJson(apiCard);
            if (card.translations.isNotEmpty) {
              return PaliWordOfTheDayCardModel(
                id: card.id,
                header: card.header,
                pali: card.pali,
                audioUrl: '$BASE_URL${card.audio.url}',
                translation: card.translations[0].translation,
              );
            } else {
              return null;
            }
          } else {
            return null;
          }
        })
        .where((card) => (card != null))
        .toList();
  }
}
