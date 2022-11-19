import 'package:flutter/material.dart';

class Rows {
  aboutUs(openURL) {
    return Row(
      children: [
        Icon(
          Icons.contact_page,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 28),
        TextButton(
            onPressed: () {
              openURL("https://appmaking.com/contact");
            },
            child: Text("Contact Us",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16)))
      ],
    );
  }

  contactUs(openURL) {
    return Row(
      children: [
        Icon(
          Icons.contact_page,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 28),
        TextButton(
            onPressed: () {
              openURL("https://appmaking.com/contact");
            },
            child: Text("Contact Us",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16)))
      ],
    );
  }

  detailAll() {
    return Row(
      children: const [
        Icon(Icons.person_outline),
        Text("- All"),
      ],
    );
  }

  detailTime(time) {
    return Row(
      children: [const Icon(Icons.access_time), Text(time)],
    );
  }
}
