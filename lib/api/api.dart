import 'dart:developer';

import 'package:http/http.dart';
import 'package:patta/api/converter/today_converter.dart' as today_converter;
import 'package:patta/app/dio.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/ui/model/CardModel.dart';

class PariyattiApi {
  String baseUrl;
  PariyattiDatabase _database;
  late Client _client;

  PariyattiApi(this.baseUrl, this._database) {
    this._client = Client();
  }

  PariyattiApi.withClient(this.baseUrl, this._database, Client client) {
    this._client = client;
  }

  Future<List<CardModel>> fetchToday() async {
    final todayUrl = '/api/v1/today.json';

    var response = await GetDio.getDio(baseURL: baseUrl).get(todayUrl);

    log(response.data.toString());

    return today_converter.convertJsonToCardModels(response.data, baseUrl);
  }
}
