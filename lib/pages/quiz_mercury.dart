import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'title.dart';
import 'button0_charac.dart';
import 'q_achievement.dart';
import 'q_mission-failed.dart';

class QuizGame_Mercury extends StatefulWidget {
  const QuizGame_Mercury({super.key});

  @override
  State<QuizGame_Mercury> createState() => _QuizGame_MercuryState();
}

enum direction { UP, DOWN }

class _QuizGame_MercuryState extends State<QuizGame_Mercury> {
  // Player and laser positions
  double playerX = 0;
  double laserX = 0;
  double laserHeight = 20;
  bool midShot = false;

  // Lives
  int lives = 3;
  Widget buildLives(double screenWidth) {
    return Row(
      children: List.generate(
        lives,
        (index) => Icon(Icons.favorite, color: Colors.pink[100], size: screenWidth * 0.05),
      ),
    );
  }

  // Quiz questions
  int currentQuestion = 0;
  String feedback = '';
  List<Map<String, dynamic>> quiz = [
    {'question': 'Mercury Question 1', 'answers': ['x', 'yes', 'x'], 'correct': 1},
    {'question': 'Mercury Question 2', 'answers': ['x', 'x', 'yes'], 'correct': 2},
    {'question': 'Mercury Question 3', 'answers': ['yes', 'x', 'x'], 'correct': 0},
    {'question': 'Mercury Question 4', 'answers': ['x', 'yes', 'x'], 'correct': 1},
    {'question': 'Mercury Question 5', 'answers': ['x', 'x', 'yes'], 'correct': 2},
    {'question': 'Mercury Question 6', 'answers': ['yes', 'x', 'x'], 'correct': 0},
    {'question': 'Mercury Question 7', 'answers': ['x', 'yes', 'x'], 'correct': 1},
    {'question': 'Mercury Question 8', 'answers': ['x', 'x', 'yes'], 'correct': 2},
    {'question': 'Mercury Question 9', 'answers': ['yes', 'x', 'x'], 'correct': 0},
    {'question': 'Mercury Question 10', 'answers': ['x', 'yes', 'x'], 'correct': 1},
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
                context, MaterialPageRoute(builder: (_) => const AchievementPage()));
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
            context, MaterialPageRoute(builder: (_) => const MissionFailedPage()));
      }
    }
  }

  // Asteroids
  List<double> asteroidX = [-0.58, 0, 0.58];
  List<double> asteroidY = [-0.7, -0.5, -0.6];
  List<direction> asteroidFloat = [direction.UP, direction.DOWN, direction.UP];

  late Timer gameTimer;
  bool isPaused = false; // PAUSE STATE

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
      if (isPaused) return; // stop updates while paused

      for (int i = 0; i < 3; i++) {
        if (asteroidY[i] < -1) asteroidFloat[i] = direction.DOWN;
        if (asteroidY[i] > 1) asteroidFloat[i] = direction.UP;

        setState(() {
          asteroidY[i] += asteroidFloat[i] == direction.UP ? -0.02 : 0.02; // slow smooth float
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
    asteroidY = [-0.7, -0.5, -0.6];
    asteroidFloat = [direction.UP, direction.DOWN, direction.UP];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () => setState(() => isPaused = true),
            child: Container(
              width: screenWidth * 0.08,
              height: screenWidth * 0.08,
              margin: EdgeInsets.only(right: screenWidth * 0.05, top: screenHeight * 0.01),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade800,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.lightBlue, width: 1),
              ),
              child: Icon(Icons.pause, color: Colors.white, size: screenWidth * 0.06),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Spaceship & asteroids
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                  color: Colors.transparent,
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
                          child: Container(width: screenWidth * 0.002, height: laserHeight, color: Colors.lightBlue),
                        ),
                        AnimatedAlign(
                          alignment: Alignment(playerX, 1),
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.fastOutSlowIn,
                          child: Container(
                            width: screenWidth * 0.06,
                            height: screenHeight * 0.08,
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
              ),
              Expanded(child: Container(color: Colors.transparent)),
            ],
          ),
          // Navigation buttons
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
              margin: EdgeInsets.only(bottom: screenHeight * 0.15, right: screenWidth * 0.25),
              child: ShootButton(functionLaser: fireLaser),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth * 0.85,
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 11, 34, 67),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.lightBlue),
              ),
              child: Center(
                child: Text(
                  feedback.isEmpty ? quiz[currentQuestion]['question'] : feedback,
                  style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.025),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(bottom: screenHeight * 0.1, left: screenWidth * 0.1, child: buildLives(screenWidth)),
          if (isPaused)
            PauseMenu(
              onResume: () => setState(() => isPaused = false),
            ),
        ],
      ),
    );
  }
}

// Screen buttons
class ScreenButton extends StatelessWidget {
  final VoidCallback? function;
  const ScreenButton({super.key, this.function});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: function,
      child: Container(
        color: Colors.transparent,
        width: screenWidth * 0.3,
        height: screenHeight * 0.1,
      ),
    );
  }
}

// Shoot button
class ShootButton extends StatelessWidget {
  final VoidCallback? functionLaser;
  const ShootButton({super.key, this.functionLaser});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: functionLaser,
      child: Container(
        alignment: Alignment.center,
        width: screenWidth * 0.08,
        height: screenWidth * 0.08,
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

// Asteroid choice
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment(asteroidX, asteroidY),
      child: Container(
        width: screenWidth * 0.12,
        height: screenWidth * 0.12,
        decoration: BoxDecoration(shape: BoxShape.circle, color: asteroidColor),
        child: Center(
          child: Text(
            quiz[currentQuestion]['answers'][answerIndex],
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.018),
          ),
        ),
      ),
    );
  }
}

// Pause Menu Widget
class PauseMenu extends StatelessWidget {
  final VoidCallback onResume;
  const PauseMenu({super.key, required this.onResume});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(color: Colors.black.withOpacity(0.5)),
        ),
        Center(
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale,
                child: Opacity(opacity: scale, child: child),
              );
            },
            child: Container(
              width: screenWidth * 0.45,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1B35).withOpacity(0.95),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.cyanAccent.withOpacity(0.8), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('PAUSED',
                      style: TextStyle(
                          fontFamily: 'Michroma',
                          color: Colors.white,
                          fontSize: 26,
                          letterSpacing: 4,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 35),
                  _menuButton(context, 'RESUME', onTap: onResume),
                  const SizedBox(height: 18),
                  _menuButton(context, 'CUSTOMIZATION', onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => const CharacCustPage()));
                  }),
                  const SizedBox(height: 18),
                  _menuButton(context, 'EXIT TO MAIN MENU', isExit: true, onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const TitlePage()),
                      (route) => false,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _menuButton(BuildContext context, String label,
      {required VoidCallback onTap, bool isExit = false}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF15152D),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: isExit ? Colors.redAccent.withOpacity(0.7) : Colors.cyan.withOpacity(0.7),
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Exo 2',
            color: isExit ? Colors.redAccent : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}