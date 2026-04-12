import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
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

class _SplashScreen_CountdownState extends State<SplashScreen_Countdown> with TickerProviderStateMixin {
  int countdown = 3;
  bool isLaunching = false;
  late List<Widget> backgroundStars;

  // Controllers for the cool animations
  late AnimationController _floatController;
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    backgroundStars = _generateStars();
    
    // Smooth bobbing/floating effect for the rocket
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Violent rumble effect right before blast off
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );

    startTimer();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  List<Widget> _generateStars() {
    final random = Random();
    return List.generate(60, (index) {
      double size = random.nextDouble() * 3 + 1;
      return Positioned(
        left: random.nextDouble() * 1000,
        top: random.nextDouble() * 1000,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: random.nextDouble() * 0.8 + 0.2),
            shape: BoxShape.circle,
          ),
        ),
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
        
        // Start engine rumble when it hits 1
        if (countdown == 1) {
          _shakeController.repeat(reverse: true);
        }
      } else {
        timer.cancel();
        _shakeController.stop(); // Stop the shaking
        
        setState(() {
          countdown = 0;
          isLaunching = true;
        });

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

    // Safety check to prevent navigation if the widget has been disposed during the timer delay
    if (!mounted) return; 

    if (hearts <= 0 && remaining > 0) {
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
    
    // Base size on height instead of width to prevent massive scaling on web/landscape
    final rocketHeight = size.height * 0.35; 
    final rocketWidth = rocketHeight / 1.6;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: Stack(
        alignment: Alignment.center,
        children: [
          ...backgroundStars,
          
          // Countdown text with a cool elastic pop effect on change and a fade out when launching
          AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: isLaunching ? 0.0 : 1.0,
            child: Align(
              alignment: Alignment.center, 
              child: Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.1), 
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      // Massive elastic pop effect
                      scale: Tween<double>(begin: 3.0, end: 1.0).animate(
                        CurvedAnimation(parent: animation, curve: Curves.elasticOut),
                      ),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: Text(
                    countdown > 0 ? '$countdown' : 'LAUNCH!',
                    key: ValueKey<int>(countdown),
                    style: TextStyle(
                      fontSize: countdown > 0 ? size.height * 0.25 : size.height * 0.15,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      letterSpacing: countdown > 0 ? 0.0 : 5.0,
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: Colors.blueAccent.withValues(alpha: 0.9),
                          offset: const Offset(0, 0),
                        ),
                        Shadow(
                          blurRadius: 40.0,
                          color: Colors.cyanAccent.withValues(alpha: 0.8),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Rocket image with a smooth floating effect and a violent shake right before launch, then it blasts off the screen
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000), 
            curve: Curves.easeInOutBack, 
            bottom: isLaunching ? size.height + 200 : 20.0, 
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: Listenable.merge([_floatController, _shakeController]),
              builder: (context, child) {
                // Smooth sine wave floating
                double dy = isLaunching ? 0 : (sin(_floatController.value * pi * 2) * 12);
                // Violent random shaking right before launch
                double dx = _shakeController.isAnimating ? (Random().nextDouble() * 8 - 4) : 0;
                
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
                      Image.asset(
                        selectedSpaceship,
                        fit: BoxFit.contain,
                      ),
                      Align(
                        alignment: const Alignment(0.0, -0.15),
                        child: Container(
                          width: rocketWidth * 0.35, 
                          height: rocketWidth * 0.35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white24, width: 2),
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