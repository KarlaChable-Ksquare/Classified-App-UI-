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
    var resp = await MyAdsProvider().post('/ads/user', {});
    var postData = resp['data'];
    ads = postData.map<AdsModel>((ad) => AdsModel.fromJson(ad)).toList();
    return ads;
  }

  void createPost(AdsModel ad) async {
    var resp = await MyAdsProvider().post('/ads', ad.toJson());
    //print(resp['data']);
  }

  void patchPost(AdsModel ad) async {
    var resp = await MyAdsProvider().patch('/ads/${ad.sId}', ad.toJson());
    //print(resp['data']); //respuesta al hacer patch
  }
}
