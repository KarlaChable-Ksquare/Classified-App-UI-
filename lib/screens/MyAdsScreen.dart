import 'package:flutter/material.dart';
import 'package:practice_navigation/model/ads.dart';
import 'package:practice_navigation/services/ads.dart';
import 'package:practice_navigation/custom_widgets/MyAdsScreen_Card.dart';
import 'package:practice_navigation/customs/circulatorManager.dart';
import 'package:practice_navigation/utils/alert_manager.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("My Ads"),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: GetAllAds().fetchMyPosts(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List<AdsModel> ads = snapshot.data!;
                return ListView.builder(
                  itemCount: ads.length,
                  itemBuilder: (((context, index) {
                    return MyAdsScreenCard(
                      id: ads[index].sId!,
                      title: ads[index].title!,
                      description: ads[index].description!,
                      price: ads[index].price!,
                      images: ads[index].images!,
                      authorName: ads[index].authorName!,
                      userId: ads[index].userId!,
                      mobile: ads[index].mobile!,
                      createdAt: ads[index].createdAt!,
                    );
                  })),
                );
              }
              //
              if (snapshot.hasError) {
                AlertManager().errorMessage();
              }
              return CirculatorManager().circleUpdate();
            }),
          ),
        ),
      ]),
    );
  }
}
