import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:/src/models/home_info_model.dart';
import 'dart:convert';

class HomeInfoProvider {

  final String _url = '';

  Future<HomeInfoModel> post(String accessToken) async {
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

      return homeInfo;
    }

    return null;
  }

}