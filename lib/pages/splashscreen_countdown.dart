import 'dart:async';

import 'package:flutter/material.dart';
import 'quiz_earth.dart';
import 'quiz_jupiter.dart';
import 'quiz_mars.dart';
import 'quiz_mercury.dart';
import 'quiz_neptune.dart';
import 'quiz_saturn.dart';
import 'quiz_sun.dart';
import 'quiz_uranus.dart';
import 'quiz_venus.dart';

class SplashScreen_Countdown extends StatefulWidget {
  final String planet;

  const SplashScreen_Countdown({super.key, required this.planet});

  @override
  _SplashScreen_CountdownState createState() => _SplashScreen_CountdownState();
}

class _SplashScreen_CountdownState extends State<SplashScreen_Countdown> {

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

        Widget quizPage;
        switch (widget.planet.toLowerCase()) {
          case 'mercury':
            quizPage = const QuizGame_Mercury();
            break;
          case 'venus':
            quizPage = const QuizGame_Venus();
            break;
          case 'mars':
            quizPage = const QuizGame_Mars();
            break;
          case 'jupiter':
            quizPage = const QuizGame_Jupiter();
            break;
          case 'saturn':
            quizPage = const QuizGame_Saturn();
            break;
          case 'uranus':
            quizPage = const QuizGame_Uranus();
            break;
          case 'neptune':
            quizPage = const QuizGame_Neptune();
            break;
          case 'sun':
            quizPage = const QuizGame_Sun();
            break;
          case 'earth':
            quizPage = const QuizGame_Earth();
            break;
          default:
            quizPage = const QuizGame_Sun(); // Default, which should not happen since all planet name is passed from button1_mainmenu.dart
            break;
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => quizPage,
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