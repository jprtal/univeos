import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:/src/models/tui_model.dart';
import 'dart:convert';

import 'package:/src/models/user_info_model.dart';
import 'package:/src/utils/utils.dart';

class TuiProvider {

  Future<String> logint(String userId, String accessToken) async {
    final String url = '';

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      HttpHeaders.userAgentHeader: ''
    };

    Map<String, String> body = {
      'userId': userId,
      'token': accessToken,
    };

    final resp = await http.post(url, headers: headers, body: body);

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);

      final bearer = decodedData['token'];
      // print('BEARER: $bearer');

      return bearer;
    }

    return null;
  }

  Future<TuiModel> cardUpdate(String bearer, UserInfoModel userInfo) async {
    final String url = '';

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $bearer',
      HttpHeaders.contentTypeHeader: 'multipart/form-data',
      HttpHeaders.userAgentHeader: ''
    };

    DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    Map<String, dynamic> deviceData;

    try {
      if (Platform.isAndroid) {
        deviceData = Utils.readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = Utils.readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    Map<String, String> user = {
      'document': userInfo.dni,
      'email': userInfo.email,
      'nia': userInfo.nia,
      'userid': userInfo.id.toString(),
      'username': userInfo.username
    };

    // Only Android for now
    Map<String, String> device = {
      'appVersion': '',
      'compilever': deviceData['version.sdkInt'].toString(),
      'data': null,
      'deviceid': deviceData['androidId'],
      'model': deviceData['model'],
      'nfc': 'true',
      'osid': deviceData['version.release'],
      'osversion': 'Android',
      'root': 'false',
      'trademark': deviceData['manufacturer'],
      'udid': deviceData['androidId'],
      'universiaVersion': '',
    };


    final request = new http.MultipartRequest("POST", Uri.parse(url));
    request.headers.addAll(headers);
    request.fields['user'] = json.encode(user);
    request.fields['device'] = json.encode(device);
    request.fields['force'] = 'true';
    request.fields['forceUpdate'] = 'true';

    http.Response response = await http.Response.fromStream(await request.send());

    print(response.body);

    if (response.statusCode == 200) {
      // final decodedData = json.decode(response.body);

      // Need to substring because of the first and last characters
      final decodedData = json.decode(response.body.substring(1, response.body.length - 1));

      final tui = TuiModel.fromJson(decodedData);

      return tui;
    }

    return null;
  }

}