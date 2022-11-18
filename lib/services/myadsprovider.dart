import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:practice_navigation/utils/alert_manager.dart';
import 'package:practice_navigation/utils/contants.dart';
import 'package:http/http.dart' as http;

class MyAdsProvider {
  var storage = const FlutterSecureStorage();

  Future<String> _getToken() async {
    var token = await storage.read(key: 'token');
    return token.toString();
  }

  Future<Map<String, String>> _getHeaders() async {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _getToken()}'
    };
  }

  Future post(endpoint, body) async {
    var responseJson;
    var requestURL = Uri.parse("${Constants().serverUrl}$endpoint");
    try {
      var response = await http.post(
        requestURL,
        headers: await _getHeaders(),
        body: jsonEncode(body),
      );
      responseJson = _handleResponse(response);
      //print(responseJson['status']);
      if (responseJson['status'] == true) {
        AlertManager().snackbarSuccessAd("Successful Ad Creation");
      }
      if (responseJson['status'] == false) {
        AlertManager().snackbarErrorAd("Error ${response.statusCode}");
      }
    } catch (e) {
      print("error");
      print(e);
    }
    //print(responseJson);
    return responseJson;
  }

  Future patch(endpoint, body) async {
    var responseJson;
    var requestURL = Uri.parse("${Constants().serverUrl}$endpoint");
    try {
      var response = await http.patch(
        requestURL,
        headers: await _getHeaders(),
        body: jsonEncode(body),
      );
      responseJson = _handleResponse(response);
      //print(responseJson);
      //print(responseJson['status']);
      if (responseJson['status'] == true) {
        AlertManager().snackbarSuccessAd("Successful Ad Uppdate");
      }
      if (responseJson['status'] == false) {
        AlertManager().snackbarErrorAd("Error ${response.statusCode}");
      }
    } catch (e) {
      print("error");
      print(e);
    }
    //print(responseJson);
    return responseJson;
  }

  _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 201:
        return jsonDecode(response.body);
      case 401:
        return {'message': 'invalid request'};
      case 403:
        return {'message': 'UnAuthorized'};
      case 500:
        return {'message': 'Server Error'};
      default:
        return {'message': 'Unknown Error'};
    }
  }
}
