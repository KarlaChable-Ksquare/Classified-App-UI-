import 'package:flutter/material.dart';
import 'package:practice_navigation/data/myAds.dart';
import 'package:practice_navigation/custom_widgets/MyAdsScreen_Card.dart';
import 'package:practice_navigation/screens/EditAdScreen.dart';
import 'package:practice_navigation/data/ads.dart';

class MyAdsScreen extends StatelessWidget {
  MyAdsScreen({super.key});

  final adsData = InformationMyAds();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("My Ads"),
      ),
      body: Column(children: [
        Container(
          child: Expanded(
            child: ListView.builder(
                itemCount: adsData.myAds.length,
                itemBuilder: ((context, index) {
                  return MyAdsScreenCard(
                      id: adsData.myAds[index]['id'],
                      title: adsData.myAds[index]['title'],
                      price: adsData.myAds[index]['price'],
                      createdBy: adsData.myAds[index]['createdBy'],
                      createdAt: adsData.myAds[index]['createdAt'],
                      mobile: adsData.myAds[index]['mobile'],
                      description: adsData.myAds[index]['description'],
                      images: adsData.myAds[index]['images'][0],
                      imagesAll: adsData.myAds[index]['images']);
                })),
          ),
        ),
      ]),
    );
  }
}
