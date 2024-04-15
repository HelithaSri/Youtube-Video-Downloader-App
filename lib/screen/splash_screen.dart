import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yt_download_app/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a delay and navigate to the next screen
    Timer(
      const Duration(seconds: 5), // Adjust the duration as needed
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(27, 30, 50, 1),
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ytb.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
                opacity: 0.5,
              ),
            ),
            child: Image.asset(
              "assets/images/yt.png",
              alignment: Alignment.center,
              scale: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
