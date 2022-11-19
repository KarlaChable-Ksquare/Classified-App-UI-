import 'package:flutter/material.dart';

class Columns {
  addPhoto() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(
          Icons.add_a_photo_outlined,
          size: 40,
        ),
        SizedBox(
          height: 4,
        ),
        Text("Tap to upload")
      ],
    );
  }
}
