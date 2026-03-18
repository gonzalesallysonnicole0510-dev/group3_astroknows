import 'dart:async';

import 'package:flutter/material.dart';
import 'q_achievement.dart';
import 'q_mission-failed.dart';

class QuizGame_Mercury extends StatefulWidget {
  const QuizGame_Mercury({super.key});

  @override
  State<QuizGame_Mercury> createState() => _QuizGame_MercuryState();
}

enum direction {UP, DOWN}

class _QuizGame_MercuryState extends State<QuizGame_Mercury> {

  // position of player in x coordinate
  double playerX = 0;

  // laser initial x coordinate and height (size)
  double laserX = 0;
  double laserHeight = 20;

  // for repeated shot
  bool midShot = false;

  // lives variables <3
  int lives = 3;

  Widget buildLives() {
   return Row(
     children: List.generate(
       lives,
       (index) => Icon(Icons.favorite, color: Colors.pink[100]),
     ),
   );
  }


  // questions and correct answers
  int currentQuestion = 0;
  String questionText = '';
  String feedback = '';

  List<Map<String, dynamic>> quiz = [
    {
      'question': 'Mercury Question 1',  // question 1
      'answers': ['x', 'yes', 'x'],
      'correct': 1
    },
    {
      'question': 'Mercury Question 2',  // question 2
      'answers': ['x', 'x', 'yes'],
      'correct': 2
    },
    {
      'question': 'Mercury Question 3',  // question 3
      'answers': ['yes', 'x', 'x'],
      'correct': 0
    },
    {
      'question': 'Mercury Question 4', // question 4
      'answers': ['x', 'yes', 'x'],
      'correct': 1
    },
    {
      'question': 'Mercury Question 5',  // question 5
      'answers': ['x', 'x', 'yes'],
      'correct': 2
    },
    {
      'question': 'Mercury Question 6',  // question 6
      'answers': ['yes', 'x', 'x'],
      'correct': 0
    },
    {
      'question': 'Mercury Question 7',  // question 7
      'answers': ['x', 'yes', 'x'],
      'correct': 1
    },
    {
      'question': 'Mercury Question 8',  // question 8
      'answers': ['x', 'x', 'yes'],
      'correct': 2
    },
    {
      'question': 'Mercury Question 9',  // question 9
      'answers': ['yes', 'x', 'x'],
      'correct': 0
    },
    {
      'question': 'Mercury Question 10',  // question 10
      'answers': ['x', 'yes', 'x'],
      'correct': 1
    }
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
          MaterialPageRoute(
            builder: (context) => MissionFailedPage(),
          ),
        );
      }
    }
  }


  // asteroid positions
  List<double> asteroidX = [-0.58, 0, 0.58];
  List<double> asteroidY = [-0.7, -0.7, -0.7];
  List<direction> asteroidFloat = [
    direction.UP,
    direction.DOWN,
    direction.UP,
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
    gameTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {

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


  // buttons for player and laser movement
  void moveLeft() {
    setState(() {
      playerX = -0.3;

      if (!midShot) {  // laser will not follow the spaceship midshot
        laserX = playerX;
      }
    });
  }

  void moveMiddle() {
    setState(() {
      playerX = 0;

      if (!midShot) {
        laserX = playerX;
      }
    });
  }

  void moveRight() {
    setState(() {
      playerX = 0.3;

      if (!midShot) {
        laserX = playerX;
      }
    });
  }


  void fireLaser() {
    if (midShot) return;

    midShot = true;

    Timer.periodic(Duration(milliseconds: 10), (timer) {

      // laser shoots until it hits the top of the screen
      setState(() {
        laserHeight += 20;
      });

      double maxHeight = MediaQuery.of(context).size.height * 2 / 4;

      // when laser reaches to the top, it resets
      if (laserHeight > maxHeight) {
        resetLaser();
        timer.cancel();
        midShot = false;
      }


      // check if laser has hit the 3 asteroids
        if (asteroidY[0] > heightToCoordinate(laserHeight) &&
            (asteroidX[0] - laserX).abs() < 0.35) {
       
            asteroidY[0] = -50;
            checkAnswer(0);
        }


        if (asteroidY[1] > heightToCoordinate(laserHeight) &&
            (asteroidX[1] - laserX).abs() < 0.3) {
       
            asteroidY[1] = -50;
            checkAnswer(1);
        }


        if (asteroidY[2] > heightToCoordinate(laserHeight) &&
            (asteroidX[2] - laserX).abs() < 0.35) {
       
            asteroidY[2] = -50;
            checkAnswer(2);
        }
    });
  }


  // converts height to a coordinate
  double heightToCoordinate(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 2 / 4;
    double laserY = 1 - (2 * height / totalHeight);
    return laserY;
  }


  void resetLaser() {
    laserX = playerX;
    laserHeight = 20;
  }

  void resetAsteroids() {
   asteroidX = [-0.58, 0, 0.58];
   asteroidY = [-0.7, -0.7, -0.7];
   asteroidFloat = [
    direction.UP,
    direction.DOWN,
    direction.UP,];
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.0),
        elevation: 0.0,

        // Pause Button
        actions: [
          Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(right: 25, top: 5),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade800,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.lightBlue,
                width: 1,
              ),
            ),
            child: Icon(
              Icons.pause,
              color: Colors.white,
              size: 40,
              ),
          ),
        ],
      ),


      body: Stack(
        children: [
          Column (
            children: [

              // Container of Spaceship
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  color: Colors.white.withValues(alpha: 0.0),  // transparent
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
                          asteroidColor: Color.fromARGB(255, 63, 61, 61),
                          answerIndex: 1,
                          currentQuestion: currentQuestion,
                          quiz: quiz,
                        ),
                        AsteroidChoice(
                          asteroidX: asteroidX[2],
                          asteroidY: asteroidY[2],
                          asteroidColor: Color.fromARGB(255, 103, 103, 103),
                          answerIndex: 2,
                          currentQuestion: currentQuestion,
                          quiz: quiz,
                        ),


                        // Laser animation and size
                        AnimatedAlign(
                          alignment: Alignment(laserX, 1),
                          duration: Duration(milliseconds: 150),
                          curve: Curves.fastOutSlowIn,
                            child: Container(
                              width: 1,
                              height: laserHeight,
                              color: Colors.lightBlue,
                            ),
                          ),
                       
                        // Spaceship/Player
                        AnimatedAlign(
                        alignment: Alignment(playerX, 1),
                        duration: Duration(milliseconds: 150),
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                          width: 22.5,
                          height: 45,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/spaceship.png'),
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                      ),
                     ],
                    ),
                  ),
                ),
              ),


              // space for the question container
              Expanded(
                child: Container(
                  color: Colors.grey.withValues(alpha: 0.0),  // transparent
                ),
              ),
            ],
          ),
         

          // Screen Buttons to navigate to the left, middle, and right side
          Stack(
            children: [
              Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScreenButton(
                    function: moveLeft,
                  ),
                  ScreenButton(
                    function: moveMiddle,
                  ),
                  ScreenButton(
                    function: moveRight,
                  ),
                ],
              ),
            ),


            // Shoot button
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  margin: EdgeInsets.only(bottom: 125, right: 100),
                  child: ShootButton(
                      functionLaser: fireLaser,
                    ),
                  ),
                ),


            // Question container
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: 500,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 11, 34, 67),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.lightBlue,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.all(10),
                        child: Text(
                          feedback.isEmpty
                          ? quiz[currentQuestion]['question']
                          : feedback,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),


              // Lives
              Positioned(
                bottom: 75,
                left: 125,
                child: buildLives(),
              ),
            ],
          ),
        ],
       ),
    );
  }
}



// screen button to move the spaceship/player
class ScreenButton extends StatelessWidget {
  final function;

  const ScreenButton({super.key, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:function,


    child: Container(
      color: Colors.grey.withValues(alpha: 0.0),  // transparent
      width: 120,
      )
    );
  }
}


// button to shoot laser
class ShootButton extends StatelessWidget {
  final functionLaser;

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
          border: Border.all(
            color: Colors.lightBlue,
            width: 1,
          ),
        ),
        child: Text(
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
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 150, left: 190, right: 190),
      alignment: Alignment(asteroidX, asteroidY),
      child: Container(
        width: 60,
        height: 60,
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
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}
