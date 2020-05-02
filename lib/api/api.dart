import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:patta/api/converter/today_converter.dart' as today_converter;
import 'package:patta/local_database/database.dart';
import 'package:patta/ui/model/CardModel.dart';

class PariyattiApi {
  String baseUrl;
  PariyattiDatabase _database;
  Client _client;

  PariyattiApi(this.baseUrl, this._database) {
    this._client = Client();
  }

  PariyattiApi.withClient(this.baseUrl, this._database, Client client) {
    this._client = client;
  }

  Future<List<CardModel>> fetchToday() async {
    final todayUrl = '$baseUrl/api/v1/today.json';

    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      final List<String> cachedResponses =
          await _database.retrieveFromCache(todayUrl);
      if (cachedResponses.isNotEmpty) {
        return today_converter.convertJsonToCardModels(
          cachedResponses.first,
          baseUrl,
        );
      } else {
        return Future.error(
          'No network available, please try again after connecting to a network.',
        );
      }
    } else {
      final response = await _client.get(todayUrl);

      if (response.statusCode == 200) {
        final String responseBody = response.body;
        await _database.addToCache(todayUrl, responseBody);

        return today_converter.convertJsonToCardModels(responseBody, baseUrl);
      } else {
        return Future.error(response.body);
      }
    }
  }
}
