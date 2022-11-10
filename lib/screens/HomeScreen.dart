import 'package:flutter/material.dart';
import 'package:practice_navigation/custom_widgets/HomeScreen_Card.dart';
import 'package:practice_navigation/data/ads.dart';
import 'package:practice_navigation/model/ads.dart';
import 'package:practice_navigation/services/ads.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    dynamic user,
    super.key,
  });
  //final adsData = InformationAds();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text("Ads Listing"),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/settings', arguments: {});
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/miku_sakura.jpg'),
                  radius: 16,
                ),
              ))
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: GetAllAds().fetchUserData(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  List<AdsModel> ads = snapshot.data!;
                  return GridView.builder(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                //
                if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }
                return const Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        color: Color(0xfff25723)));
              }),
            ),
            /*child: GridView.builder(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.72),
              itemCount: adsData.ads.length,
              itemBuilder: (context, index) {
                return HomeScreenCard(
                  id: adsData.ads[index]['id'],
                  title: adsData.ads[index]['title'],
                  price: adsData.ads[index]['price'],
                  createdBy: adsData.ads[index]['createdBy'],
                  createdAt: adsData.ads[index]['createdAt'],
                  mobile: adsData.ads[index]['mobile'],
                  description: adsData.ads[index]['description'],
                  imagesAll: adsData.ads[index]['images'],
                  images: adsData.ads[index]['images'][0],
                );
              },
            ),
            */
          ),
        ],
      ))
      //
      ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createad', arguments: {});
        },
        backgroundColor: Color(0xfff25723),
        elevation: 8,
        child: Icon(
          Icons.add_a_photo_outlined,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
