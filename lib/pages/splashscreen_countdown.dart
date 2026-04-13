import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/b-sfx_manager.dart';
import 'package:flutter_application_1/pages/button0_charac.dart';
import 'package:flutter_application_1/pages/q_timer_lives.dart';
import 'package:flutter_application_1/pages/q_timer_service.dart';
import 'quiz_QnA.dart';
import 'quiz_game.dart';

class SplashScreen_Countdown extends StatefulWidget {
  final String planet;
  final int level;

  const SplashScreen_Countdown({super.key, required this.planet, required this.level});

  @override
  _SplashScreen_CountdownState createState() => _SplashScreen_CountdownState();
}

// Added a simple class to track our star data for the warp effect
class StarData {
  final double xOffset;
  final double yOffset;
  final double baseSize;
  final double opacity;

  StarData({
    required this.xOffset,
    required this.yOffset,
    required this.baseSize,
    required this.opacity,
  });
}

class _SplashScreen_CountdownState extends State<SplashScreen_Countdown> with TickerProviderStateMixin {
  int countdown = 3;
  bool isLaunching = false;
  late List<StarData> stars;

  // Controllers for the cool animations
  late AnimationController _floatController;
  late AnimationController _shakeController;
  late AnimationController _warpController;

  @override
  void initState() {
    super.initState();
    stars = _generateStars();
    
    // Smooth floating animation for the rocket while waiting
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Violent rumble effect right before blast off
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 40), // slightly faster for a more intense vibration
    );

    // Warp speed stretching effect for the stars
    _warpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    startTimer();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _shakeController.dispose();
    _warpController.dispose();
    super.dispose();
  }

  // Generates percentage-based positions so it works perfectly on any screen size
  List<StarData> _generateStars() {
    final random = Random();
    return List.generate(80, (index) { // 80 stars for a nice density without overcrowding
      return StarData(
        xOffset: random.nextDouble(), // 0.0 to 1.0 (percentages of screen width)
        yOffset: random.nextDouble(), // 0.0 to 1.0 (percentages of screen height)
        baseSize: random.nextDouble() * 3 + 1.5, // Slightly bigger base stars
        opacity: random.nextDouble() * 0.6 + 0.3,
      );
    });
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      
      if (countdown > 1) {
        setState(() {
          countdown--;
        });
        // Light haptic tap for the countdown tick
        HapticFeedback.lightImpact();
        
        // Start engine rumble when it hits 1
        if (countdown == 1) {
          _shakeController.repeat(reverse: true);
          HapticFeedback.mediumImpact(); // Stronger feedback for the rumble
        }
      } else {
        timer.cancel();
        _shakeController.stop(); // Stop the shaking
        
        // BLAST OFF!
        HapticFeedback.heavyImpact(); 
        
        setState(() {
          countdown = 0;
          isLaunching = true;
        });

        // Trigger the warp speed background effect
        _warpController.forward();

        // Extended slightly to let the epic blast-off animation play out
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (mounted) {
            goToQuiz(context, widget.planet, widget.level);
          }
        });
      }
    });
  }

  void goToQuiz(BuildContext context, String planet, int level) async {
    final hearts = await LivesTimerService.getHearts();
    final remaining = await LivesTimerService.getRemainingTime();

    // Safety check to prevent navigation if the widget has been disposed
    if (!mounted) return; 

    if (hearts <= 0 && remaining > 0) {
      // Mission failed sound effect
      SfxManager.instance.missionFailed();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LivesTimerPage(
            onFinished: () {
              goToQuiz(context, planet, level);
            },
          ),
        ),
      );
      return;
    }

    final quizKey = '${planet.toLowerCase()}_quiz';
    final selectedQuiz = allQuizzes[quizKey] ?? allQuizzes['sun_quiz']!;

    String levelKey;
    switch (level) {
      case 1: levelKey = 'basic'; break;
      case 2: levelKey = 'intermediate'; break;
      case 3: levelKey = 'advanced'; break;
      default: levelKey = 'basic';
    }

    final quizList = selectedQuiz['levels'][levelKey] ?? selectedQuiz['levels']['basic'];

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
    final size = MediaQuery.of(context).size;
    
    // INCREASED SIZE: Made it 45% of screen height so it is prominent but safe from overflow
    final rocketHeight = size.height * 0.45; 
    final rocketWidth = rocketHeight / 1.6;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // WARP SPEED STARS LAYER
          AnimatedBuilder(
            animation: _warpController,
            builder: (context, child) {
              return Stack(
                children: stars.map((star) {
                  // As the rocket launches, stars streak downward and stretch
                  double warpStretch = _warpController.value * 80.0; // Streaks get longer
                  double downwardMovement = _warpController.value * size.height * 1.5; // Stars fly past
                  
                  // Reset position to top if they fall off screen to create a continuous loop effect
                  double currentY = (star.yOffset * size.height) + downwardMovement;
                  currentY = currentY % size.height;

                  return Positioned(
                    left: star.xOffset * size.width,
                    top: currentY,
                    child: Container(
                      width: star.baseSize * (1.0 - (_warpController.value * 0.5)), // gets slightly thinner
                      height: star.baseSize + warpStretch, // stretches vertically
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: star.opacity),
                        borderRadius: BorderRadius.circular(10), // Keeps edges smooth even when stretched
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          
          // COUNTDOWN TEXT LAYER
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isLaunching ? 0.0 : 1.0,
            child: Align(
              alignment: Alignment.center, 
              child: Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.15), 
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      // Massive elastic pop effect for the numbers
                      scale: Tween<double>(begin: 2.5, end: 1.0).animate(
                        CurvedAnimation(parent: animation, curve: Curves.elasticOut),
                      ),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: Text(
                    countdown > 0 ? '$countdown' : 'LAUNCH!',
                    key: ValueKey<int>(countdown),
                    style: TextStyle(
                      fontSize: countdown > 0 ? size.height * 0.25 : size.height * 0.12,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      letterSpacing: countdown > 0 ? 0.0 : 6.0,
                      shadows: [
                        Shadow(
                          blurRadius: 25.0,
                          color: countdown == 1 ? Colors.orangeAccent : Colors.blueAccent.withValues(alpha: 0.9),
                          offset: const Offset(0, 0),
                        ),
                        Shadow(
                          blurRadius: 50.0,
                          color: countdown == 1 ? Colors.redAccent : Colors.cyanAccent.withValues(alpha: 0.8),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ROCKET & AVATAR LAYER
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000), 
            // EaseInCubic makes it start slow and rapidly accelerate off the screen
            curve: Curves.easeInCubic, 
            // Anchored beautifully at the bottom of the screen before launch
            bottom: isLaunching ? size.height + 200 : size.height * 0.05, 
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: Listenable.merge([_floatController, _shakeController]),
              builder: (context, child) {
                // Smooth sine wave floating while waiting
                double dy = isLaunching ? 0 : (sin(_floatController.value * pi * 2) * 10);
                
                // Violent random shaking right before launch
                double dx = _shakeController.isAnimating ? (Random().nextDouble() * 12 - 6) : 0;
                
                return Transform.translate(
                  offset: Offset(dx, dy),
                  child: child,
                );
              },
              child: Center(
                child: SizedBox(
                  width: rocketWidth,
                  height: rocketHeight,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // ROCKET
                      Image.asset(
                        selectedSpaceship,
                        fit: BoxFit.contain,
                      ),
                      // AVATAR BUBBLE (Scaled automatically with the bigger rocket)
                      Align(
                        alignment: const Alignment(0.0, -0.15),
                        child: Container(
                          width: rocketWidth * 0.38, 
                          height: rocketWidth * 0.38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.cyanAccent.withValues(alpha: 0.2),
                                blurRadius: 15,
                                spreadRadius: 2,
                              )
                            ],
                            image: DecorationImage(
                              image: AssetImage(selectedAstroknowt),
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
          ),
        ],
      ),
    );
  }
}