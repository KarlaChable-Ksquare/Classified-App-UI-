import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:practice_navigation/utils/alert_manager.dart';
import 'package:practice_navigation/services/myuser.dart';
import 'package:practice_navigation/customs/rows.dart';
import 'package:practice_navigation/customs/textStyles.dart';
import 'package:practice_navigation/customs/circulatorManager.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
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
      //print("Error _OpenURL");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Setting Screen"),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
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
                      padding: const EdgeInsets.fromLTRB(0, 4, 24, 28),
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
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextStyles().dataUserName(userData['name']),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  TextStyles()
                                      .dataUserPhone(userData['mobile']),
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
                              child: TextStyles().dataUserEdit()),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    //print(snapshot.hasError);
                    AlertManager().errorMessage();
                  }
                  return CirculatorManager().circleUpdate();
                })),
            Row(
              children: [
                Icon(
                  Icons.ads_click,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 28),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/myads');
                    },
                    child: const Text(
                      "My Ads",
                      style: TextStyle(color: Color(0xfff25723), fontSize: 16),
                    )),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Rows().aboutUs(_openURL),
            const SizedBox(
              height: 12,
            ),
            Rows().contactUs(_openURL)
          ],
        ),
      ),
    );
  }
}
