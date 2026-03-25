import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'button0_charac.dart';
import 'title.dart';
import 'q_achievement.dart';
import 'q_mission-failed.dart';

class QuizGame_Earth extends StatefulWidget {
  const QuizGame_Earth({super.key});

  @override
  State<QuizGame_Earth> createState() => _QuizGame_EarthState();
}

enum AsteroidDirection { up, down }

class _QuizGame_EarthState extends State<QuizGame_Earth> {
  // Movement and game state variables
  double playerX = 0;
  double laserX = 0;
  double laserHeight = 0;
  bool midShot = false;
  bool isPaused = false;
  int lives = 3;

  int currentQuestion = 0;
  String feedback = '';
  Color boxBorderColor = Colors.lightBlueAccent;

  final List<Map<String, dynamic>> quiz = [
    {
      'question': 'Earth Question 1', 
      'answers': ['x', 'yes', 'x'], 
      'correct': 1
    },
    {
      'question': 'Earth Question 2', 
      'answers': ['x', 'x', 'yes'], 
      'correct': 2
    },
    {
      'question': 'Earth Question 3', 
      'answers': ['yes', 'x', 'x'], 
      'correct': 0
    },
    {
      'question': 'Earth Question 4', 
      'answers': ['x', 'yes', 'x'], 
      'correct': 1
    },
    {
      'question': 'Earth Question 5', 
      'answers': ['x', 'x', 'yes'], 
      'correct': 2
    },
    {
      'question': 'Earth Question 6', 
      'answers': ['yes', 'x', 'x'], 
      'correct': 0
    },
    {
      'question': 'Earth Question 7', 
      'answers': ['x', 'yes', 'x'], 
      'correct': 1
    },
    {
      'question': 'Earth Question 8', 
      'answers': ['x', 'x', 'yes'], 
      'correct': 2
    },
    {
      'question': 'Earth Question 9', 
      'answers': ['yes', 'x', 'x'], 
      'correct': 0
    },
    {
      'question': 'Earth Question 10', 
      'answers': ['x', 'yes', 'x'], 
      'correct': 1
    },
  ];

  // Asteroid positions and movement directions
  List<double> asteroidX = [-0.52, 0, 0.52];
  List<double> asteroidY = [-0.6, -0.6, -0.6];
  List<AsteroidDirection> asteroidFloat = [
    AsteroidDirection.up,
    AsteroidDirection.down,
    AsteroidDirection.up
  ];

  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
    startQuizGame();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  void startQuizGame() {
    gameTimer = Timer.periodic(
      const Duration(milliseconds: 50), 
      (timer) {
        if (isPaused || feedback.isNotEmpty || !mounted) return;

        setState(() {
          for (int i = 0; i < 3; i++) {
            if (asteroidY[i] == -50) continue;

            if (asteroidY[i] < -0.8) {
              asteroidFloat[i] = AsteroidDirection.down;
            } else if (asteroidY[i] > 0.1) {
              asteroidFloat[i] = AsteroidDirection.up;
            }

            asteroidY[i] += (asteroidFloat[i] == AsteroidDirection.up) 
                ? -0.03 
                : 0.03;
          }
        });
      },
    );
  }

  // Player movement functions
  void moveLeft() {
    setState(() {
      playerX = -0.52;
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
      playerX = 0.52;
      if (!midShot) laserX = playerX;
    });
  }

  // Shooting function
  void fireLaser() {
    if (midShot || isPaused || feedback.isNotEmpty) return;

    setState(() {
      midShot = true;
      laserX = playerX;
    });

    Timer.periodic(
      const Duration(milliseconds: 15), 
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        setState(() {
          laserHeight += 25;
        });

        double maxHeight = MediaQuery.of(context).size.height;
        if (laserHeight > maxHeight) {
          _stopLaser(timer);
        }

        for (int i = 0; i < 3; i++) {
          double hitPos = heightToCoordinate(
            laserHeight + (maxHeight * 0.1),
          );
          bool isHit = (asteroidX[i] - laserX).abs() < 0.2;

          if (asteroidY[i] != -50 && asteroidY[i] > hitPos && isHit) {
            asteroidY[i] = -50;
            _stopLaser(timer);
            checkAnswer(i);
            break;
          }
        }
      },
    );
  }

  void _stopLaser(Timer t) {
    t.cancel();
    setState(() {
      laserHeight = 0;
      midShot = false;
    });
  }

  double heightToCoordinate(double height) {
    double arenaHeight = MediaQuery.of(context).size.height * 0.7;
    return 1 - (2 * height / arenaHeight);
  }

  // Answer checking and feedback
  void checkAnswer(int index) {
    bool isCorrect = index == quiz[currentQuestion]['correct'];

    setState(() {
      feedback = isCorrect ? "CORRECT!" : "INCORRECT!";
      boxBorderColor = isCorrect ? Colors.greenAccent : Colors.redAccent;
      if (!isCorrect) lives--;
    });

    if (lives <= 0) {
      Future.delayed(
        const Duration(milliseconds: 800), 
        () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const MissionFailedPage(),
              ),
            );
          }
        },
      );
      return;
    }

    // Delay before moving to next question or ending game
    Future.delayed(
      const Duration(seconds: 1), 
      () {
        if (!mounted) return;
        bool isLast = currentQuestion >= quiz.length - 1;

        if (isCorrect && isLast) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const AchievementPage(
                star: 500, 
                planet: 'earth',
              ),
            ),
          );
        } else {
          setState(() {
            if (isCorrect) currentQuestion++;
            feedback = '';
            boxBorderColor = Colors.lightBlueAccent;
            _resetAsteroids();
          });
        }
      },
    );
  }

  void _resetAsteroids() {
    setState(() {
      asteroidY = [-0.6, -0.6, -0.6];
    });
  }

  // Main build method for the quiz game UI
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

  // Calculate rocket size based on screen dimensions
    final double rocketWidth = (sw * 0.20).clamp(60.0, 95.0);
    final double rocketHeight = (sh * 0.15).clamp(60.0, 95.0);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            bottom: sh * 0.2,
            child: Row(
              children: [
                _buildMoveZone(moveLeft),
                _buildMoveZone(moveMiddle),
                _buildMoveZone(moveRight),
              ],
            ),
          ),
          // Asteroids, laser, and player spaceship
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: sh * 0.7,
            child: Stack(
              children: [
                for (int i = 0; i < 3; i++)
                  AsteroidChoice(
                    x: asteroidX[i],
                    y: asteroidY[i],
                    color: i == 1 
                        ? const Color(0xFF3B4043) 
                        : const Color(0xFF5A6064),
                    label: quiz[currentQuestion]['answers'][i],
                    alignWidth: rocketWidth,
                  ),
                // Laser and spaceship
                AnimatedAlign(
                  alignment: Alignment(laserX, 0.72),
                  duration: const Duration(milliseconds: 50),
                  child: SizedBox(
                    width: rocketWidth,
                    child: Center(
                      child: Container(
                        width: 4,
                        height: laserHeight,
                        decoration: BoxDecoration(
                          color: Colors.cyanAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyanAccent.withOpacity(0.8),
                              blurRadius: 10,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Spaceship
                AnimatedAlign(
                  alignment: Alignment(playerX, 0.9),
                  duration: const Duration(milliseconds: 150),
                  child: Image.asset(
                    'images/spaceship.png',
                    width: rocketWidth,
                    height: rocketHeight,
                  ),
                ),
              ],
            ),
          ),
          // Pause button
          Positioned(
            top: (sh * 0.05).clamp(30.0, 60.0),
            right: (sw * 0.05).clamp(15.0, 30.0),
            child: GestureDetector(
              onTap: () => setState(() => isPaused = true),
              child: Container(
                width: (sw * 0.12).clamp(45.0, 60.0),
                height: (sw * 0.12).clamp(45.0, 60.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF131B26),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.cyanAccent, 
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.3), 
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Icon(
                  Icons.pause, 
                  color: Colors.white, 
                  size: (sw * 0.06).clamp(24.0, 32.0),
                ),
              ),
            ),
          ),
          // Lives and question box
          Positioned(
            bottom: sh * 0.05,
            left: sw * 0.08,
            right: sw * 0.08,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: List.generate(
                        lives,
                        (i) => Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Icon(
                            Icons.favorite, 
                            color: const Color(0xFFFFD1DC), 
                            size: (sw * 0.09).clamp(28.0, 40.0),
                          ),
                        ),
                      ),
                    ),
                    ShootButton(onTap: fireLaser),
                  ],
                ),
                const SizedBox(height: 25),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  height: sh * 0.12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF131B26),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: boxBorderColor, 
                      width: 2.5,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        feedback.isEmpty 
                            ? quiz[currentQuestion]['question'] 
                            : feedback,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (sh * 0.035).clamp(18.0, 26.0),
                          fontFamily: 'Michroma',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isPaused) 
            PauseMenu(
              onResume: () => setState(() => isPaused = false),
            ),
        ],
      ),
    );
  }

  Widget _buildMoveZone(VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: const SizedBox.expand(),
      ),
    );
  }
}

// Widget for individual asteroid choices
class AsteroidChoice extends StatelessWidget {
  final double x, y;
  final Color color;
  final String label;
  final double alignWidth;

  const AsteroidChoice({
    super.key,
    required this.x,
    required this.y,
    required this.color,
    required this.label,
    required this.alignWidth,
  });

  // Build method for individual asteroid choices
  @override
  Widget build(BuildContext context) {
    if (y == -50) return const SizedBox.shrink();
    double size = (MediaQuery.of(context).size.width * 0.18)
        .clamp(60.0, 85.0);

    return AnimatedAlign(
      alignment: Alignment(x, y),
      duration: const Duration(milliseconds: 50),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white24, 
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45, 
              blurRadius: 5, 
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size * 0.25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget for the shoot button
class ShootButton extends StatelessWidget {
  final VoidCallback onTap;
  const ShootButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double size = (MediaQuery.of(context).size.width * 0.15)
        .clamp(50.0, 70.0);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFF232B32),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.cyanAccent, 
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.2), 
              blurRadius: 8,
            )
          ],
        ),
        child: Icon(
          Icons.flash_on, 
          color: Colors.cyanAccent, 
          size: size * 0.55,
        ),
      ),
    );
  }
}

// Widget for the pause menu
class PauseMenu extends StatelessWidget {
  final VoidCallback onResume;
  const PauseMenu({super.key, required this.onResume});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            width: (sw * 0.65).clamp(220.0, 300.0),
            padding: const EdgeInsets.symmetric(
              vertical: 30, 
              horizontal: 25,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1B35).withOpacity(0.95),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.cyanAccent.withOpacity(0.5), 
                width: 2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'PAUSED',
                  style: TextStyle(
                    fontFamily: 'Michroma', 
                    color: Colors.white, 
                    fontSize: 22, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                _menuButton(context, 'RESUME', onTap: onResume),
                const SizedBox(height: 15),
                _menuButton(
                  context, 
                  'CUSTOMIZATION', 
                  onTap: () => Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (_) => const CharacCustPage(),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                _menuButton(
                  context, 
                  'EXIT', 
                  isExit: true, 
                  onTap: () => Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(
                      builder: (_) => const TitlePage(),
                    ), 
                    (route) => false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuButton(
    BuildContext context, 
    String label, 
    {required VoidCallback onTap, bool isExit = false}
  ) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF15152D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(
              color: isExit 
                  ? Colors.redAccent.withOpacity(0.5) 
                  : Colors.cyan.withOpacity(0.5), 
              width: 1.5,
            ),
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