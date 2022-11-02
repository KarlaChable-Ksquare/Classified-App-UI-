import 'package:flutter/material.dart';

class MyAdsScreenCard extends StatelessWidget {
  String id;
  String title;
  int price;
  String createdBy;
  String createdAt;
  String mobile;
  String description;
  String images;
  List<String> imagesAll;

  MyAdsScreenCard({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.createdBy,
    required this.createdAt,
    required this.mobile,
    required this.description,
    required this.images,
    required this.imagesAll,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/editad', arguments: {
          'id': id,
          'title': title,
          "price": price.toString(),
          'createdBy': createdBy,
          'createdAt': createdAt,
          'mobile': mobile,
          'description': description,
          'images': images,
          'imagesAll': imagesAll,
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade500,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
        height: 112,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Container(
                width: 96,
                color: Colors.white,
                child: Image.network(images, fit: BoxFit.cover),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12,
                      ),
                      Text(
                        createdAt,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '\$ ${price.toString()}',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 129, 58, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
