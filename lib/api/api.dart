import 'dart:developer';

import 'package:http/http.dart';
import 'package:patta/api/converter/today_converter.dart' as today_converter;
import 'package:patta/app/dio.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/model/CardModel.dart';

import '../model/NetworkErrorCardModel.dart';

class PariyattiApi {
  final TODAY_URL = '/api/v1/today.json';

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
    try {
      var response = await GetDio.getDio(baseURL: baseUrl).get(TODAY_URL);
      log(response.data.toString(), level: 1, name: "json");
      return today_converter.convertJsonToCardModels(response.data, baseUrl);
    } catch (se) {
      // FIXME: This is really kind of a hack. I can't see an obvious way to convince FutureBuilder not to die
      //        when the Future it's calculating throws an exception. The nice way to do this would be to set
      //        snapshot.hasError somehow, but I'm not sure if that's possible. For now, the sentinel works. -sd
      var seString = se.toString();
      return [NetworkErrorCardModel.create("Could not reach Pariyatti server '$baseUrl': \n\n$seString")];
    }
  }
}
