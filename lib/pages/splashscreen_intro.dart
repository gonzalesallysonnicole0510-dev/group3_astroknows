import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/button0_charac.dart';
import 'title.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen_Intro(),
    );
  }
}


class SplashScreen_Intro extends StatefulWidget {
  const SplashScreen_Intro({super.key});

  @override
  State<SplashScreen_Intro> createState() => _SplashScreenState_Intro();
}

class _SplashScreenState_Intro extends State<SplashScreen_Intro> {

  @override
  void initState() {
    super.initState();

    // Simulate loading then navigate
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TitlePage(astroknowt: selectedAstroknowt)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1925),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              'images/transicon.png',
              width: 120,
              height: 120,
            ),

            const SizedBox(height: 20),

            const Text(
              'ASTROKNOWS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}