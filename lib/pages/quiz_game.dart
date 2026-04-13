import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/button3_settings.dart';
import 'package:flutter_application_1/pages/q_timer_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import 'b-sfx_manager.dart';
import 'button0_charac.dart';
import 'title.dart';
import 'q_mission_accomplished.dart';
import 'q_mission_failed.dart';
import 'star_animation.dart';

class Quizteroid_Quest extends StatefulWidget {
  final List<Map<String, dynamic>> quiz;
  final String planet;
  final String astroknowt;
  final String spaceship;

  const Quizteroid_Quest({
    super.key,
    required this.quiz,
    required this.planet,
    required this.astroknowt,
    required this.spaceship,
  });

  @override
  State<Quizteroid_Quest> createState() => _Quizteroid_QuestState();
}

enum AsteroidDirection { up, down }
enum PlayerDirection { up, down }

class _Quizteroid_QuestState extends State<Quizteroid_Quest> {
  String avatarPath = 'images/default_avatar.png';
  String spaceshipPath = '';

  // Game state variables
  bool isPaused = false;
  bool isLanding = true; // Added for the start animation
  int lives = 3;
  int totalPurchasedHearts = 0;

  int currentQuestion = 0;
  String feedback = '';
  Color boxBorderColor = Colors.lightBlueAccent;

  bool timerRunning = false;

  // Asteroid positions
  List<double> asteroidX = [-0.61, 0, 0.61];
  List<double> asteroidY = [-0.15, -0.15, -0.15];
  List<double> asteroidRotation = [0.0, 0.5, 1.2];
  List<AsteroidDirection> asteroidFloat = [
    AsteroidDirection.up,
    AsteroidDirection.down,
    AsteroidDirection.up,
  ];

  // Laser state
  double laserX = 0;
  double laserHeight = 0;
  bool midShot = false;

  // Player positions
  double playerX = 0;
  double playerY = -1.5; // Start way off-screen at the top for landing animation
  var playerFloat = PlayerDirection.up;

  Timer? gameTimer;
  Timer? animationSpeed;

  @override
  void initState() {
    super.initState();
    SfxManager.instance.travelSpace(); // traveling thru space sound effect
    avatarPath = widget.astroknowt;
    spaceshipPath = widget.spaceship;
    _loadHearts();
    _playLandingAnimation(); // Trigger the landing animation sequence
  }

  void _playLandingAnimation() {
    // 1. Give the UI a split second to build, then drop the ship
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          playerY = 0.95; // Changed from 0.8 to sit right above the UI
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          isLanding = false;
        });
        startQuizGame();
        quizgameTimer();
      }
    });
  }

  // load hearts
  Future<void> _loadHearts() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lives = prefs.getInt('currentHearts') ?? 3;
      totalPurchasedHearts = prefs.getInt('totalPurchasedHearts') ?? 0;
    });
  }

  // save hearts
  Future<void> _saveHearts(int newLives) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentHearts', newLives);
    setState(() => lives = newLives);
  }

  Future<void> restoreHeartsFromPurchases() async {
    await _loadHearts();
  }

  Future<bool> buyHearts(int amount, double price) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final prefs = await SharedPreferences.getInstance();

      int newPurchased = (prefs.getInt('totalPurchasedHearts') ?? 0) + amount;
      int newCurrent = math.min(lives + amount, 99);

      await prefs.setInt('totalPurchasedHearts', newPurchased);
      await prefs.setInt('currentHearts', newCurrent);

      setState(() {
        lives = newCurrent;
        totalPurchasedHearts = newPurchased;
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    SfxManager.instance.stopLoop();
    gameTimer?.cancel();
    animationSpeed?.cancel();
    super.dispose();
  }

  int timeLeft = 20;
  double timeBuffer = 0;

  void quizgameTimer() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {

      if (isPaused || isLanding || feedback.isNotEmpty || !mounted) return;

      timeBuffer += 0.1;

      if (timeBuffer >= 1) {
       timeBuffer = 0;

       if (timeLeft > 0) {
          setState(() {
           timeLeft--;
         });
       }

        if (timeLeft == 0) {
          setState(() {
            feedback = "Time's Up!";
           boxBorderColor = Colors.redAccent;
            lives--;
            _saveHearts(lives);
            SfxManager.instance.wrong();
         });

          if (lives <= 0) {
           Future.delayed(const Duration(milliseconds: 800), () {
             if (mounted) {
               SfxManager.instance.missionFailed();
               Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(builder: (_) => const MissionFailedPage()),
               );
              }
            });
          } else {
            Future.delayed(const Duration(seconds: 1), () {
             if (!mounted) return;

              bool isLast = currentQuestion >= widget.quiz.length - 1;

              if (isLast) {
                SfxManager.instance.missionFailed();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MissionFailedPage()),
                );
              } else {
               setState(() {
                  currentQuestion++;
                  feedback = '';
                  boxBorderColor = Colors.lightBlueAccent;
                  _resetAsteroids();
                  timeLeft = 20;
                  timeBuffer = 0; // Reset the buffer to prevent immediate timeout on the next tick
               });
             }
           });
         }
       }
      }
   });
  }

  void startQuizGame() {
    animationSpeed = Timer.periodic(const Duration(milliseconds: 70), (timer) {
      if (isPaused || isLanding || feedback.isNotEmpty || !mounted) return;

      setState(() {
        // Asteroid up and down animation
        for (int i = 0; i < 3; i++) {
          if (asteroidY[i] == -50) continue;

          if (asteroidY[i] < -0.05) {
            asteroidFloat[i] = AsteroidDirection.down;
          } else if (asteroidY[i] > 0.15) {
            asteroidFloat[i] = AsteroidDirection.up;
          }

          asteroidY[i] += (asteroidFloat[i] == AsteroidDirection.up) ? -0.01 : 0.01;
          asteroidRotation[i] += (i % 2 == 0) ? 0.005 : -0.005;
        }

        if (playerY < 0.93) {
          playerFloat = PlayerDirection.down;
        } else if (playerY > 0.97) {
          playerFloat = PlayerDirection.up;
        }

        playerY += (playerFloat == PlayerDirection.up) ? -0.005 : 0.005;
      });
    });
  }

  // Player movement functions
  void moveLeft() {
    if (isLanding) return; // Prevent movement during landing
    setState(() {
      playerX = -0.61;
      if (!midShot) laserX = playerX;
    });
  }

  void moveMiddle() {
    if (isLanding) return;
    setState(() {
      playerX = 0;
      if (!midShot) laserX = playerX;
    });
  }

  void moveRight() {
    if (isLanding) return;
    setState(() {
      playerX = 0.61;
      if (!midShot) laserX = playerX;
    });
  }

  // Shooting function
  void fireLaser() {
    if (midShot || isPaused || isLanding || feedback.isNotEmpty) return;

    SfxManager.instance.laser();

    setState(() {
      midShot = true;
      laserX = playerX;
    });

    Timer.periodic(const Duration(milliseconds: 15), (timer) {
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
        double hitPos = heightToCoordinate(laserHeight + (maxHeight * 0.1));
        bool isHit = (asteroidX[i] - laserX).abs() < 0.2;

        if (asteroidY[i] != -50 && asteroidY[i] > hitPos && isHit) {
          asteroidY[i] = -50;
          _stopLaser(timer);
          checkAnswer(i);
          break;
        }
      }
    });
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
  Future<void> checkAnswer(int index) async {
    bool isCorrect = index == widget.quiz[currentQuestion]['correct'];

    setState(() {
      feedback = isCorrect ? "CORRECT!" : "INCORRECT!";
      boxBorderColor = isCorrect ? Colors.greenAccent : Colors.redAccent;
    });

    if (isCorrect) {
      SfxManager.instance.correct();
    } else {
      SfxManager.instance.wrong();
    }

    if (!isCorrect) {
      int current = await LivesTimerService.getHearts();
      int newLives = current - 1;

      await LivesTimerService.setHearts(newLives);

      setState(() {
        lives = newLives;
      });
    }

    if (lives <= 0) {
      await LivesTimerService.startCooldown();
      SfxManager.instance.missionFailed();
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MissionFailedPage()),
          );
        }
      });
      return;
    }

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      bool isLast = currentQuestion >= widget.quiz.length - 1;

      if (isCorrect && isLast) {
        SfxManager.instance.accomplished();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => AccomplishedPage(
              star: 500,
              planet: widget.planet,
            ),
          ),
        );
      } else {
        setState(() {
          if (isCorrect) currentQuestion++;
          feedback = '';
          boxBorderColor = Colors.lightBlueAccent;
          _resetAsteroids();
          timeLeft = 20;
          timeBuffer = 0;
        });
      }
    });
  }

  void _resetAsteroids() {
    setState(() {
      asteroidX = [-0.61, 0, 0.61];
      asteroidY = [-0.15, -0.15, -0.15];
      asteroidRotation = [0.0, 0.5, 1.2];
      asteroidFloat = [
        AsteroidDirection.up,
        AsteroidDirection.down,
        AsteroidDirection.up,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    // Fixed sizing: Removed the 210.0 minimum clamps so it gracefully fits smaller screens
    final double rocketWidth = (sw * 0.18).clamp(60.0, 110.0);
    final double rocketHeight = (sh * 0.12).clamp(80.0, 120.0);

    final Color timerColor = timeLeft > 10
        ? Colors.cyanAccent
        : (timeLeft > 5 ? Colors.orangeAccent : Colors.redAccent);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const SpaceWarpScreen(),
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
                    rotation: asteroidRotation[i],
                    imagePath: 'images/asteroid$i.png',
                    label: widget.quiz[currentQuestion]['answers'][i],
                  ),

                // Laser alignment adjusted to match new resting position
                AnimatedAlign(
                  alignment: Alignment(laserX, 0.70),
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
                              color: Colors.cyanAccent.withValues(alpha: 0.8),
                              blurRadius: 10,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Player Spaceship
                AnimatedAlign(
                  alignment: Alignment(playerX, playerY),
                  // Slower curve for landing, quick responsive linear for floating
                  duration: isLanding
                      ? const Duration(milliseconds: 1400)
                      : const Duration(milliseconds: 150),
                  curve: isLanding ? Curves.easeOutQuart : Curves.linear,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        spaceshipPath,
                        width: rocketWidth,
                        height: rocketHeight,
                      ),
                      // Avatar positioned to sit nicely within the cockpit area of the spaceship, adjust the top offset as needed based on your specific art assets
                      Positioned(
                        top: rocketHeight * 0.28,
                        child: Image.asset(
                          avatarPath,
                          opacity: const AlwaysStoppedAnimation(.8),
                          width: rocketWidth * 0.35,
                          height: rocketWidth * 0.35,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Timer on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: SizedBox(
                height: 40,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedContainer(
                      duration: timeLeft == 20
                          ? Duration.zero
                          : const Duration(seconds: 1),
                      curve: Curves.linear,
                      width: (timeLeft.clamp(0, 20) / 20) * sw,
                      height: 4,
                      margin: const EdgeInsets.only(top: 18), // Centers the line with the orb
                      decoration: BoxDecoration(
                        color: timerColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: timerColor.withValues(alpha: 0.8),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),

                    AnimatedPositioned(
                      duration: (timeLeft == 20 || isPaused)
                          ? Duration.zero
                          : const Duration(seconds: 1),
                      curve: Curves.linear,
                      left: (timeLeft.clamp(0, 20) / 20) * sw - 18,
                      top: 2,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        // ... (keep the rest of the timer circle the same)
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF131B26),
                          border: Border.all(
                            color: timerColor,
                            width: timeLeft <= 5 ? 3 : 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: timerColor.withValues(alpha: timeLeft <= 5 ? 0.8 : 0.4),
                              blurRadius: timeLeft <= 5 ? 15 : 8,
                              spreadRadius: timeLeft <= 5 ? 4 : 1,
                            ),
                          ],
                        ),
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              color: timeLeft <= 5 ? Colors.redAccent : Colors.white,
                              fontSize: timeLeft <= 5 ? 18 : 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Share Tech',
                            ),
                            child: Text('$timeLeft'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Pause button
          Positioned(
            top: (sh * 0.05).clamp(30.0, 60.0),
            right: (sw * 0.05).clamp(15.0, 30.0),
            child: GestureDetector(
              onTap: () {
                if(isLanding) return; // Disallow pause while landing
                SfxManager.instance.pause();
                setState(() => isPaused = true);
                gameTimer?.cancel();
              },
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
                      color: Colors.cyanAccent.withValues(alpha: 0.3),
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
                      children: [
                        Icon(
                          Icons.favorite,
                          color: const Color(0xFFFFD1DC),
                          size: (sw * 0.09).clamp(23.0, 35.0),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$lives',
                          style: TextStyle(
                            color: const Color(0xFFFFD1DC),
                            fontSize: (sw * 0.08).clamp(20.0, 28.0),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Share Tech',
                          ),
                        ),
                      ],
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
                      child: FittedBox(
                        child: Text(
                          feedback.isEmpty
                              ? widget.quiz[currentQuestion]['question']
                              : feedback,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: (sh * 0.035).clamp(18.0, 26.0),
                            fontFamily: 'Share Tech',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isPaused)
            PauseMenu(
              onResume: () {
                SfxManager.instance.secButton();
                setState(() => isPaused = false);
                quizgameTimer();
              },
              onUpdateAvatar: (newPath) {
                setState(() {
                  // Assuming selectedAstroknowt/Spaceship variables are managed elsewhere or globally
                  avatarPath = selectedAstroknowt;
                  spaceshipPath = selectedSpaceship;
                });
              },
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

// ----------------------------------------------------
// Updated Widgets (AsteroidChoice, ShootButton remain essentially untouched)
// ----------------------------------------------------

class AsteroidChoice extends StatelessWidget {
  final double x, y, rotation;
  final String imagePath;
  final String label;

  const AsteroidChoice({
    super.key,
    required this.x,
    required this.y,
    required this.rotation,
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    if (y == -50) return const SizedBox.shrink();

    double size = (MediaQuery.of(context).size.width * 0.18).clamp(65.0, 95.0);
    double glowOpacity = 0.1 + (0.15 * math.sin(rotation * 6).abs());

    return AnimatedAlign(
      alignment: Alignment(x, y),
      duration: const Duration(milliseconds: 50),
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size * 0.85,
              height: size * 0.85,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withValues(alpha: glowOpacity),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
            Transform.rotate(
              angle: rotation,
              child: Image.asset(
                imagePath,
                width: size,
                height: size,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: size * 0.75,
              height: size * 0.75,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size * 0.28,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Share Tech',
                      letterSpacing: 1.0,
                      shadows: [
                        const Shadow(
                          color: Colors.black87,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                        const Shadow(color: Colors.black, offset: Offset(1.5, 1.5), blurRadius: 2),
                        const Shadow(color: Colors.black, offset: Offset(-1.5, -1.5), blurRadius: 2),
                        const Shadow(color: Colors.black, offset: Offset(1.5, -1.5), blurRadius: 2),
                        const Shadow(color: Colors.black, offset: Offset(-1.5, 1.5), blurRadius: 2),
                        Shadow(
                          color: Colors.cyanAccent.withValues(alpha: 0.8),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShootButton extends StatelessWidget {
  final VoidCallback onTap;
  const ShootButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double size = (MediaQuery.of(context).size.width * 0.15).clamp(50.0, 70.0);
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
              color: Colors.cyanAccent.withValues(alpha: 0.2),
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

class PauseMenu extends StatelessWidget {
  final VoidCallback onResume;
  final ValueSetter<String> onUpdateAvatar;
  const PauseMenu({super.key, required this.onResume, required this.onUpdateAvatar});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: Center(
          child: Container(
            // FIX: Dynamic margin ensures it never touches the edges on small screens
            margin: EdgeInsets.symmetric(
              horizontal: sw * 0.1, 
              vertical: sh * 0.1
            ),
            // FIX: Prevents it from getting absurdly wide on tablets/large screens
            constraints: const BoxConstraints(maxWidth: 350),
            padding: EdgeInsets.symmetric(
              vertical: (sh * 0.04).clamp(20.0, 40.0),
              horizontal: 25,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1B35).withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.cyanAccent.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            // FIX: SingleChildScrollView is inside the decorated container now
            child: SingleChildScrollView(
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
                    onTap: () async {
                      SfxManager.instance.secButton();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CharacCustPage(type: CustomizationType.astroknowt)),
                      );
                      onUpdateAvatar(selectedAstroknowt);
                      onResume();
                    },
                  ),
                  const SizedBox(height: 15),
                  _menuButton(
                    context,
                    'SETTINGS',
                    onTap: () async {
                      SfxManager.instance.secButton();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsPage()),
                      );
                      onUpdateAvatar(selectedAstroknowt);
                      onResume();
                    },
                  ),
                  const SizedBox(height: 15),
                  _menuButton(
                    context,
                    'EXIT',
                    isExit: true,
                    onTap: () {
                      SfxManager.instance.secButton();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => TitlePage(astroknowt: selectedAstroknowt)),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuButton(BuildContext context, String label, {required VoidCallback onTap, bool isExit = false}) {
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
              color: isExit ? Colors.redAccent.withValues(alpha: 0.5) : Colors.cyan.withValues(alpha: 0.5),
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