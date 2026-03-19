import 'dart:async';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'button0_charac.dart';
import 'title.dart';
import 'q_achievement.dart';
import 'q_mission-failed.dart';


class QuizGame_Mars extends StatefulWidget {
  const QuizGame_Mars({super.key});


  @override
  State<QuizGame_Mars> createState() => _QuizGame_MarsState();
}


enum direction { UP, DOWN }


class _QuizGame_MarsState extends State<QuizGame_Mars> {


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
  Widget buildLives(double screenWidth) {
    return Row(
      children: List.generate(
        lives,
        (index) => Icon(Icons.favorite, color: Colors.pink[100], size: screenWidth * 0.04),
      ),
    );
  }


  // Quiz questions
  int currentQuestion = 0;
  String feedback = '';
  List<Map<String, dynamic>> quiz = [
    {'question': 'Mars Question 1', 'answers': ['x', 'yes', 'x'], 'correct': 1},
    {'question': 'Mars Question 2', 'answers': ['x', 'x', 'yes'], 'correct': 2},
    {'question': 'Mars Question 3', 'answers': ['yes', 'x', 'x'], 'correct': 0},
    {'question': 'Mars Question 4', 'answers': ['x', 'yes', 'x'], 'correct': 1},
    {'question': 'Mars Question 5', 'answers': ['x', 'x', 'yes'], 'correct': 2},
    {'question': 'Mars Question 6', 'answers': ['yes', 'x', 'x'], 'correct': 0},
    {'question': 'Mars Question 7', 'answers': ['x', 'yes', 'x'], 'correct': 1},
    {'question': 'Mars Question 8', 'answers': ['x', 'x', 'yes'], 'correct': 2},
    {'question': 'Mars Question 9', 'answers': ['yes', 'x', 'x'], 'correct': 0},
    {'question': 'Mars Question 10', 'answers': ['x', 'yes', 'x'], 'correct': 1},
  ];


  // for checking answers
  void checkAnswer(int answerIndex) {
    int correctIndex = quiz[currentQuestion]["correct"];


    if (answerIndex == correctIndex) {
      setState(() {
        feedback = "Correct!";
      });


      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          if (currentQuestion < quiz.length - 1) {
            currentQuestion++;
            resetAsteroids();
            feedback = '';
          }      
          else {
            currentQuestion = 0;
            resetAsteroids();
            feedback = '';
            Navigator.pushReplacement(  // go to achievement page when all questions are answered
              context,
              MaterialPageRoute(
                builder: (context) => AchievementPage(),
              ),
            );
          }
          });
        });
      }
      else {
        setState(() {
          feedback = "Incorrect!";
          lives--;
        });


        if (lives <= 0) {
          currentQuestion = 0;
          feedback = '';
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MissionFailedPage()));
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


  // to stop the animation timer, the widget will be disposed when the game finishes, preventing memory leaks
  @override
  void dispose() {
    gameTimer.cancel();
    super.dispose();
  }




  void startQuizGame() {
    gameTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {


    if (isPaused) return; // stop updates while paused


    // left asteroid
    if (asteroidY[0] - 0.2 < -1) {
      asteroidFloat[0] = direction.DOWN;
    }
    else if (asteroidY[0] + 0.2 > 1) {
      asteroidFloat[0] = direction.UP;
    }


    setState(() {
      if (asteroidFloat[0] == direction.UP) {
        asteroidY[0] -= 0.08;
      } else {
        asteroidY[0] += 0.08;
      }
    });




    // middle asteroid
    if (asteroidY[1] - 0.2 < -1) {
      asteroidFloat[1] = direction.DOWN;
    }
    else if (asteroidY[1] + 0.2 > 1) {
      asteroidFloat[1] = direction.UP;
    }


    setState(() {
      if (asteroidFloat[1] == direction.UP) {
        asteroidY[1] -= 0.08;
      } else {
        asteroidY[1] += 0.08;
      }
    });




     // right asteroid
    if (asteroidY[2] - 0.2 < -1) {
      asteroidFloat[2] = direction.DOWN;
    }
    else if (asteroidY[2] + 0.2 > 1) {
      asteroidFloat[2] = direction.UP;
    }


    setState(() {
      if (asteroidFloat[2] == direction.UP) {
        asteroidY[2] -= 0.08;
      } else {
        asteroidY[2] += 0.08;
      }
    });
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


    Timer.periodic(Duration(milliseconds: 10), (timer) {


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
      // for asteroid on the left
        if (asteroidY[0] > heightToCoordinate(laserHeight) &&
            (asteroidX[0] - laserX).abs() < 0.35) {
       
            asteroidY[0] = -50;
            checkAnswer(0);
        }


      // for asteroid in the middle
        if (asteroidY[1] > heightToCoordinate(laserHeight) &&
            (asteroidX[1] - laserX).abs() < 0.3) {
       
            asteroidY[1] = -50;
            checkAnswer(1);
        }


      // for asteroid on the right
        if (asteroidY[2] > heightToCoordinate(laserHeight) &&
            (asteroidX[2] - laserX).abs() < 0.35) {
         
            asteroidY[2] = -50;
            checkAnswer(2);
        }
    });
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
              margin: EdgeInsets.only(right: screenWidth * 0.05, top: screenHeight * 0.01),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade800,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.lightBlue, width: 1),
              ),
              child: Icon(
                Icons.pause,
                color: Colors.white,
                size: screenWidth * 0.06
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


                          // Laser animation
                          AnimatedAlign(
                            alignment: Alignment(laserX, 1),
                            duration: const Duration(milliseconds: 150),
                            curve: Curves.fastOutSlowIn,
                            child: Container(width: screenWidth * 0.002, height: laserHeight, color: Colors.lightBlue),
                          ),


                          // Spaceship (player)
                          AnimatedAlign(
                            alignment: Alignment(playerX, 1),
                            duration: const Duration(milliseconds: 150),
                            curve: Curves.fastOutSlowIn,
                            child: Container(
                              width: screenWidth * 0.04,
                              height: screenHeight * 0.16,
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
              Expanded(child: Container()), // spacing for question
            ],
          ),


          // Navigation buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScreenButton_LeftRight(
                  functionLeftRight: moveLeft
                  ),
                ScreenButton_Middle(
                  functionMiddle: moveMiddle
                  ),
                ScreenButton_LeftRight(
                  functionLeftRight: moveRight
                  ),
              ],
            ),
          ),


          // Shoot button
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(
                bottom: screenHeight * 0.20,
                right: screenWidth * 0.12
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
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 11, 34, 67),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.lightBlue),
              ),
              child: Center(
                child: Text(
                  feedback.isEmpty ? quiz[currentQuestion]['question'] : feedback,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenHeight * 0.05
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
            child: buildLives(screenWidth)),
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
      onTap:functionMiddle,


    child: Container(
      color: Colors.transparent,
      width: 120,
      )
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
      onTap:functionLeftRight,


    child: Container(
      color: Colors.transparent,
      width: screenWidth * 0.3,
      )
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
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}




// look of asteroid choices with answers inside the circle containers
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
      margin: EdgeInsets.only(top: 20, bottom: 150, left: 190, right: 190),
      alignment: Alignment(asteroidX, asteroidY),
      child: Container(
        width: screenWidth *0.10,
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




// pause button
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
          child: Container(color: Colors.black.withValues(alpha: 0.5)),
        ),
        Center(
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Opacity(opacity: scale.clamp(0.0, 1.0), child: child),
              );
            },
            child: Container(
              width: screenWidth * 0.45,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1B35).withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.8), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withValues(alpha: 0.2),
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
                 
                  // resume
                  _menuButton(context, 'RESUME', onTap: onResume),
                  const SizedBox(height: 18),
                 
                  // customi
                  _menuButton(context, 'CUSTOMIZATION', onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => const CharacCustPage()));
                  }),
                  const SizedBox(height: 18),
                 
                  // exit to title screen (title.dart)
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
              color: isExit ? Colors.redAccent.withValues(alpha: 0.7) : Colors.cyan.withValues(alpha: 0.7),
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

