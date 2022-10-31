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
                        Text(
                          "${widget.data['title']}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${widget.data['price']}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(242, 87, 35, 1),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Color.fromARGB(160, 242, 87, 35),
                          child: SizedBox(
                            height: 215,
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/imageviewer',
                                    arguments: {
                                      'imagesAll': widget.data['imagesAll']
                                    });
                              },
                              child: Image.network(
                                "${widget.data['images']}",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.people),
                                  Text("- All"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.lock_clock),
                                  Text("- ${widget.data['createdAt']}")
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          //height: 70,
                          width: double.infinity,
                          child: Text(
                            "${widget.data['description']}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            strutStyle: StrutStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(242, 87, 35, 1),
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
