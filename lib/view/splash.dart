import 'package:navin_project/Utils/media_urls.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 8), () {});
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => OnBoarding()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.15,
              width: width,
              child: Image.asset("assets/images/logo.png"),
            ),
            SizedBox(height: 20),
            Text(
              "Bark Board",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
