import 'package:flutter/material.dart';

class HomeScreenCard extends StatelessWidget {
  String id;
  String title;
  int price;
  String createdBy;
  String createdAt;
  String mobile;
  String description;
  String images;
  List<String> imagesAll;

  HomeScreenCard({
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
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/productdetail', arguments: {
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
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                height: double.infinity,
                width: double.infinity,
                child: Image.network(images, fit: BoxFit.cover),
              ),
              Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
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
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text('\$ ${price.toString()}',
                              style: TextStyle(
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
