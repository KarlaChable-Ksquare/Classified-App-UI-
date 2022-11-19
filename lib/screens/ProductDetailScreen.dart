import 'package:flutter/material.dart';
import 'package:practice_navigation/customs/buttonCustom.dart';
import 'package:practice_navigation/customs/rows.dart';
import 'package:practice_navigation/customs/textStyles.dart';
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
      duration: const Duration(seconds: 2),
      backgroundColor: const Color.fromRGBO(242, 87, 35, 1),
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
      final currentDate = DateTime.now();
      final createAtDate = DateTime.parse(createAt);
      final diff = currentDate.difference(createAtDate);
      return diff.inDays;
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
          title: const Text("Product Detail"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 64,
                          child: Text(
                            "${widget.data['title']}",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 28,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "\$ ${widget.data['price']}",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(239, 152, 21, 1),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
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
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Rows().detailAll(),
                            const SizedBox(
                              width: 24,
                            ),
                            Rows().detailTime(
                                "-${calculateTime(createAt).toString()} - Days ago"),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "${widget.data['description']}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ButtonCustom().elevButton(),
                              onPressed: () {
                                showCustomSnackBar();
                              },
                              child: TextStyles().contactSeller()),
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
