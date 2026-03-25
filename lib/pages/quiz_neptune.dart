import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'button0_charac.dart';
import 'title.dart';
import 'q_achievement.dart';
import 'q_mission-failed.dart';

class QuizGame_Neptune extends StatefulWidget {
  const QuizGame_Neptune({super.key});

  @override
  State<QuizGame_Neptune> createState() => _QuizGame_NeptuneState();
}

enum direction { UP, DOWN }

class _QuizGame_NeptuneState extends State<QuizGame_Neptune> {
  // position of player in x coordinate
  double playerX = 0;

  // laser initial x coordinate and height (size)
  double laserX = 0;
  double laserHeight = 20;

  // for repeated shot
  bool midShot = false;

  // pause state
  bool isPaused = false;

  // lives variable <3
  int lives = 3;

  // Quiz questions
  int currentQuestion = 0;
  String feedback = '';

  final List<Map<String, dynamic>> quiz = [
    {
      'question': 'Neptune Question 1',
      'answers': ['x', 'yes', 'x'],
      'correct': 1
    },
    {
      'question': 'Neptune Question 2',
      'answers': ['x', 'x', 'yes'],
      'correct': 2
    },
    {
      'question': 'Neptune Question 3',
      'answers': ['yes', 'x', 'x'],
      'correct': 0
    },
    {
      'question': 'Neptune Question 4',
      'answers': ['x', 'yes', 'x'],
      'correct': 1
    },
    {
      'question': 'Neptune Question 5',
      'answers': ['x', 'x', 'yes'],
      'correct': 2
    },
    {
      'question': 'Neptune Question 6',
      'answers': ['yes', 'x', 'x'],
      'correct': 0
    },
    {
      'question': 'Neptune Question 7',
      'answers': ['x', 'yes', 'x'],
      'correct': 1
    },
    {
      'question': 'Neptune Question 8',
      'answers': ['x', 'x', 'yes'],
      'correct': 2
    },
    {
      'question': 'Neptune Question 9',
      'answers': ['yes', 'x', 'x'],
      'correct': 0
    },
    {
      'question': 'Neptune Question 10',
      'answers': ['x', 'yes', 'x'],
      'correct': 1
    },
  ];

  // Asteroids
  List<double> asteroidX = [-0.58, 0, 0.58];
  List<double> asteroidY = [-0.7, -0.7, -0.7];
  List<direction> asteroidFloat = [
    direction.UP,
    direction.DOWN,
    direction.UP
  ];

  late Timer gameTimer;

  @override
  void initState() {
    super.initState();
    startQuizGame();
  }

  // to stop the animation timer, the widget will be disposed when the game finishes, preventing memory leaks
  @override
  void dispose() {
    gameTimer.cancel();
    super.dispose();
  }

  void startQuizGame() {
    gameTimer = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        if (isPaused) return; // stop updates while paused

        setState(() {
          // Logic for all 3 asteroids movement
          for (int i = 0; i < 3; i++) {
            if (asteroidY[i] - 0.2 < -1) {
              asteroidFloat[i] = direction.DOWN;
            } else if (asteroidY[i] + 0.2 > 1) {
              asteroidFloat[i] = direction.UP;
            }

            if (asteroidFloat[i] == direction.UP) {
              asteroidY[i] -= 0.08;
            } else {
              asteroidY[i] += 0.08;
            }
          }
        });
      },
    );
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

    Timer.periodic(
      const Duration(milliseconds: 10),
      (timer) {
        // laser shoots until it hits the top of the screen
        setState(() {
          laserHeight += 20;
        });

        double maxHeight = MediaQuery.of(context).size.height * 3 / 4;

        // when laser reaches to the top, it resets
        if (laserHeight > maxHeight) {
          resetLaser();
          timer.cancel();
          midShot = false;
        }

        // check if laser has hit the 3 asteroids
        for (int i = 0; i < 3; i++) {
          if (asteroidY[i] > heightToCoordinate(laserHeight) &&
              (asteroidX[i] - laserX).abs() < 0.3) {
            asteroidY[i] = -50;
            checkAnswer(i);
          }
        }
      },
    );
  }

  double heightToCoordinate(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
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

  // for checking answers
  void checkAnswer(int answerIndex) {
    int correctIndex = quiz[currentQuestion]["correct"];
    if (answerIndex == correctIndex) {
      setState(() {
        feedback = "Correct!";
      });
      Future.delayed(
        const Duration(seconds: 1),
        () {
          if (!mounted) return;
          setState(() {
            if (currentQuestion < quiz.length - 1) {
              currentQuestion++;
              resetAsteroids();
              feedback = '';
            } else {
              // go to achievement page when all questions are answered
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AchievementPage(
                    star: 500,
                    planet: 'neptune',
                  ),
                ),
              );
            }
          });
        },
      );
    } else {
      setState(() {
        feedback = "Incorrect!";
        lives--;
      });
      if (lives <= 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MissionFailedPage(),
          ),
        );
      }
    }
  }

  Widget buildLives(double screenWidth) {
    return Row(
      children: List.generate(
        lives,
        (index) => Icon(
          Icons.favorite,
          color: Colors.pink[100],
          size: screenWidth * 0.04,
        ),
      ),
    );
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
        // Pause button
        actions: [
          GestureDetector(
            onTap: () => setState(() => isPaused = true),
            child: Container(
              width: screenWidth * 0.08,
              height: screenWidth * 0.08,
              margin: EdgeInsets.only(
                right: screenWidth * 0.05,
                top: screenHeight * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade800,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.lightBlue),
              ),
              child: Icon(
                Icons.pause,
                color: Colors.white,
                size: screenWidth * 0.06,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // container of spaceship, asteroids, and laser
              Expanded(
                flex: 3,
                child: Center(
                  child: Stack(
                    children: [
                      for (int i = 0; i < 3; i++)
                        AsteroidChoice(
                          asteroidX: asteroidX[i],
                          asteroidY: asteroidY[i],
                          asteroidColor: i == 1
                              ? const Color.fromARGB(255, 63, 61, 61)
                              : i == 2
                                  ? const Color.fromARGB(255, 103, 103, 103)
                                  : Colors.grey,
                          answerIndex: i,
                          currentQuestion: currentQuestion,
                          quiz: quiz,
                        ),
                      // Laser animation
                      AnimatedAlign(
                        alignment: Alignment(laserX, 1),
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                          width: screenWidth * 0.002,
                          height: laserHeight,
                          color: Colors.lightBlue,
                        ),
                      ),
                      // Spaceship (player)
                      AnimatedAlign(
                        alignment: Alignment(playerX, 1),
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.fastOutSlowIn,
                        child: Image.asset(
                          'images/spaceship.png',
                          width: screenWidth * 0.04,
                          height: screenHeight * 0.16,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()), // spacing for question
            ],
          ),
          // Navigation buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScreenButton_LeftRight(functionLeftRight: moveLeft),
                ScreenButton_Middle(functionMiddle: moveMiddle),
                ScreenButton_LeftRight(functionLeftRight: moveRight),
              ],
            ),
          ),
          // Shoot button
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(
                bottom: screenHeight * 0.20,
                right: screenWidth * 0.12,
              ),
              child: ShootButton(functionLaser: fireLaser),
            ),
          ),
          // Question container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth * 0.85,
              height: screenHeight * 0.15,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF0B2243),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.lightBlue),
              ),
              child: Center(
                child: Text(
                  feedback.isEmpty
                      ? quiz[currentQuestion]['question']
                      : feedback,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenHeight * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // Lives display
          Positioned(
            bottom: screenHeight * 0.15,
            left: screenWidth * 0.1,
            child: buildLives(screenWidth),
          ),
          if (isPaused)
            PauseMenu(
              onResume: () => setState(() => isPaused = false),
            ),
        ],
      ),
    );
  }
}

// screen button to move the spaceship/player in the middle
class ScreenButton_Middle extends StatelessWidget {
  final VoidCallback? functionMiddle;
  const ScreenButton_Middle({super.key, this.functionMiddle});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: functionMiddle,
      child: Container(color: Colors.transparent, width: 120),
    );
  }
}

// screen button to move the spaceship/player to left & right sides
class ScreenButton_LeftRight extends StatelessWidget {
  final VoidCallback? functionLeftRight;
  const ScreenButton_LeftRight({super.key, this.functionLeftRight});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: functionLeftRight,
      child: Container(
        color: Colors.transparent,
        width: screenWidth * 0.3,
      ),
    );
  }
}

// shoot button
class ShootButton extends StatelessWidget {
  final VoidCallback? functionLaser;
  const ShootButton({super.key, this.functionLaser});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: functionLaser,
      child: Container(
        alignment: Alignment.center,
        width: screenWidth * 0.15,
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade800,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.lightBlue, width: 1),
        ),
        child: const Text(
          '+',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// look of asteroid choices with answers inside the circle containers
class AsteroidChoice extends StatelessWidget {
  final double asteroidX, asteroidY;
  final Color asteroidColor;
  final int answerIndex, currentQuestion;
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
      margin: const EdgeInsets.symmetric(horizontal: 190),
      alignment: Alignment(asteroidX, asteroidY),
      child: Container(
        width: screenWidth * 0.10,
        height: screenWidth * 0.10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: asteroidColor,
        ),
        child: Center(
          child: Text(
            quiz[currentQuestion]['answers'][answerIndex],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenHeight * 0.05,
            ),
          ),
        ),
      ),
    );
  }
}

// pause button menu
class PauseMenu extends StatelessWidget {
  final VoidCallback onResume;
  const PauseMenu({super.key, required this.onResume});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // The Blurred Background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Center(
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: scale.clamp(0.0, 1.0),
                  child: child,
                ),
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
                  const Text(
                    'PAUSED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 35),
                  // resume
                  _menuButton(context, 'RESUME', onTap: onResume),
                  const SizedBox(height: 18),
                  // customization
                  _menuButton(
                    context,
                    'CUSTOMIZATION',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CharacCustPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 18),
                  // exit to title screen (title.dart)
                  _menuButton(
                    context,
                    'EXIT TO MAIN MENU',
                    isExit: true,
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TitlePage(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _menuButton(
    BuildContext context,
    String label, {
    required VoidCallback onTap,
    bool isExit = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF15152D),
          side: BorderSide(
            color: isExit ? Colors.redAccent : Colors.cyan,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isExit ? Colors.redAccent : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}