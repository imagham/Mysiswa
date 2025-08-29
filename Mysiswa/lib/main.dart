import 'package:flutter/material.dart';
import 'package:flutter_dasar/login_page/home.dart';
import 'package:flutter_dasar/login_page/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Lottie.asset("assets/loading.json"),
            ),
          ],
        ),
        nextScreen: homepage1(username: AutofillHints.username,),
        splashIconSize: 100,
        backgroundColor: Colors.white,
      ),
    );
  }
}
