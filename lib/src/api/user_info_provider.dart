import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:/src/models/user_info_model.dart';
import 'dart:convert';

import 'package:/src/utils/user_preferences.dart';

class UserInfoProvider {

  final String _url = '';
  final _prefs = new UserPreferences();

  Future<UserInfoModel> post(String accessToken) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      HttpHeaders.userAgentHeader: ""
    };

    Map<String, String> body = {
      "accessToken": accessToken,
      "locale": "es",
    };

    final resp = await http.post(_url, headers: headers, body: json.encode(body));

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);

      final model = UserInfoModel.fromJson(decodedData);
      print('previous token = ${_prefs.accessToken}');
      _prefs.accessToken = model.accessToken;
      print('last token = ${_prefs.accessToken}');

      // print('previous token = ${_prefs.accessToken}');
      // _prefs.accessToken = decodedData['accessToken'];
      // print('last token = ${_prefs.accessToken}');

      return model;
    }

    return null;
  }

}