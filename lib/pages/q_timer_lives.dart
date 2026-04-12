import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/q_timer_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LivesTimerPage extends StatefulWidget {
  final VoidCallback onFinished;

  const LivesTimerPage({super.key, required this.onFinished});

  @override
  State<LivesTimerPage> createState() => _HeartTimerPageState();
}

class _HeartTimerPageState extends State<LivesTimerPage>
    with SingleTickerProviderStateMixin {
  
  int remainingMs = 0;
  bool isLoading = true; // Added to hide the 0:00 flash during initial load
  Timer? timer;

  late AnimationController _starController;

  @override
  void initState() {
    super.initState();
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    startTimer();
  }

  void startTimer() async {
    // 1. Fetch the initial time immediately
    int initialRemaining = await LivesTimerService.getRemainingTime();
    
    if (!mounted) return;

    // 2. Update state right away so the UI skips the 0:00 start
    setState(() {
      remainingMs = initialRemaining;
      isLoading = false;
    });

    // Handle immediate finish if time is already up
    if (initialRemaining <= 0) {
      Navigator.pop(context);
      return;
    }

    // 3. Start the periodic timer for the countdown
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      int newRemaining = await LivesTimerService.getRemainingTime();

      if (!mounted) return;

      setState(() {
        remainingMs = newRemaining;
      });

      // auto closes when timer reach 00:00
      if (newRemaining <= 0) {
        timer?.cancel();
        Navigator.pop(context); // allow quiz
      }
    });
  }

  // Format timer into minutes and seconds (00:00)
  String formatTime(int ms) {
    if (ms <= 0) return "0:00"; // Prevent negative numbers if there's lag
    int seconds = (ms / 1000).floor();
    int minutes = seconds ~/ 60;
    seconds = seconds % 60;

    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    timer?.cancel();
    _starController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.height < 700;

    return Scaffold(
      backgroundColor: const Color(0xFF040B14),
      body: Stack(
        children: [

          // Background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [Color(0xFF1A1438), Color(0xFF040B14)],
                ),
              ),
            ),
          ),

          // Stars
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _starController,
              builder: (_, __) {
                return CustomPaint(
                  painter: StarFieldPainter(_starController.value),
                );
              },
            ),
          ),

          // UI BOX
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: isSmallScreen ? 20 : 30,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF0D121A).withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.redAccent.withValues(alpha: 0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withValues(alpha: 0.3),
                    blurRadius: 25,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: 60,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "NO LIVES LEFT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Display calculating status or the actual timer
                  Text(
                    isLoading ? "Calculating..." : "Refill in ${formatTime(remainingMs)}",
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Your ship is repairing...",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 20 : 30),
                  _buildActionButtons(context, isSmallScreen),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildActionButtons(BuildContext context, bool isSmallScreen) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        // width: double.infinity,
        height: isSmallScreen ? 45 : 55,
        child: OutlinedButton.icon(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.home_rounded, size: 20),
          label: Text(
            "RETURN",
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16, 
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white.withValues(alpha: 0.85),
            side: BorderSide(color: Colors.white.withValues(alpha: 0.25), width: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
    ],
  );
}

class StarFieldPainter extends CustomPainter {
  final double blink;
  StarFieldPainter(this.blink);

  @override
  void paint(Canvas canvas, Size size) {
    final Random random = Random(42); // Fixed seed so stars don't jump around
    final Paint paint = Paint();

    for (int i = 0; i < 120; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double s = random.nextDouble() * 2.0;
      
      // Makes half the stars pulse and the other half stay mostly solid
      double opacity = (i % 2 == 0) ? blink : (1.0 - (blink * 0.5));
      paint.color = Colors.white.withValues(alpha: opacity.clamp(0.1, 0.9));
      
      canvas.drawCircle(Offset(x, y), s, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarFieldPainter oldDelegate) => true;
}