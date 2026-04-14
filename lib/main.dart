import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/b-narration.dart';
import 'package:flutter_application_1/pages/b-sfx_manager.dart';
import 'package:flutter_application_1/pages/button3_settings.dart';
import "package:flutter_application_1/pages/splashscreen_intro.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SfxManager.instance.setVolume(sfxLevel);
  await NarrationManager.instance.loadSettings();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Hides status and navigation bars for a full-screen experience

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});                     

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'AstroKnows',
      debugShowCheckedModeBanner: false,
      home: SplashScreenIntro(),
    );
  }
}