import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:univeos/src/models/news_model.dart';
import 'package:univeos/src/utils/user_preferences.dart';

class NewsProvider {
  final String _url = '';
  final _prefs = new UserPreferences();

  Future<NewsModel> post(String accessToken, int page) async {
    print('News request');

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    };

    Map<String, dynamic> body = {
      'accessToken': accessToken,
      'appIdentifier': '',
      'destinyType': 'news',
      'keyName': 'news',
      'locale': 'es',
      'paginationParams': {'block': page, 'perBlock': 9}
    };

    final resp =
        await http.post(_url, headers: headers, body: json.encode(body));

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);

      final news = NewsModel.fromJson(decodedData);
      _prefs.accessToken = news.accessToken;

      return news;
    }

    return null;
  }
}
