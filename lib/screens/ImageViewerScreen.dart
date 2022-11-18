import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageViewerScreen extends StatefulWidget {
  dynamic data;
  ImageViewerScreen({super.key, required this.data});
  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: CarouselSlider.builder(
          options: CarouselOptions(
            height: 540,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
          ),
          itemCount: widget.data['images'].length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Image.network(
                widget.data['images'][itemIndex],
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
      ),
    );
  }
}
