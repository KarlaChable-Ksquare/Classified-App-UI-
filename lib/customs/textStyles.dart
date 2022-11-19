import 'package:flutter/material.dart';

class TextStyles {
  anyAcount() {
    return const Text("Don't have any account?",
        style: TextStyle(
            color: Color.fromRGBO(242, 87, 35, 1),
            fontSize: 12,
            fontWeight: FontWeight.bold));
  }

  acountAlready() {
    return const Text("Already have an account?",
        style: TextStyle(
            color: Color.fromRGBO(242, 87, 35, 1),
            fontSize: 12,
            fontWeight: FontWeight.bold));
  }

  logoutAcount() {
    return const Text("Logout",
        style: TextStyle(
            color: Color(0xfff25723),
            fontSize: 15,
            fontWeight: FontWeight.bold));
  }

  dataUserName(userData) {
    return Text(userData,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.bold,
        ));
  }

  dataUserPhone(userData) {
    return Text(userData,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ));
  }

  dataUserEdit() {
    return const Text("Edit",
        style:
            TextStyle(color: Color(0xfff25723), fontWeight: FontWeight.bold));
  }

  captureGallery() {
    return const Text("Capture Gallery", style: TextStyle(color: Colors.white));
  }

  captureCamera() {
    return const Text("Capture  Camera", style: TextStyle(color: Colors.white));
  }

  deleteAdY() {
    return const Text(
      "Yes",
      style: TextStyle(color: Color(0xfff25723), fontWeight: FontWeight.bold),
    );
  }

  deleteAdN() {
    return const Text("No",
        style:
            TextStyle(color: Color(0xfff25723), fontWeight: FontWeight.bold));
  }

  contactSeller() {
    return const Text("Contact Seller",
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold));
  }

  detailTime(time) {
    return Text(
      time,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
    );
  }
}
