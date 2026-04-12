import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'button2_shop.dart';

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

          // 3. Main HUD Interface
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                // FittedBox ensures that if the screen is too small, it scales down instead of overflowing
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 480, // Widened to fit text comfortably
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        // Glassmorphism effect: Blurs the space background behind the panel
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 40.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D121A).withValues(alpha: 0.75),
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
                            mainAxisSize: MainAxisSize.min, // Hugs content, preventing stretching
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildHUDHeader(),
                              SizedBox(height: screenHeight * 0.035),
                              
                              // Warning Icon Section
                              _buildStatusIcon(screenWidth),
                              
                              SizedBox(height: screenHeight * 0.035),
                              
                              // Mission Failed Text
                              _buildMissionText(screenWidth),
                              
                              SizedBox(height: screenHeight * 0.05),
                              
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
              letterSpacing: 3,
              fontSize: 13,
              fontFamily: 'Roboto', 
            ),
          ),
        ),
        _hudCorner(1),
      ],
    );
  }

  Widget _buildStatusIcon(double screenWidth) {
    double iconContainerSize = 90; // Fixed size for consistency
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

  Widget _buildMissionText(double screenWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'SHIP DAMAGE DETECTED!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Don't worry, Astroknowt! Every great explorer faces turbulence.\nLet's repair the ship and get back to exploring the cosmos!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 15,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, double screenWidth, double screenHeight) {
    double buttonHeight = 55; // Fixed height for better touch targets and consistency across devices

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: ElevatedButton.icon(
            onPressed: () {
              // Navigate to the shop page where players can buy repairs and upgrades
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShopPage()),
              );
            },
            icon: const Icon(Icons.build_circle_outlined, size: 24),
            label: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "VISIT REPAIR BAY",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E5FF),
              foregroundColor: const Color(0xFF040B14), 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              shadowColor: const Color(0xFF00E5FF).withValues(alpha: 0.5),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: OutlinedButton.icon(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.home_rounded, size: 20),
            label: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "RETURN TO BASE",
                style: TextStyle(
                  fontSize: 16,
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
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(color: Color(0xFF00E5FF), width: 2.5),
          left: side == 0 ? const BorderSide(color: Color(0xFF00E5FF), width: 2.5) : BorderSide.none,
          right: side == 1 ? const BorderSide(color: Color(0xFF00E5FF), width: 2.5) : BorderSide.none,
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
    final Random random = Random(42); 
    final Paint paint = Paint();

    for (int i = 0; i < 120; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double s = random.nextDouble() * 2.0;
      
      double opacity = (i % 2 == 0) ? blink : (1.0 - (blink * 0.5));
      paint.color = Colors.white.withValues(alpha: opacity.clamp(0.1, 0.9));
      
      canvas.drawCircle(Offset(x, y), s, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarFieldPainter oldDelegate) => true;
}