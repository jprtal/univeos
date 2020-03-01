import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:/src/utils/user_preferences.dart';

import '../utils/utils.dart';

class LoginProvider {

  final String _url = '';
  final _prefs = new UserPreferences();

  Future<String> post(String username, String password) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      HttpHeaders.userAgentHeader: ""
    };

    Map<String, String> body = {
      "appIdentifier": "",
      "email": username,
      "firebaseToken": "${Utils.randomString(11)}",
      "locale": "es",
      "password": password
    };

    print(body['firebaseToken']);

    final resp = await http.post(_url, headers: headers, body: json.encode(body));
    final decodedData = json.decode(resp.body);

    if (decodedData['accessToken'] != null) {
      _prefs.accessToken = decodedData['accessToken'];
      _prefs.username = username;

      return decodedData['accessToken'];
    } else {
      return null;
    }
  }

}