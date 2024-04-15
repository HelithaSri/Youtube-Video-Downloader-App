// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us".toUpperCase()),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        backgroundColor: const Color.fromRGBO(27, 30, 50, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context); // This will pop the current screen off the navigation stack
          },
        ),
      ),
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
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to YT-Downloader, the easiest way to download YouTube videos. We are committed to offering a seamless experience that allows you to watch your favorite videos offline whenever and wherever you choose. Join us and enjoy a world of limitless entertainment options with just a few clicks!",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                    overflow: TextOverflow.clip,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "1.1.0v",
                  style: TextStyle(
                    color: Colors.white,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
