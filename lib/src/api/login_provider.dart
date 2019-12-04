import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:/src/utils/user_preferences.dart';

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
      "firebaseToken": "",
      "locale": "es",
      "password": password
    };

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