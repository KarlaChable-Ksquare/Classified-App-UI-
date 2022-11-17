import 'package:flutter/material.dart';

class CirculatorManager {
  circleUpdate() {
    return Center(
      child: SizedBox(
          child: CircularProgressIndicator(
              backgroundColor: Colors.black, color: Color(0xfff25723))),
    );
  }

  /*
  Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        color: Color(0xfff25723)))
  */

  formUpdate() {
    return SizedBox(
      height: 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircularProgressIndicator(
              backgroundColor: Colors.white, color: Colors.black),
          Text('Please Wait')
        ],
      ),
    );
  }
}
