import 'package:flutter/material.dart';

class ButtonCustom {
  elevButton() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xfff25723),
      shape: const BeveledRectangleBorder(),
    );
  }

  floatButton(context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/createad');
      },
      backgroundColor: const Color(0xfff25723),
      elevation: 8,
      child: const Icon(
        Icons.add_a_photo_outlined,
      ),
    );
  }

  backSetting(context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/settings');
        },
        icon: Icon(Icons.arrow_back));
  }

  backHome(context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        icon: Icon(Icons.arrow_back));
  }
}
