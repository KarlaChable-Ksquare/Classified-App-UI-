import 'package:flutter/material.dart';

class HomeScreenCard extends StatelessWidget {
  String id;
  String title;
  String description;
  num price;
  List<String> images;
  String authorName;
  String userId;
  String mobile;
  String createdAt;

  HomeScreenCard({
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
    String pictureRender() {
      if (images.isEmpty) {
        return "https://i.ibb.co/wN7ZCYb/gweenpool.jpg";
      } else {
        return images[0];
      }
    }

    return SizedBox(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/productdetail', arguments: {
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
        child: Container(
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                height: double.infinity, //400
                width: double.infinity, //400
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
              Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 64,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text('\$ ${price.toString()}', //.toString()
                              style: const TextStyle(
                                  color: Color.fromRGBO(233, 167, 81, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
