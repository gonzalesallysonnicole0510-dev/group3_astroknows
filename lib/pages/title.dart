import 'dart:math';
import 'button0_charac.dart';
import 'button1_solarscreen.dart';
import 'button2_shop.dart';
import 'button3_settings.dart';
import 'package:flutter/material.dart';

class TitlePage extends StatefulWidget {
  final String astroknowt;
  const TitlePage({super.key, required this.astroknowt});


  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> with SingleTickerProviderStateMixin {
  late AnimationController _blinkController;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  void refreshCharacter() {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(10, 10, 26, 1.0),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _blinkController,
            builder: (context, child) {
              return CustomPaint(
                painter: StarFieldPainter(_blinkController.value),
                size: Size(screenWidth, screenHeight),
              );
            },
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.05, left: screenWidth * 0.05),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: _buildCharacterButton(context, screenHeight),
                ),
              ),
              const Spacer(),
              FittedBox(
                child: Text(
                  'ASTROKNOWS',
                  style: TextStyle(
                    fontFamily: 'Michroma',
                    color: Colors.white,
                    fontSize: screenHeight * 0.14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8.0,
                    shadows: [
                      Shadow(blurRadius: 25, color: Colors.cyan.withValues(alpha: 0.8)),
                      Shadow(blurRadius: 10, color: Colors.cyanAccent),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              _buildMainButton(
                context,
                label: 'LAUNCH OFF',
                width: screenWidth * 0.40,
                height: screenHeight * 0.13,
              ),
              SizedBox(height: screenHeight * 0.04),
              _buildSecondaryButton(
                context,
                label: 'SHOP',
                destination: const ShopPage(),
                width: screenWidth * 0.34,
                height: screenHeight * 0.10,
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildSecondaryButton(
                context,
                label: 'SETTINGS',
                destination: const SettingsPage(),
                width: screenWidth * 0.34,
                height: screenHeight * 0.10,
              ),
              const Spacer(flex: 2),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildMainButton(BuildContext context,
      {required String label, required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.5),
        boxShadow: [
          BoxShadow(color: Colors.orange.withValues(alpha: 0.5), blurRadius: 15, spreadRadius: 1),
        ],
        gradient: const LinearGradient(
          colors: [Color(0xFFFFA726), Color(0xFFFF3D00)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SolarSystemInterface())),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: const StadiumBorder(),
        ),
        child: FittedBox(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Russo One',
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildSecondaryButton(BuildContext context,
      {required String label, required Widget destination, required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.5),
        border: Border.all(color: Colors.cyan.withValues(alpha: 0.8), width: 2),
        color: const Color(0xFF15152D),
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: const StadiumBorder(),
        ),
        child: FittedBox(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Exo 2',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterButton(BuildContext context, double h) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) => CharacCustPage(type: CustomizationType.astroknowt)));
        refreshCharacter();
      },
      child: Container(
        width: h * 0.15,
        height: h * 0.15,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.cyan, width: 2),
          boxShadow: [BoxShadow(color: Colors.cyan.withValues(alpha: 0.4), blurRadius: 10)],
        ),
        child: Image.asset(widget.astroknowt),
        // child: const CircleAvatar(
        //   backgroundColor: Colors.black26,
        //   child: Icon(Icons.person, color: Colors.white),
        // ),
      ),
    );
  }
}

class StarFieldPainter extends CustomPainter {
  final double blinkValue;
  StarFieldPainter(this.blinkValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Random random = Random(42);
    final paint = Paint();
    for (int i = 0; i < 100; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double starSize = 0.5 + (random.nextDouble() * 2.0);
      double opacity;
      if (i % 3 == 0) {
        opacity = 0.1 + (blinkValue * 0.9);
      } else if (i % 3 == 1) {
        opacity = 1.0 - (blinkValue * 0.9);
      } else {
        opacity = 0.4;
      }
      paint.color = Colors.white.withValues(alpha: opacity);
      canvas.drawCircle(Offset(x, y), starSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarFieldPainter oldDelegate) =>
      oldDelegate.blinkValue != blinkValue;
}