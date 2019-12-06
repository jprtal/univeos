import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:/src/models/classes_model.dart';
import 'dart:convert';

class ClassesProvider {

  final String _url = '';

  Future<ClassesModel> post(String accessToken) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      HttpHeaders.userAgentHeader: ""
    };

    Map<String, dynamic> body = {
      "accessToken": accessToken,
      "appIdentifier": "",
    };

    final resp = await http.post(_url, headers: headers, body: json.encode(body));

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);

      final classes = ClassesModel.fromJson(decodedData);

      return classes;
    }

    return null;
  }

}