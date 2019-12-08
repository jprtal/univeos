import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:/src/models/news_model.dart';

class NewsProvider {

  final String _url = '';

  Future<NewsModel> post(String accessToken, int page) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      HttpHeaders.userAgentHeader: ""
    };

    Map<String, dynamic> body = {
      "accessToken": accessToken,
      "appIdentifier": "",
      "destinyType": "news",
      "keyName": "news",
      "locale": "es",
      "paginationParams": {
        "block": page,
        "perBlock": 9
      }
    };

    final resp = await http.post(_url, headers: headers, body: json.encode(body));

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);

      final news = NewsModel.fromJson(decodedData);

      return news;
    }

    return null;
  }

}