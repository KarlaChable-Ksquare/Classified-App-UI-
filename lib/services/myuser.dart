import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_navigation/model/user.dart';
import 'package:practice_navigation/utils/alert_manager.dart';
import 'package:practice_navigation/utils/contants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyUserService {
  Future<Map> myUserPost() async {
    var storage = const FlutterSecureStorage();
    Map userData;
    var url = Uri.parse("${Constants().serverUrl}/user/profile");
    var token = await storage.read(key: 'token');
    var resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    //print(resp.statusCode);
    if (resp.statusCode == 401) {
      print("invalid request");
    }
    if (resp.statusCode == 403) {
      print("UnAuthorized");
    }
    if (resp.statusCode == 500) {
      print("Server Error");
    }
    //print(resp.body);
    var respJson = jsonDecode(resp.body);
    var postData = respJson['data'];
    userData = postData;
    return userData;
  }

  Future<Map> myUserPatch(context, UserModel user) async {
    var storage = const FlutterSecureStorage();
    Map userData;
    var url = Uri.parse("${Constants().serverUrl}/user");
    var token = await storage.read(key: 'token');
    var resp = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(user.toJson()),
    );
    //print(resp.statusCode);
    if (resp.statusCode == 401) {
      print("invalid request");
    }
    if (resp.statusCode == 403) {
      print("UnAuthorized");
    }
    if (resp.statusCode == 500) {
      print("Server Error");
    }
    //print(resp.body);

    var respJson = jsonDecode(resp.body);
    var patchData = respJson['data'];
    userData = patchData;
    //print(userData);

    if (respJson['status'] == true) {
      AlertManager().displaySnackbarSuccess(context, 'Successful Update User');
      Navigator.pushNamed(context, '/settings');
    }
    if (respJson['status'] == false) {
      AlertManager()
          .displaySnackbarError(context, 'Error = ${resp.statusCode}');
    }
    return userData;
  }
}
