import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/b-sfx_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/pages/button0_charac.dart';
import 'title.dart';

class AccomplishedPage extends StatefulWidget {
  final int star;
  final String planet;
  const AccomplishedPage({super.key, required this.star, required this.planet});

  @override
  State<AccomplishedPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AccomplishedPage>
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
        rewardStar = 0; // Set to 0 if already claimed to trigger "CLAIMED" state
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

          // 3. Main HUD Interface - No scrolling, perfectly scaled
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 480, // Optimized width for text & layout
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        // Glassmorphism effect
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
                              const SizedBox(height: 32),

                              // Alien & Message Section
                              _buildTransmission(),

                              const SizedBox(height: 32),

                              // Reward Display
                              _buildRewardBadge(),

                              const SizedBox(height: 40),

                              // Action Buttons
                              _buildActionButtons(context),
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
            "MISSION ACCOMPLISHED",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF00E5FF),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 13,
            ),
          ),
        ),
        _hudCorner(1),
      ],
    );
  }

  Widget _buildTransmission() {
    double avatarSize = 80; // Fixed size, FittedBox will scale it naturally

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Alien Companion
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
          const SizedBox(width: 20),
          // Transmission Text
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Great Job, Astroknowt!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "You successfully completed the ${widget.planet} sector. Take this reward I've prepared for you!",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
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

  Widget _buildRewardBadge() {
    bool isClaimed = rewardStar == 0;

    return TweenAnimationBuilder(
      tween: Tween(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 14.0),
            decoration: BoxDecoration(
              color: isClaimed
                  ? Colors.grey.withValues(alpha: 0.2)
                  : Colors.amber.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(24),
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
                  size: 36,
                ),
                const SizedBox(width: 12),
                Text(
                  isClaimed ? "CLAIMED" : "+ ${widget.star}", // Display original star value even if claimed internal state is 0
                  style: TextStyle(
                    color: isClaimed ? Colors.grey : Colors.amber,
                    fontSize: 28,
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

  Widget _buildActionButtons(BuildContext context) {
    bool canClaim = rewardStar > 0;
    double buttonHeight = 55; // Fixed reasonable height

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: ElevatedButton.icon(
            onPressed: canClaim
                ? () {
                    SfxManager.instance.claim();
                    claimPoints(); // ✅ CALL it properly
                  }
                : null,
            icon: Icon(
                canClaim ? Icons.auto_awesome_rounded : Icons.lock_rounded,
                size: 24),
            label: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                canClaim ? "CLAIM REWARD" : "REWARD SECURED",
                style: const TextStyle(
                  fontSize: 17,
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
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: OutlinedButton.icon(
            onPressed: () {
              SfxManager.instance.secButton();  // secondary button sound effect
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        TitlePage(astroknowt: selectedAstroknowt)),
              );
            },
            icon: const Icon(Icons.rocket_launch_rounded, size: 20),
            label: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "MAIN MENU",
                style: TextStyle(
                  fontSize: 16,
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
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(color: Color(0xFF00E5FF), width: 2.5),
          left: side == 0
              ? const BorderSide(color: Color(0xFF00E5FF), width: 2.5)
              : BorderSide.none,
          right: side == 1
              ? const BorderSide(color: Color(0xFF00E5FF), width: 2.5)
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