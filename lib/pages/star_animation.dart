import 'dart:math';
import 'package:flutter/material.dart';


void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpaceWarpScreen(),
    ),
  );
}

class SpaceWarpScreen extends StatefulWidget {
  const SpaceWarpScreen({super.key});

  @override
  State<SpaceWarpScreen> createState() => _SpaceWarpScreenState();
}

class _SpaceWarpScreenState extends State<SpaceWarpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Star> stars = List.generate(150, (i) => Star());

  @override
  void initState() {
    super.initState();
   
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          for (var star in stars) {
            star.update();
          }
          return CustomPaint(
            painter: StarFieldPainter(stars),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class Star {
  double x, y, z;
  late double prevZ;
 
  // Adjust this value to make the ship feel like it's moving faster or slower
  final double speed = 0.015;

  Star() : x = _randomRange(), y = _randomRange(), z = Random().nextDouble() {
    prevZ = z;
  }

  static double _randomRange() => Random().nextDouble() * 2 - 1;

  void update() {
    prevZ = z;
    z -= speed;
   
    // Reset the star when it passes the camera (z <= 0)
    if (z <= 0.01) {
      z = 1.0;
      prevZ = z;
      x = _randomRange();
      y = _randomRange();
    }
  }
}


class StarFieldPainter extends CustomPainter {
  final List<Star> stars;
  StarFieldPainter(this.stars);


  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    // By shifting the projection center up slightly, it can align better with
    // the top-down perspective of your rocket. You can adjust the offset if needed.
    final centerY = size.height / 2;

    for (var star in stars) {
      // Current position projection
      double sx = (star.x / star.z) * centerX + centerX;
      double sy = (star.y / star.z) * centerY + centerY;


      // Previous position projection (creates the stretch/trail)
      double px = (star.x / star.prevZ) * centerX + centerX;
      double py = (star.y / star.prevZ) * centerY + centerY;


      // Only draw if within bounds
      if (sx >= 0 && sx <= size.width && sy >= 0 && sy <= size.height) {
       
        // Depth-based Opacity: Fades in from the distance
        double opacity = (1 - star.z).clamp(0.0, 1.0);
       
        // Depth-based Thickness: Gets thicker as it gets closer
        double thickness = (1 - star.z) * 3 + 0.5;


        final paint = Paint()
          ..color = Colors.white.withValues(alpha: opacity)
          ..strokeCap = StrokeCap.round
          ..strokeWidth = thickness;


        canvas.drawLine(Offset(px, py), Offset(sx, sy), paint);
      }
    }
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}