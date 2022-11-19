import 'package:flutter/material.dart';

class CirculatorManager {
  circleUpdate() {
    return const Center(
      child: SizedBox(
          child: CircularProgressIndicator(
              backgroundColor: Colors.black, color: Color(0xfff25723))),
    );
  }

  formUpdate() {
    return SizedBox(
      height: 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          CircularProgressIndicator(
              backgroundColor: Colors.white, color: Colors.black),
          Text('Please Wait')
        ],
      ),
    );
  }

  isLoadingLogin(isLoading) {
    return isLoading
        ? CirculatorManager().formUpdate()
        : const Text("Login",
            style: TextStyle(color: Colors.white, fontSize: 16));
  }

  isLoadingRegister(isLoading) {
    return isLoading
        ? CirculatorManager().formUpdate()
        : const Text("Register Now",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold));
  }

  isLoadingProfile(isLoading) {
    return isLoading
        ? CirculatorManager().formUpdate()
        : const Text("Update Profile",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold));
  }

  isLoadingAd(isLoading) {
    return isLoading
        ? CirculatorManager().formUpdate()
        : const Text("Submit Ad",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold));
  }

  isLoadingNewAd(isLoading) {
    return isLoading
        ? CirculatorManager().formUpdate()
        : const Text("Submit Ad",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold));
  }

  isLoadingDeleteAd(isLoading) {
    return isLoading
        ? CirculatorManager().formUpdate()
        : const Text("Yes",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold));
  }
}
