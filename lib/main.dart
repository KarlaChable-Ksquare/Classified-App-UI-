import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:practice_navigation/router_generator.dart';
import 'package:practice_navigation/screens/HomeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: HomeScreen()),
      initialRoute: '/login',
      onGenerateRoute: RouterGenerator().routerGenerate,
    );
  }
}
