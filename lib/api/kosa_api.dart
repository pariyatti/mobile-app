import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:patta/api/converter/today_converter.dart' as today_converter;
import 'package:patta/app/dio.dart';
import 'package:patta/app/feed_preferences.dart';
import 'package:patta/app/log.dart';
import 'package:patta/model/CardModel.dart';
import 'package:patta/model/Video.dart';
import '../model/NetworkErrorCardModel.dart';

class KosaApi {
  final TODAY_URL = '/api/v2/today.json';
  final VIDEOS_URL = '/api/v1/library/videos.json';

  String baseUrl;
  FeedPreferences feedPreferences;

  KosaApi(this.baseUrl, this.feedPreferences);

  Future<List<CardModel>> fetchToday() async {
    try {
      var response = await GetDio.getDio(baseURL: baseUrl).get(TODAY_URL);
      log(response.data.toString(), level: 1, name: "json");
      var models = today_converter.convertJsonToCardModels(response.data, baseUrl);
      models.removeWhere(CardModel.inFuture());
      if (notEnoughCardsPublished(models))
      {
        return [NetworkErrorCardModel.create("Cards have not been published for today yet.")];
      }
      var trimmed = models.takeWhile(CardModel.laterThan(feedPreferences.getTodayMaxDays())).toList();
      return trimmed;
    } on DioException catch (e) {
      logDioError(e);
      return [NetworkErrorCardModel.create("Could not reach Pariyatti server '$baseUrl'.")];
    } on StateError catch (se) {
      logStateError(se);
      return [NetworkErrorCardModel.create("Bad state returned from Pariyatti server '$baseUrl'.")];
    } catch (e) {
      logError(e);
      return [NetworkErrorCardModel.create("Could not reach Pariyatti server '$baseUrl'.")];
    }
  }

  bool notEnoughCardsPublished(List<CardModel> models) {
    var today = DateTime.now();
    var onlyOneDayVisible = feedPreferences.getTodayMaxDays() == 1;
    var todayIsntVisible = models.first.publishedDate != DateTime(today.year, today.month, today.day);
    return onlyOneDayVisible && todayIsntVisible;
  }

  Future<List<Video>> fetchVideos() async {
    var response = await GetDio.getDio(baseURL: baseUrl, cacheEnabled: false).get(VIDEOS_URL);
    log(response.data.toString(), level: 1, name: "json");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = decodeDio(response);
      return jsonData.map<Video>((video) => Video.fromJson(video)).toList();
    } else {
      throw Exception('Failed to load videos. HTTP Status: ${response.statusCode}, Message: ${response.statusMessage}');
    }
  }

  List<dynamic> decodeDio(Response<dynamic> response) {
    if (response.data is Map<String, dynamic> || response.data is List) {
      return response.data;
    }
    // If the response is still a JSON string, decode it
    else if (response.data is String) {
      return jsonDecode(response.data);
    }
    // If the data is in another format
    else {
      throw Exception('Unexpected response format');
    }
  }

  void logDioError(DioException e) {
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

  void logStateError(Error e) {
    log2("StateError: ${e.toString()}");
  }

  void logError(Object e) {
    log2("Error: ${e.toString()}");
  }
}
