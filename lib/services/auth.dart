import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practice_navigation/utils/alert_manager.dart';
import 'package:practice_navigation/utils/contants.dart';
import 'package:practice_navigation/model/user.dart';
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
      //print(respObj['status']);
      //print(userObj);

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
    var storage = const FlutterSecureStorage();
    var url = Uri.parse("${Constants().serverUrl}/auth/login");
    var userObj = user.toJson();
    try {
      var resp = await http.post(url,
          body: jsonEncode(userObj),
          headers: {'Content-Type': 'application/json'});
      var respObj = jsonDecode(resp.body);

      if (respObj['status'] == false) {
        AlertManager().displaySnackbarError(context, respObj['message']);
      }
      if (respObj['status'] == true) {
        storage.write(key: 'userId', value: respObj['data']['user']['_id']);
        storage.write(key: 'token', value: respObj['data']['token']);
        AlertManager().displaySnackbarSuccess(context, respObj['message']);
        Navigator.pushNamed(context, '/');
      }
    } catch (e) {
      print(e);
    }
  }
}
