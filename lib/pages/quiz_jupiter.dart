import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'q_achievement.dart';
import 'q_mission-failed.dart';

class QuizGame_Jupiter extends StatefulWidget {
  const QuizGame_Jupiter({super.key});

  @override
  State<QuizGame_Jupiter> createState() => _QuizGame_JupiterState();
}

enum direction { UP, DOWN }

class _QuizGame_JupiterState extends State<QuizGame_Jupiter> {
  // Player and laser
  double playerX = 0;
  double laserX = 0;
  double laserHeight = 20;
  bool midShot = false;

  // Pause state
  bool isPaused = false;

  // Lives
  int lives = 3;
  Widget buildLives() {
    return Row(
      children: List.generate(
        lives,
        (index) => Icon(Icons.favorite, color: Colors.pink[100]),
      ),
    );
  }

  // Quiz questions
  int currentQuestion = 0;
  String feedback = '';
  List<Map<String, dynamic>> quiz = [
    {'question': 'Jupiter Question 1', 'answers': ['x', 'yes', 'x'], 'correct': 1},
    {'question': 'Jupiter Question 2', 'answers': ['x', 'x', 'yes'], 'correct': 2},
    {'question': 'Jupiter Question 3', 'answers': ['yes', 'x', 'x'], 'correct': 0},
    {'question': 'Jupiter Question 4', 'answers': ['x', 'yes', 'x'], 'correct': 1},
    {'question': 'Jupiter Question 5', 'answers': ['x', 'x', 'yes'], 'correct': 2},
    {'question': 'Jupiter Question 6', 'answers': ['yes', 'x', 'x'], 'correct': 0},
    {'question': 'Jupiter Question 7', 'answers': ['x', 'yes', 'x'], 'correct': 1},
    {'question': 'Jupiter Question 8', 'answers': ['x', 'x', 'yes'], 'correct': 2},
    {'question': 'Jupiter Question 9', 'answers': ['yes', 'x', 'x'], 'correct': 0},
    {'question': 'Jupiter Question 10', 'answers': ['x', 'yes', 'x'], 'correct': 1},
  ];

  void checkAnswer(int answerIndex) {
    int correctIndex = quiz[currentQuestion]["correct"];
    if (answerIndex == correctIndex) {
      setState(() => feedback = "Correct!");
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          if (currentQuestion < quiz.length - 1) {
            currentQuestion++;
            resetAsteroids();
            feedback = '';
          } else {
            currentQuestion = 0;
            resetAsteroids();
            feedback = '';
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => AchievementPage()),
            );
          }
        });
      });
    } else {
      setState(() {
        feedback = "Incorrect!";
        lives--;
      });
      if (lives <= 0) {
        currentQuestion = 0;
        feedback = '';
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MissionFailedPage()),
        );
      }
    }
  }

  // Asteroids
  List<double> asteroidX = [-0.58, 0, 0.58];
  List<double> asteroidY = [-0.7, -0.7, -0.7];
  List<direction> asteroidFloat = [direction.UP, direction.DOWN, direction.UP];

  late Timer gameTimer;

  @override
  void initState() {
    super.initState();
    startQuizGame();
  }

  @override
  void dispose() {
    gameTimer.cancel();
    super.dispose();
  }

  void startQuizGame() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (isPaused) return;

      for (int i = 0; i < 3; i++) {
        if (asteroidY[i] - 0.2 < -1) asteroidFloat[i] = direction.DOWN;
        if (asteroidY[i] + 0.2 > 1) asteroidFloat[i] = direction.UP;
        setState(() {
          asteroidY[i] += asteroidFloat[i] == direction.UP ? -0.05 : 0.05;
        });
      }
    });
  }

  // Player movement
  void moveLeft() {
    setState(() {
      playerX = -0.3;
      if (!midShot) laserX = playerX;
    });
  }

  void moveMiddle() {
    setState(() {
      playerX = 0;
      if (!midShot) laserX = playerX;
    });
  }

  void moveRight() {
    setState(() {
      playerX = 0.3;
      if (!midShot) laserX = playerX;
    });
  }

  void fireLaser() {
    if (midShot || isPaused) return;
    midShot = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() => laserHeight += 20);
      double maxHeight = MediaQuery.of(context).size.height * 2 / 4;
      if (laserHeight > maxHeight) {
        resetLaser();
        timer.cancel();
        midShot = false;
      }
      for (int i = 0; i < 3; i++) {
        if (asteroidY[i] > heightToCoordinate(laserHeight) &&
            (asteroidX[i] - laserX).abs() < 0.35) {
          asteroidY[i] = -50;
          checkAnswer(i);
        }
      }
    });
  }

  double heightToCoordinate(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 2 / 4;
    return 1 - (2 * height / totalHeight);
  }

  void resetLaser() {
    laserX = playerX;
    laserHeight = 20;
  }

  void resetAsteroids() {
    asteroidX = [-0.58, 0, 0.58];
    asteroidY = [-0.7, -0.7, -0.7];
    asteroidFloat = [direction.UP, direction.DOWN, direction.UP];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () => setState(() => isPaused = true),
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 25, top: 5),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade800,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.lightBlue, width: 1),
              ),
              child: const Icon(Icons.pause, color: Colors.white, size: 40),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Stack(
                    children: [
                      AsteroidChoice(
                        asteroidX: asteroidX[0],
                        asteroidY: asteroidY[0],
                        asteroidColor: Colors.grey,
                        answerIndex: 0,
                        currentQuestion: currentQuestion,
                        quiz: quiz,
                      ),
                      AsteroidChoice(
                        asteroidX: asteroidX[1],
                        asteroidY: asteroidY[1],
                        asteroidColor: const Color.fromARGB(255, 63, 61, 61),
                        answerIndex: 1,
                        currentQuestion: currentQuestion,
                        quiz: quiz,
                      ),
                      AsteroidChoice(
                        asteroidX: asteroidX[2],
                        asteroidY: asteroidY[2],
                        asteroidColor: const Color.fromARGB(255, 103, 103, 103),
                        answerIndex: 2,
                        currentQuestion: currentQuestion,
                        quiz: quiz,
                      ),
                      AnimatedAlign(
                        alignment: Alignment(laserX, 1),
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.fastOutSlowIn,
                        child: Container(width: 1, height: laserHeight, color: Colors.lightBlue),
                      ),
                      AnimatedAlign(
                        alignment: Alignment(playerX, 1),
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                          width: 22.5,
                          height: 45,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/spaceship.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScreenButton(function: moveLeft),
                ScreenButton(function: moveMiddle),
                ScreenButton(function: moveRight),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(bottom: 125, right: 100),
              child: ShootButton(functionLaser: fireLaser),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth * 0.9,
              height: 70,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 11, 34, 67),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.lightBlue),
              ),
              child: Center(
                child: Text(
                  feedback.isEmpty ? quiz[currentQuestion]['question'] : feedback,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(bottom: 75, left: 20, child: buildLives()),
          if (isPaused)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: ElevatedButton(
                  onPressed: () => setState(() => isPaused = false),
                  child: const Text('RESUME'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ScreenButton extends StatelessWidget {
  final VoidCallback? function;
  const ScreenButton({super.key, this.function});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(width: 120, height: 80, color: Colors.transparent),
    );
  }
}

class ShootButton extends StatelessWidget {
  final VoidCallback? functionLaser;
  const ShootButton({super.key, this.functionLaser});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: functionLaser,
      child: Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade800,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.lightBlue, width: 1),
        ),
        child: const Text('+', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class AsteroidChoice extends StatelessWidget {
  final double asteroidX;
  final double asteroidY;
  final Color asteroidColor;
  final int answerIndex;
  final int currentQuestion;
  final List<Map<String, dynamic>> quiz;

  const AsteroidChoice({
    super.key,
    required this.asteroidX,
    required this.asteroidY,
    required this.asteroidColor,
    required this.answerIndex,
    required this.currentQuestion,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(asteroidX, asteroidY),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(shape: BoxShape.circle, color: asteroidColor),
        child: Center(
          child: Text(
            quiz[currentQuestion]['answers'][answerIndex],
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ),
    );
  }
}