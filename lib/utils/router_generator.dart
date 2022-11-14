import 'package:flutter/material.dart';
import 'package:practice_navigation/screens/CreateAdScreen.dart';
import 'package:practice_navigation/screens/EditAdScreen.dart';
import 'package:practice_navigation/screens/EditProfileScreen.dart';
import 'package:practice_navigation/screens/HomeScreen.dart';
import 'package:practice_navigation/screens/ImageViewerScreen.dart';
import 'package:practice_navigation/screens/LoginScreen.dart';
import 'package:practice_navigation/screens/MyAdsScreen.dart';
import 'package:practice_navigation/screens/ProductDetailScreen.dart';
import 'package:practice_navigation/screens/RegisterScreen.dart';
import 'package:practice_navigation/screens/SettingsScreen.dart';

class RouterGenerator {
  var routerGenerate = ((settings) {
    var routeName = settings.name;
    var args = settings.arguments;
    switch (routeName) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => SafeArea(child: HomeScreen()));

      case '/login':
        return MaterialPageRoute(
            builder: (context) => SafeArea(child: LoginScreen()));

      case '/register':
        return MaterialPageRoute(
            builder: (context) => SafeArea(child: RegisterScreen()));

      case '/settings':
        return MaterialPageRoute(
            builder: (context) => SafeArea(
                    child: SettingScreen(
                  data: args,
                )));

      case '/editprofile':
        return MaterialPageRoute(
            builder: (context) => SafeArea(
                    child: EditProfileScreen(
                  data: args,
                )));

      case '/myads':
        return MaterialPageRoute(
            builder: (context) => SafeArea(child: MyAdsScreen()));

      case '/createad':
        return MaterialPageRoute(
            builder: (context) => SafeArea(child: CreateAdScreen()));

      case '/editad':
        return MaterialPageRoute(
            builder: (context) => SafeArea(
                    child: EditAdScreen(
                  data: args,
                )));

      case '/productdetail':
        return MaterialPageRoute(
            builder: (context) => SafeArea(
                    child: ProductDetailScreen(
                  data: args,
                )));

      case '/imageviewer':
        return MaterialPageRoute(
            builder: (context) => SafeArea(
                    child: ImageViewerScreen(
                  data: args,
                )));
    }
  });
}
