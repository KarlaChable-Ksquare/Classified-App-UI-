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
      content: Text("${widget.data['createdBy']}"),
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
                                      'imagesAll': widget.data['imagesAll'],
                                    });
                              },
                              child: Image.network(
                                "${widget.data['images']}",
                                fit: BoxFit.cover,
                              ),
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
                                  Text("- ${widget.data['createdAt']}")
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
