import 'package:flutter/material.dart';

class MyAdsScreenCard extends StatelessWidget {
  String id;
  String title;
  String description;
  num price;
  List<String> images;
  String authorName;
  String userId;
  String mobile;
  String createdAt;

  MyAdsScreenCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.authorName,
    required this.userId,
    required this.mobile,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    String createAt = createdAt;
    int calculateTime(String createAt) {
      final currentDate = DateTime.now();
      final createAtDate = DateTime.parse(createAt);
      final diff = currentDate.difference(createAtDate);
      return diff.inDays;
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/editad', arguments: {
          'id': id,
          'title': title,
          "price": price.toString(),
          'authorName': authorName,
          'createdAt': createdAt,
          'mobile': mobile,
          'description': description,
          'images': images,
        });
      },
      child: Column(
        children: [
          Container(
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
                    child: Image.network(images[0], fit: BoxFit.cover),
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
                            "-${calculateTime(createAt).toString()} - Days ago",
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
        ],
      ),
    );
  }
}
