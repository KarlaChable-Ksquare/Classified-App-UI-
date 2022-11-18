import 'dart:convert';
import 'package:practice_navigation/model/ads.dart';
import 'package:practice_navigation/services/myadsprovider.dart';
import 'package:practice_navigation/utils/contants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GetAllAds {
  Future<List<AdsModel>> fetchUserData() async {
    List<AdsModel> ads = [];
    var url = Uri.parse("${Constants().serverUrl}/ads");
    try {
      var res = await http.get(url);
      var resAsJSON = jsonDecode(res.body);
      var postData = resAsJSON['data'];
      ads = postData.map<AdsModel>((ad) => AdsModel.fromJson(ad)).toList();
      return ads;
    } catch (e) {
      print('Error $e');
      return ads;
    }
  }

  Future<List<AdsModel>> fetchMyPosts() async {
    var storage = const FlutterSecureStorage();
    List<AdsModel> ads = [];
    var url = Uri.parse("${Constants().serverUrl}/ads/user");
    var token = await storage.read(key: 'token');
    try {
      var resp = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      var resAsJSON = jsonDecode(resp.body);
      var adData = resAsJSON['data'];
      ads = adData.map<AdsModel>((ad) => AdsModel.fromJson(ad)).toList();
      return ads;
    } catch (e) {
      print("$e");
      return ads;
    }
  }

  void createPost(context, AdsModel ad) async {
    var resp = await MyAdsProvider().post('/ads', ad.toJson(), context);
    //print(resp['data']);
  }

  void patchPost(AdsModel ad, context) async {
    var resp =
        await MyAdsProvider().patch('/ads/${ad.sId}', ad.toJson(), context);
    //print(resp['data']); //respuesta al hacer patch
  }
}
