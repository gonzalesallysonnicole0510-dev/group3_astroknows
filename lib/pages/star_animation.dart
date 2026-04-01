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
  final List<Star> stars = List.generate(200, (i) => Star());

  @override
  void initState() {
    super.initState();
    // Using a 1-second duration and repeating it creates a constant 60fps loop
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
          // Update star positions every frame
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

  Star() : x = _randomRange(), y = _randomRange(), z = Random().nextDouble() {
    prevZ = z;
  }

  static double _randomRange() => Random().nextDouble() * 2 - 1;

  void update() {
    prevZ = z;
    z -= 0.009; // Increase this for "Hyperdrive" speed
    if (z <= 0) {
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
    final paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    for (var star in stars) {
      // Current position
      double sx = (star.x / star.z) * centerX + centerX;
      double sy = (star.y / star.z) * centerY + centerY;

      // Previous position (for the "warp" streak effect)
      double px = (star.x / star.prevZ) * centerX + centerX;
      double py = (star.y / star.prevZ) * centerY + centerY;

      // Only draw if within screen bounds
      if (sx >= 0 && sx <= size.width && sy >= 0 && sy <= size.height) {
        // Drawing a line from previous Z to current Z creates the "stretch"
        canvas.drawLine(Offset(px, py), Offset(sx, sy), paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
