import 'dart:math';
import 'package:flutter/material.dart';
import 'button2_shop.dart'; // Imported the shop page


class MissionFailedPage extends StatefulWidget {
  const MissionFailedPage({super.key});


  @override
  State<MissionFailedPage> createState() => _MissionFailedPageState();
}


class _MissionFailedPageState extends State<MissionFailedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;


  @override
  void initState() {
    super.initState();
    // Star twinkling effect
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
  }


  @override
  void dispose() {
    _starController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // Implementing flexible MediaQuery sizing
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: const Color(0xFF040B14),
      body: Stack(
        children: [
          // 1. Deep Space Gradient Background
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


          // 2. Animated Star Field
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _starController,
              builder: (context, child) {
                return CustomPaint(
                  painter: StarFieldPainter(_starController.value),
                );
              },
            ),
          ),


          // 3. Main HUD Interface - Made flexible with SingleChildScrollView
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 450, // Limits width on tablets
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                          vertical: screenHeight * 0.04),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D121A).withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFF00E5FF).withValues(alpha: 0.4),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00E5FF).withValues(alpha: 0.15),
                            blurRadius: 25,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Hugs the content tightly
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildHUDHeader(),
                          SizedBox(height: screenHeight * 0.03),
                         
                          // Warning Icon Section
                          _buildStatusIcon(screenWidth),
                         
                          SizedBox(height: screenHeight * 0.03),
                         
                          // Mission Failed Text
                          _buildMissionText(screenWidth, screenHeight),
                         
                          SizedBox(height: screenHeight * 0.04),
                         
                          // Action Buttons
                          _buildActionButtons(context, screenWidth, screenHeight),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildHUDHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _hudCorner(0),
        const Expanded(
          child: Text(
            "SYSTEM ALERT",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF00E5FF),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 12,
              fontFamily: 'Roboto', // Fallback, use Michroma if you have it in pubspec
            ),
          ),
        ),
        _hudCorner(1),
      ],
    );
  }


  Widget _buildStatusIcon(double screenWidth) {
    double iconContainerSize = screenWidth * 0.25;
    // Enforce limits to keep it looking sharp
    if (iconContainerSize > 110) iconContainerSize = 110;
    if (iconContainerSize < 70) iconContainerSize = 70;
   
    double iconSize = iconContainerSize * 0.6;


    return TweenAnimationBuilder(
      tween: Tween(begin: 0.9, end: 1.1),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOutSine,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: iconContainerSize,
                height: iconContainerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFF3D00).withValues(alpha: 0.15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF3D00).withValues(alpha: 0.3),
                      blurRadius: 20,
                    ),
                  ]
                ),
              ),
              Icon(
                Icons.warning_amber_rounded,
                color: const Color(0xFFFF3D00),
                size: iconSize,
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildMissionText(double screenWidth, double screenHeight) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'SHIP DAMAGE DETECTED!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth < 360 ? 18 : 24,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        Text(
          "Don't worry, Astroknowt! Every great explorer faces turbulence.\nLet's repair the ship and get back to exploring the cosmos!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: screenWidth < 360 ? 12 : 15,
            height: 1.4,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }


  Widget _buildActionButtons(BuildContext context, double screenWidth, double screenHeight) {
    double buttonHeight = screenHeight * 0.06;
    if (buttonHeight < 45) buttonHeight = 45; // Minimum target size
    if (buttonHeight > 60) buttonHeight = 60; // Max cap


    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: ElevatedButton.icon(
            onPressed: () {
              // Action for repair: Navigate to the ShopPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShopPage()),
              );
            },
            icon: Icon(Icons.build_circle_outlined, size: screenWidth < 360 ? 20 : 24),
            label: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "REPAIR & RETRY",
                style: TextStyle(
                  fontSize: screenWidth < 360 ? 14 : 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E5FF),
              foregroundColor: const Color(0xFF040B14), // Dark text for high contrast
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              shadowColor: const Color(0xFF00E5FF).withValues(alpha: 0.5),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        SizedBox(
          width: double.infinity,
          height: buttonHeight * 0.9,
          child: OutlinedButton.icon(
            onPressed: () => Navigator.maybePop(context),
            icon: Icon(Icons.home_rounded, size: screenWidth < 360 ? 18 : 20),
            label: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "RETURN TO BASE",
                style: TextStyle(
                  fontSize: screenWidth < 360 ? 12 : 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
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


  Widget _hudCorner(int side) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(color: Color(0xFF00E5FF), width: 2),
          left: side == 0 ? const BorderSide(color: Color(0xFF00E5FF), width: 2) : BorderSide.none,
          right: side == 1 ? const BorderSide(color: Color(0xFF00E5FF), width: 2) : BorderSide.none,
        ),
      ),
    );
  }
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


