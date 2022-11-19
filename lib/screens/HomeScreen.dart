import 'package:flutter/material.dart';
import 'package:practice_navigation/custom_widgets/HomeScreen_Card.dart';
import 'package:practice_navigation/customs/buttonCustom.dart';
import 'package:practice_navigation/model/ads.dart';
import 'package:practice_navigation/services/ads.dart';
import 'package:practice_navigation/services/myuser.dart';
import 'package:practice_navigation/customs/textStyles.dart';
import 'package:practice_navigation/utils/alert_manager.dart';
import 'package:practice_navigation/customs/circulatorManager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text("Ads Listing"),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/settings', arguments: {});
              },
              child: FutureBuilder(
                future: MyUserService().myUserPost(),
                builder: (((context, snapshot) {
                  if (snapshot.hasData) {
                    Map userData = snapshot.data!;
                    return CircleAvatar(
                      backgroundImage: NetworkImage(userData['imgURL']),
                      radius: 16,
                    );
                  }
                  if (snapshot.hasError) {
                    return AlertManager().errorMessage();
                  }
                  return CirculatorManager().circleUpdate();
                })),
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: GetAllAds().fetchUserPosts(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  List<AdsModel> ads = snapshot.data!;
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.72),
                    itemCount: ads.length,
                    itemBuilder: (((context, index) {
                      return HomeScreenCard(
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
                if (snapshot.hasError) {
                  return AlertManager().errorMessage();
                }
                return CirculatorManager().circleUpdate();
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: ButtonCustom().floatButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
