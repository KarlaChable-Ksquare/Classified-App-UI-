import 'package:flutter/material.dart';
import 'package:practice_navigation/services/myuser.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({
    super.key,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  _openURL(url) async {
    url = Uri.parse(url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Setting Screen"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
                future: MyUserService().myUserPost(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    Map userData = snapshot.data!;
                    return Container(
                      padding: EdgeInsets.fromLTRB(0, 4, 24, 28),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(userData['imgURL']),
                                radius: 24,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(userData['name'],
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(userData['mobile'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              )
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/editprofile',
                                    arguments: {
                                      'name': userData['name'],
                                      'email': userData['email'],
                                      'mobile': userData['mobile'],
                                      'imgURL': userData['imgURL'],
                                    });
                              },
                              child: Text("Edit",
                                  style: TextStyle(
                                      color: Color(0xfff25723),
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    print(snapshot.hasError);
                    return const Center(
                        child: Text("Something went wrong :( "));
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.black,
                          color: Color(0xfff25723)));
                })),
            Row(
              children: [
                Icon(
                  Icons.ads_click,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 28),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/myads', arguments: {});
                    },
                    child: Text(
                      "My Ads",
                      style: TextStyle(color: Color(0xfff25723), fontSize: 16),
                    )),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Icon(
                  Icons.person_outline_outlined,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 28),
                TextButton(
                    onPressed: () {
                      _openURL("https://appmaking.com/about");
                    },
                    child: Text("About Us",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 16))),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Icon(
                  Icons.contact_page,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 28),
                TextButton(
                    onPressed: () {
                      _openURL("https://appmaking.com/contact");
                    },
                    child: Text("Contact Us",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 16)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
