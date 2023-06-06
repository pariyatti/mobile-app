import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:patta/api/converter/today_converter.dart' as today_converter;
import 'package:patta/app/dio.dart';
import 'package:patta/app/log.dart';
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
    } on DioError catch (e) {
      logError(e);
      return [NetworkErrorCardModel.create("Could not reach Pariyatti server '$baseUrl'.")];
    } catch (se) {
      logError(se);
      return [NetworkErrorCardModel.create("Could not reach Pariyatti server '$baseUrl'.")];
    }
  }

  void logError(e) {
    if (e.response != null) {
      log2(e.response!.data);
      log2(e.response!.headers as String);
      log2(e.response!.requestOptions as String);
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      log2("Request options: ${e.requestOptions}");
      log2("DioError Type: ${e.type}");
      log2("DioError Message: ${e.message}");
    }
  }
}
