import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yt_download_app/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const YoutbeApp());
}

class YoutbeApp extends StatelessWidget {
  const YoutbeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
