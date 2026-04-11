import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/button0_charac.dart';
import 'package:flutter_application_1/pages/q_timer_lives.dart';
import 'package:flutter_application_1/pages/q_timer_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz_QnA.dart';
import 'quiz_game.dart';

class SplashScreen_Countdown extends StatefulWidget {
  final String planet;
  final int level;

  const SplashScreen_Countdown({super.key, required this.planet, required this.level});

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
        goToQuiz(context, widget.planet, widget.level);
      }
    });
  }

  void goToQuiz(BuildContext context, String planet, int level) async {
    final hearts = await LivesTimerService.getHearts();
    final remaining = await LivesTimerService.getRemainingTime();

    // If user bought extra lives (hearts), it will skip timer
    if (hearts > 0) {
      remaining == 0; // ignore timer
    }

    // Block screen if no more lives
    if (hearts <= 0 && remaining > 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LivesTimerPage(
            onFinished: () {
              // after timer, go back to quiz
              goToQuiz(context, planet, level);
            },
          ),
        ),
      );
      return;
    }

    // Go to Quizteroid Quest
    final quizKey = '${planet.toLowerCase()}_quiz';

    final selectedQuiz =
        allQuizzes[quizKey] ?? allQuizzes['sun_quiz']!;

    String levelKey;

    switch (level) {
      case 1:
        levelKey = 'basic';
        break;
      case 2:
        levelKey = 'intermediate';
        break;
      case 3:
        levelKey = 'advanced';
        break;
      default:
        levelKey = 'basic';
    }

    final quizList =
        selectedQuiz['levels'][levelKey] ??
        selectedQuiz['levels']['basic'];

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => Quizteroid_Quest(
          quiz: quizList,
          planet: selectedQuiz['planet'],
          astroknowt: selectedAstroknowt,
          spaceship: selectedSpaceship,
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