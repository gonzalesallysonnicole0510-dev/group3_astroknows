import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/button0_charac.dart';
import 'title.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenIntro(),
    );
  }
}

class SplashScreenIntro extends StatefulWidget {
  const SplashScreenIntro({super.key});

  @override
  State<SplashScreenIntro> createState() => _SplashScreenIntroState();
}

class _SplashScreenIntroState extends State<SplashScreenIntro> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and animations
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Fade in from 0% to 100% opacity and scale from 80% to 100% size
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
      ),
    );

    // Listen for when the animation completes to navigate to the next screen
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TitlePage(astroknowt: selectedAstroknowt)),
        );
      }
    });

    // Start the animation/timer
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D1925),
              Color(0xFF1A1025),
              Color(0xFF050810),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  // Glowing Logo
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.withValues(alpha: 0.15),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'images/transicon.png',
                      width: 130,
                      height: 130,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Title
                  const Text(
                    'ASTROKNOWS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                      shadows: [
                        Shadow(
                          color: Colors.blueAccent,
                          blurRadius: 15.0,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Animated Progress Bar and Percentage
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      // Calculate percentage from 0 to 100
                      int percentage = (_controller.value * 100).toInt();

                      return Column(
                        children: [
                          // Progress Bar
                          SizedBox(
                            width: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: _controller.value,
                                backgroundColor: Colors.white.withValues(alpha: 0.1),
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                                minHeight: 6,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Dynamic Percentage Text
                          Text(
                            'Initializing... $percentage%',
                            style: const TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
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
}