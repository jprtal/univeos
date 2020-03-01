import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:/src/models/home_info_model.dart';
import 'dart:convert';

import 'package:/src/utils/user_preferences.dart';

class HomeInfoProvider {

  final String _url = '';
  final _prefs = new UserPreferences();

  Future<HomeInfoModel> post(String accessToken) async {
    print("HomeInfo request");

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      HttpHeaders.userAgentHeader: ""
    };

    Map<String, String> body = {
      "accessToken": accessToken,
    };

    final resp = await http.post(_url, headers: headers, body: json.encode(body));

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);

      final homeInfo = HomeInfoModel.fromJson(decodedData);
      _prefs.accessToken = homeInfo.accessToken;

      return homeInfo;
    }

    return null;
  }

}