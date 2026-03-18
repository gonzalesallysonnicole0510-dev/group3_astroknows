import 'dart:async';

import 'package:flutter/material.dart';
import 'quiz_mercury.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  int countdown = 3;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {

      setState(() {
        countdown--;
      });

      if (countdown == 0) {
        timer.cancel();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizGame_Mercury(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          '$countdown',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
