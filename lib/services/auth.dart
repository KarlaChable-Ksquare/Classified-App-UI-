import 'dart:convert';
import 'package:practice_navigation/model/user.dart';
import 'package:practice_navigation/utils/alert_manager.dart';
import 'package:practice_navigation/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  void register(context, UserModel user) async {
    var url = Uri.parse("${Constants().serverUrl}/auth/register");
    var userObj = user.toJson();
    try {
      var resp = await http.post(url,
          body: jsonEncode(userObj),
          headers: {'Content-Type': 'application/json'});
      var respObj = jsonDecode(resp.body);
      print(respObj['status']);

      if (respObj['status'] == false) {
        AlertManager().displaySnackRegisterFalse(context, respObj['message']);
      }
      if (respObj['status'] == true) {
        //print(userObj);
        //print('userdata enviado al server');
        AlertManager().displaySnackRegisterTrue(context, 'Successful Register');
      }
    } catch (e) {
      print(e);
    }
  }

  void login(context, UserModel user) async {
    var storage = FlutterSecureStorage();
    var url = Uri.parse("${Constants().serverUrl}/auth/login");
    //print('push en login');
    var userObj = user.toJson();
    try {
      var resp = await http.post(url,
          body: jsonEncode(userObj),
          headers: {'Content-Type': 'application/json'});
      var respObj = jsonDecode(resp.body);
      print(respObj['status']);
      if (respObj['status'] == false) {
        AlertManager().displaySnackbarError(context, respObj['message']);
      }
      if (respObj['status'] == true) {
        storage.write(key: 'userId', value: respObj['data']['user']['_id']);
        storage.write(key: 'token', value: respObj['data']['token']);
        storage.write(
            key: 'refreshToken', value: respObj['data']['refreshToken']);
        AlertManager().displaySnackbarSuccess(context, respObj['message']);
        Navigator.pushNamed(context, '/');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> refreshToken() async {
    var storage = FlutterSecureStorage();
    var userId = await storage.read(key: 'userId');
    var refreshToken = await storage.read(key: 'refreshToken');
    var url = Uri.parse("${Constants().serverUrl}/auth/refreshToken");
    if (refreshToken != null) {
      var resp = await http.post(url,
          body: jsonEncode(
            {
              "id": userId,
              "refreshToken": refreshToken,
            },
          ),
          headers: {
            'Content-Type': 'application/json',
          });
      var respObj = jsonDecode(resp.body);
      if (respObj['status'] == true) {
        storage.write(key: 'token', value: respObj['data']['token']);
        storage.write(
            key: 'refreshToken', value: respObj['data']['refreshToken']);
      }
      return true;
    } else {
      print("none");
      return false;
    }
  }
}
