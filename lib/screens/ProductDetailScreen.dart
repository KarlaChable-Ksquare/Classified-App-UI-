import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailScreen extends StatefulWidget {
  dynamic data;
  ProductDetailScreen({super.key, required this.data});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  _openURL(url) async {
    url = Uri.parse(url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Error");
    }
  }

  showCustomSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Color.fromRGBO(242, 87, 35, 1),
      content: Text("${widget.data['authorName']}"),
      action: SnackBarAction(
        label: "${widget.data['mobile']}",
        textColor: Colors.black,
        onPressed: () {
          _openURL("sms: ${widget.data['mobile']}");
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    String createAt = widget.data['createdAt'];
    int calculateTime(String createAt) {
      int currentYear = 2022;
      int createAtYear = DateTime.parse(createAt).year;
      int timeAgo = currentYear - createAtYear;
      return timeAgo;
    }

    String pictureRender() {
      if (widget.data['images'][0].isEmpty) {
        return "https://i.ibb.co/wN7ZCYb/gweenpool.jpg";
      } else {
        return widget.data['images'][0];
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Product Detail"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 64,
                          child: Text(
                            "${widget.data['title']}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "\$ ${widget.data['price']}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(239, 152, 21, 1),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          child: SizedBox(
                            height: 232,
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/imageviewer',
                                    arguments: {
                                      'images': widget.data['images'],
                                    });
                              },
                              child: Image.network(
                                pictureRender(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                    "https://i.ibb.co/CbJyRbH/Lilie.jpg",
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                              // child: FadeInImage(
                              //   placeholder: NetworkImage(
                              //       'https://i.ibb.co/CbJyRbH/Lilie.jpg'),
                              //   image: NetworkImage(
                              //       "${widget.data['images'][0]}" ?? ""),
                              //   imageErrorBuilder:
                              //       (context, error, stackTrace) {
                              //     return Image.asset(
                              //       'images/gween.jpg',
                              //       height: double.infinity,
                              //       fit: BoxFit.cover,
                              //     );
                              //   },
                              // ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.person_outline),
                                  Text("- All"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.access_time),
                                  Text(
                                      "-${calculateTime(createAt).toString()} - year ago")
                                  //Text("-${DateTime.parse(widget.data['createdAt']).year}")
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "${widget.data['description']}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              height: 1.4,
                            ),
                            strutStyle: StrutStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xfff25723),
                                shape: BeveledRectangleBorder(),
                              ),
                              onPressed: () {
                                showCustomSnackBar();
                              },
                              child: Text("Contact Seller",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
