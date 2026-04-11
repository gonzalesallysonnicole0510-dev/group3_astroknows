import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/pages/button0_charac.dart';
import 'title.dart';

class AchievementPage extends StatefulWidget {
  final int star;
  final String planet;
  const AchievementPage({super.key, required this.star, required this.planet});

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage>
    with SingleTickerProviderStateMixin {
  // Local state to handle data instead of globals
  int totalStar = 0;
  List<String> claimedQuizzes = [];
  late int rewardStar;
  late AnimationController _starController;
  late String normalizedPlanetName;

  @override
  void initState() {
    super.initState();

    normalizedPlanetName = widget.planet.toLowerCase().trim();
    rewardStar = widget.star; // Default until check is done

    // Star twinkling effect background
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _loadData();
  }

  // Fetch current stats from storage
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalStar = prefs.getInt('totalStars') ?? 0;
      claimedQuizzes = prefs.getStringList('claimedQuizzes') ?? [];

      // Check if they already claimed this planet's reward
      if (claimedQuizzes.contains(normalizedPlanetName)) {
        rewardStar = 100;
      }
    });
  }

  @override
  void dispose() {
    _starController.dispose();
    super.dispose();
  }

  Future<void> claimPoints() async {
    if (rewardStar == 0) return;

    final prefs = await SharedPreferences.getInstance();
    int pointsToClaim = rewardStar;

    setState(() {
      totalStar += pointsToClaim;
      claimedQuizzes.add(normalizedPlanetName);
      rewardStar = 0; // Prevent double claiming in the same session
    });

    // Save updated data to storage
    await prefs.setInt('totalStars', totalStar);
    await prefs.setStringList('claimedQuizzes', claimedQuizzes);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star_rounded, color: Colors.amber),
              const SizedBox(width: 8),
              Text(
                '$pointsToClaim Claimed!',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
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
          // Deep Space Gradient Background
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

          // Animated Star Field
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

          // Main HUD Interface - Made flexible with SingleChildScrollView
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500, // Prevents stretching on tablets/web
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
                            color: const Color(0xFF00E5FF)
                                .withValues(alpha: 0.15),
                            blurRadius: 25,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildHUDHeader(),
                          SizedBox(height: screenHeight * 0.03),

                          // Alien & Message Section
                          _buildTransmission(screenWidth, screenHeight),

                          SizedBox(height: screenHeight * 0.03),

                          // Reward Display
                          _buildRewardBadge(screenWidth),

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
            "MISSION ACCOMPLISHED",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF00E5FF),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 12,
            ),
          ),
        ),
        _hudCorner(1),
      ],
    );
  }


  Widget _buildTransmission(double screenWidth, double screenHeight) {
    double avatarSize = screenWidth * 0.2;
    // Cap the max size of the avatar
    if (avatarSize > 100) avatarSize = 100;
    if (avatarSize < 60) avatarSize = 60;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Alien Avatar
          Container(
            height: avatarSize,
            width: avatarSize,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00E5FF).withValues(alpha: 0.1),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00E5FF).withValues(alpha: 0.2),
                    blurRadius: 15,
                  )
                ]),
            child: Image.asset(
              'images/alien.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          // Transmission Text
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Great Job, Astroknowt!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth < 360 ? 14 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "You successfully completed the ${widget.planet} sector. Take this reward I've prepared for you!",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: screenWidth < 360 ? 12 : 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildRewardBadge(double screenWidth) {
    bool isClaimed = rewardStar == 0;
    double paddingHorizontal = screenWidth * 0.06;
    double paddingVertical = paddingHorizontal / 2;

    return TweenAnimationBuilder(
      tween: Tween(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal, vertical: paddingVertical),
            decoration: BoxDecoration(
              color: isClaimed
                  ? Colors.grey.withValues(alpha: 0.2)
                  : Colors.amber.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isClaimed
                    ? Colors.grey.withValues(alpha: 0.5)
                    : Colors.amber.withValues(alpha: 0.5),
                width: 2,
              ),
              boxShadow: isClaimed
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.amber.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 1,
                      )
                    ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isClaimed ? Icons.check_circle_rounded : Icons.star_rounded,
                  color: isClaimed ? Colors.grey : Colors.amber,
                  size: screenWidth < 360 ? 28 : 40,
                ),
                SizedBox(width: screenWidth * 0.03),
                Text(
                  isClaimed ? "CLAIMED" : "+ $rewardStar",
                  style: TextStyle(
                    color: isClaimed ? Colors.grey : Colors.amber,
                    fontSize: screenWidth < 360 ? 20 : 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildActionButtons(BuildContext context, double screenWidth, double screenHeight) {
    bool canClaim = rewardStar > 0;
    double buttonHeight = screenHeight * 0.06;
    if (buttonHeight < 45) buttonHeight = 45; // Minimum touch target size
    if (buttonHeight > 60) buttonHeight = 60; // Max cap

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: ElevatedButton.icon(
            onPressed: canClaim ? claimPoints : null,
            icon: Icon(
                canClaim ? Icons.auto_awesome_rounded : Icons.lock_rounded,
                size: screenWidth < 360 ? 20 : 24),
            label: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                canClaim ? "CLAIM REWARD" : "REWARD SECURED",
                style: TextStyle(
                  fontSize: screenWidth < 360 ? 14 : 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              disabledBackgroundColor: Colors.grey.shade800,
              disabledForegroundColor: Colors.grey.shade400,
              foregroundColor: const Color(0xFF040B14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: canClaim ? 6 : 0,
              shadowColor: Colors.amber.withValues(alpha: 0.5),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        SizedBox(
          width: double.infinity,
          height: buttonHeight * 0.9,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => TitlePage(astroknowt: selectedAstroknowt)),
              );
            },
            icon: Icon(Icons.rocket_launch_rounded, size: screenWidth < 360 ? 18 : 20),
            label: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "MAIN MENU",
                style: TextStyle(
                  fontSize: screenWidth < 360 ? 12 : 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white.withValues(alpha: 0.85),
              side: BorderSide(
                  color: Colors.white.withValues(alpha: 0.25), width: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
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
          left: side == 0
              ? const BorderSide(color: Color(0xFF00E5FF), width: 2)
              : BorderSide.none,
          right: side == 1
              ? const BorderSide(color: Color(0xFF00E5FF), width: 2)
              : BorderSide.none,
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