import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import 'package:flutter_application_1/pages/b-sfx_manager.dart';
import 'package:flutter_application_1/pages/q_timer_service.dart';


class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with SingleTickerProviderStateMixin {
  late AnimationController _blinkController;
  int totalStar = 0;
  int currentHearts = 3;
  int totalPurchasedHearts = 0;


  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _loadData();
  }


  // Load stars and hearts data
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalStar = prefs.getInt('totalStars') ?? 0;
      currentHearts = prefs.getInt('currentHearts') ?? 3;
      totalPurchasedHearts = prefs.getInt('totalPurchasedHearts') ?? 0;
    });
  }

  Future<void> _saveStars(int newBalance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalStars', newBalance);
  }

  // Save purchased extra lives (hearts)
  Future<void> _saveHearts(int purchasedAmount) async {
    await LivesTimerService.addHearts(purchasedAmount);

    int updatedHearts = await LivesTimerService.getHearts();
 
    setState(() {
      currentHearts = updatedHearts;
      totalPurchasedHearts += purchasedAmount;
    });
  }

  // Save purchased premium spaceship
  Future<void> _saveOwnedSpaceship(String spaceshipPath) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> owned = prefs.getStringList('ownedSpaceships') ?? [];

    if (!owned.contains(spaceshipPath)) {
      owned.add(spaceshipPath);
      await prefs.setStringList('ownedSpaceships', owned);
    }
  }


  void _showDialog(int price, String itemType, {int hearts = 0, String? spaceshipPath}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0D1B2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: itemType == 'hearts'
                  ? Colors.redAccent.withValues(alpha: 0.5)
                  : Colors.cyanAccent.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
          title: Row(
            children: [
              Icon(
                itemType == 'hearts' ? Icons.favorite : Icons.rocket_launch,
                color: itemType == 'hearts' ? Colors.redAccent : Colors.cyanAccent,
              ),
              const SizedBox(width: 10),
              Text(
                itemType == 'hearts' ? 'Buy Hearts' : 'Confirm Purchase',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Russo One',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Spend ⭐ $price?',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              if (itemType == 'hearts') ...[
                const SizedBox(height: 10),
                Text(
                  'Current: $currentHearts ❤️',
                  style: const TextStyle(color: Colors.redAccent),
                ),
                Text(
                  'Total Purchased: $totalPurchasedHearts ❤️',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ],
          ),
          actions: [
            // Purchase Button
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                _buyItem(price, itemType, hearts, spaceshipPath);
              },
              color: Colors.greenAccent,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: const Text('Purchase', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            // Cancel Button
            MaterialButton(
              onPressed: () {
                SfxManager.instance.backButton();  // back button sound effect
                Navigator.pop(context);
              },
              textColor: Colors.white54,
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }


  // Spaceship and extra lives purchases
  void _buyItem(int price, String itemType, int hearts, String? spaceshipPath) {
    if (totalStar >= price) {
      int newBalance = totalStar - price;
      setState(() {totalStar = newBalance;});
      _saveStars(newBalance);

      if (itemType == 'hearts') {
        _saveHearts(hearts);
         SfxManager.instance.claim();  // claim purchase sound effect
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('+$hearts hearts purchased! 💖 Ready for quiz!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
         SfxManager.instance.claim();  // claim purchase sound effect
        _saveOwnedSpaceship(spaceshipPath!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Spaceship purchased! 🚀'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
      }
    } else {
      SfxManager.instance.wrong();  // failed purchase sound effect
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough stars :('),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

Widget _buildGameCurrency({
    required String label,
    required Color themeColor,
    required Widget icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 34,
            constraints: const BoxConstraints(minWidth: 90),
            padding: const EdgeInsets.only(left: 38, right: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0F1E),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: themeColor, width: 1.8),
              boxShadow: [
                BoxShadow(
                  color: themeColor.withValues(alpha: 0.25),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Exo 2',
                  fontSize: 14,
                  letterSpacing: 1,
                  shadows: [
                    Shadow(
                      color: themeColor.withValues(alpha: 0.8),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF0A0F1E),
              shape: BoxShape.circle,
              border: Border.all(color: themeColor, width: 1.8),
              boxShadow: [
                BoxShadow(
                  color: themeColor.withValues(alpha: 0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(child: icon),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(10, 10, 26, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'SHOP',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Russo One',
            fontSize: 18,
            letterSpacing: 3,
            shadows: [Shadow(blurRadius: 12, color: Colors.cyanAccent)],
          ),
        ),
        // back button
        leading: GestureDetector(
          onTap: () {
            SfxManager.instance.backButton(); // sound effect
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0D1B2A),
              border: Border.all(
                color: Colors.cyanAccent.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),

        actions: [
          // Stars balance
          _buildGameCurrency(
            label: '$totalStar',
            themeColor: Colors.cyanAccent,
            icon: const Text('⭐', style: TextStyle(fontSize: 16)),
          ),
          // Hearts balance
          _buildGameCurrency(
            label: '$currentHearts',
            themeColor: Colors.redAccent,
            icon: const Icon(Icons.favorite, color: Colors.redAccent, size: 16),
          ),
          const SizedBox(width: 8),
              ],
            ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _blinkController,
            builder: (context, child) => CustomPaint(
              painter: StarFieldPainter(_blinkController.value),
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.0,
                  colors: [
                    Colors.cyanAccent.withValues(alpha: 0.06),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _sectionLabel(
                  'Premium Spaceships',
                  Colors.cyanAccent,
                  Icons.rocket_launch_rounded,
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Merchandise(
                      imagePath: 'images/premium1.png',
                      price: 3000,
                      onBuy: () {
                        SfxManager.instance.secButton();  // secondary button sound effect
                        _showDialog(
                          3000,
                          'spaceship',
                          spaceshipPath: 'images/premium1.png',
                        );
                      },
                    ),
                    Merchandise(
                      imagePath: 'images/premium2.png',
                      price: 3000,
                      onBuy: () {
                        SfxManager.instance.secButton();
                        _showDialog(
                          3000,
                          'spaceship',
                          spaceshipPath: 'images/premium2.png',
                        );
                      },
                    ),
                    Merchandise(
                      imagePath: 'images/premium3.png',
                      price: 3000,
                      onBuy: () {
                        SfxManager.instance.secButton();
                        _showDialog(
                          3000,
                          'spaceship',
                          spaceshipPath: 'images/premium3.png',
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _sectionLabel(
                  'Extra Lives',
                  Colors.redAccent,
                  Icons.favorite_rounded,
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ExtraLives(
                      imagePath: 'images/extralives2.png',
                      price: 1500,
                      hearts: 2,
                      onBuy: () {
                        SfxManager.instance.secButton();  // secondary button sound effect
                        _showDialog(1500, 'hearts', hearts: 2);
                      },
                    ),
                    ExtraLives(
                      imagePath: 'images/extralives3.png',
                      price: 3000,
                      hearts: 3,
                      onBuy: () {
                        SfxManager.instance.secButton();
                        _showDialog(3000, 'hearts', hearts: 3);
                      },
                    ),
                    ExtraLives(
                      imagePath: 'images/extralives5.png',
                      price: 5000,
                      hearts: 5,
                      onBuy: () {
                        SfxManager.instance.secButton();
                        _showDialog(5000, 'hearts', hearts: 5);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B1120).withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.redAccent.withValues(alpha: 0.4),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withValues(alpha: 0.06),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Quiz Lives',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Russo One',
                              fontSize: 16,
                              shadows: [
                                Shadow(blurRadius: 8, color: Colors.redAccent),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _liveStat(
                            '$currentHearts',
                            'Current',
                            Colors.redAccent,
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 14),
                            color: Colors.white24,
                          ),
                          _liveStat(
                            '$totalPurchasedHearts',
                            'Purchased',
                            Colors.greenAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _liveStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 8, color: color)],
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 11),
        ),
      ],
    );
  }

  Widget _sectionLabel(String title, Color color, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontFamily: 'Russo One',
            fontSize: 18,
            letterSpacing: 1.2,
            shadows: [Shadow(blurRadius: 10, color: color)],
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon, color: color, size: 18),
      ],
    );
  }
}


class ExtraLives extends StatelessWidget {
  final int price;
  final int hearts;
  final VoidCallback onBuy;
  final String imagePath;

  const ExtraLives({
    super.key,
    required this.price,
    required this.hearts,
    required this.onBuy,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBuy,
      child: Column(
        children: [
          Container(
            height: 95,
            width: 95,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.redAccent.withValues(alpha: 0.2),
                  Colors.pink.withValues(alpha: 0.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.redAccent, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(child: Image.asset(imagePath, width: 68, height: 68)),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '+$hearts',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '⭐ $price',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class Merchandise extends StatelessWidget {
  final int price;
  final VoidCallback onBuy;
  final String imagePath;

  const Merchandise({
    super.key,
    required this.price,
    required this.onBuy,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBuy,
      child: Column(
        children: [
          Container(
            height: 95,
            width: 95,
           margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.cyanAccent.withValues(alpha: 0.1),
                  Colors.blueAccent.withValues(alpha: 0.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.cyanAccent.withValues(alpha: 0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(child: Image.asset(imagePath, width: 80, height: 80)),
          ),
          const SizedBox(height: 4),
          Text(
            '⭐ $price',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
        ],
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