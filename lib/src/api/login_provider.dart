import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:univeos/src/utils/user_preferences.dart';
import 'package:univeos/src/utils/utils.dart';

class LoginProvider {
  final String _url = '';
  final _prefs = new UserPreferences();

  Future<String> post(String username, String password) async {
    print('Login request');

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    };

    Map<String, String> body = {
      'appIdentifier': '',
      'email': username,
      'firebaseToken': '${Utils.randomString(11)}',
      'locale': 'es',
      'password': password
    };

    final resp =
        await http.post(_url, headers: headers, body: json.encode(body));
    final decodedData = json.decode(resp.body);

    print(body['firebaseToken']);

    if (decodedData['accessToken'] != null) {
      _prefs.accessToken = decodedData['accessToken'];
      _prefs.username = username;

      return decodedData['accessToken'];
    } else {
      return null;
    }
  }
}
