import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
            Container(
              padding: EdgeInsets.fromLTRB(0, 4, 24, 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/miku_sakura.jpg'),
                        radius: 24,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Karla Chable",
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 4,
                          ),
                          Text("9999012345",
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
                        Navigator.pushNamed(context, '/editprofile');
                      },
                      child: Text("Edit",
                          style: TextStyle(
                              color: Color.fromRGBO(242, 87, 35, 1),
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
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
                      style: TextStyle(
                          color: Color.fromRGBO(242, 87, 35, 1), fontSize: 16),
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
