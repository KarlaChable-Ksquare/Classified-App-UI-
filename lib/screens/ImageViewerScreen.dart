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
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        child: const Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        alignment: Alignment.center,
        color: Color.fromARGB(255, 0, 0, 0),
        child: CarouselSlider.builder(
          options: CarouselOptions(
            height: 250,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
          ),
          itemCount: widget.data['imagesAll'].length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
            width: double.infinity,
            height: double.infinity,
            color: Color.fromARGB(255, 0, 0, 0),
            child: Container(
              margin: EdgeInsets.all(15),
              child: Image.network(
                widget.data['imagesAll'][itemIndex],
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
