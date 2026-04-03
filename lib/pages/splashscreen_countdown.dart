import 'dart:async';

import 'package:flutter/material.dart';
import 'quiz_QnA.dart';
import 'quiz_game.dart';

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
      if (!mounted) return;

      setState(() {
        countdown--;
      });

      if (countdown == 0) {
        timer.cancel();
        goToQuiz(context, widget.planet);
      }
    });
  }


  void goToQuiz(BuildContext context, String planet) {
    final quizKey = '${planet.toLowerCase()}_quiz';

    final selectedQuiz =
        allQuizzes[quizKey] ?? allQuizzes['earth_quiz']!;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => Quizteroid_Quest(
          quiz: selectedQuiz['questions'],
          planet: selectedQuiz['planet'],
        ),
      ),
    );
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