import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practice_navigation/model/user.dart';
import 'package:practice_navigation/utils/contants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyUserService {
  Future<Map> myUserPost() async {
    var storage = FlutterSecureStorage();
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
    print(resp.body);
    var respJson = jsonDecode(resp.body);
    var postData = respJson['data'];
    userData = postData;
    return userData;
  }

  Future<Map> myUserPatch(UserModel user) async {
    var storage = FlutterSecureStorage();
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
    print(resp.statusCode);
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
    return userData;
  }
}

/*
    var url = Uri.parse("${Constants().serverUrl}/ads/user");
    var token = await storage.read(key: 'token');
    //try {
    var res = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    print(res.statusCode);
    if (res.statusCode == 401) {
      var isNewTokenGenerated = await AuthService().refreshToken();
      if (isNewTokenGenerated) {
        fetchMyPosts();
      }
    }
    print(res.body);
    var resAsJSON = jsonDecode(res.body);
    var postData = resAsJSON['data'];
    ads = postData.map<AdsModel>((post) => AdsModel.fromJson(post)).toList();
    return ads;
    } catch (e) {
    print('Error $e');
    return ads;
    }
    */