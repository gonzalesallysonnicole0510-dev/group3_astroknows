import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/q_timer_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz_game.dart';
import 'dart:math' as math;

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int totalStar = 10000;
  int currentHearts = 5;
  int totalPurchasedHearts = 0;


  @override
  void initState() {
    super.initState();
    _loadData();
  }


  // Load stars and hearts data
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalStar = prefs.getInt('totalStars') ?? 10000;
      currentHearts = prefs.getInt('currentHearts') ?? 5;
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

    List<String> owned =
        prefs.getStringList('ownedSpaceships') ?? [];

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
          backgroundColor: Color(0xFF131B26),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(
                itemType == 'hearts' ? Icons.favorite : Icons.rocket_launch,
                color: itemType == 'hearts' ? Colors.redAccent : Colors.cyanAccent,
              ),
              SizedBox(width: 10),
              Text(
                itemType == 'hearts' ? 'Buy Hearts' : 'Confirm Purchase',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Spend ⭐ $price?',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              if (itemType == 'hearts') ...[
                SizedBox(height: 10),
                Text(
                  'Current: $currentHearts ❤️',
                  style: TextStyle(color: Colors.redAccent),
                ),
                Text(
                  'Total Purchased: $totalPurchasedHearts ❤️',
                  style: TextStyle(color: Colors.white70),
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
              onPressed: () => Navigator.pop(context),
              textColor: Colors.white70,
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
      setState(() {
        totalStar = newBalance;
      });
      _saveStars(newBalance);

      if (itemType == 'hearts') {
        _saveHearts(hearts);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('+$hearts hearts purchased! 💖 Ready for quiz!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not Enough Stars :('),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.lightBlueAccent, width: 1),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        // stars and hearts
        actions: [
          // Stars balance
          Container(
            height: 30,
            width: 110,
            margin: const EdgeInsets.only(right: 10, top: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade800,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.lightBlue, width: 1),
            ),
            child: Text(
              '⭐ $totalStar',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          // Hearts balance
          Container(
            height: 30,
            width: 90,
            margin: const EdgeInsets.only(right: 15, top: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.redAccent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.redAccent, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite, color: Colors.redAccent, size: 16),
                SizedBox(width: 4),
                Text('$currentHearts', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Hearts Status Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                color: Color(0xFF131B26),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.redAccent.withValues(alpha: 0.5),
                  width: 1
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.redAccent, size: 28),
                      SizedBox(width: 10),
                      Text(
                        'Quiz Lives',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '$currentHearts',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                              ),
                            ),
                          Text(
                            'Current',
                            style: TextStyle(
                              color: Colors.white70
                              ),
                            ),
                        ],
                      ),
                      Text(
                        '|',
                        style: TextStyle(
                          color: Colors.white70
                          ),
                        ),
                      Column(
                        children: [
                          Text(
                            '$totalPurchasedHearts',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                              ),
                            ),
                          Text(
                            'Purchased',
                            style: TextStyle(
                              color: Colors.white70
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Premium Spaceships
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Merchandise(
                  imagePath: 'images/premium1_ufo.png',
                  price: 3000,
                  onBuy: () => _showDialog(3000, 'spaceship', spaceshipPath: 'images/premium1_ufo.png'),
                ),
                Merchandise(
                  imagePath: 'images/premium2.png',
                  price: 3000,
                  onBuy: () => _showDialog(3000, 'spaceship', spaceshipPath: 'images/premium2.png'),
                ),
                Merchandise(
                  imagePath: 'images/premium3.png',
                  price: 3000,
                  onBuy: () => _showDialog(3000, 'spaceship', spaceshipPath: 'images/premium3.png'),
                ),
              ],
            ),
            SizedBox(height: 40),

            // Extra Lives
            Text(
              'Extra Lives for Quiz',
              style: TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExtraLives(
                  imagePath: 'images/livesx2.png',
                  price: 1500,
                  hearts: 2,
                  onBuy: () => _showDialog(1500, 'hearts', hearts: 2),
                ),
                ExtraLives(
                  imagePath: 'images/livesx3.png',
                  price: 3000,
                  hearts: 3,
                  onBuy: () => _showDialog(3000, 'hearts', hearts: 3),
                ),
                ExtraLives(
                  imagePath: 'images/livesx5.png',
                  price: 5000,
                  hearts: 5,
                  onBuy: () => _showDialog(5000, 'hearts', hearts: 5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// ExtraLives
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
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.redAccent.withValues(alpha: 0.2), Colors.pink.withValues(alpha: 0.1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.redAccent,
                width: 2
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    imagePath,
                    width: 70,
                    height: 70
                    ),
                  ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '+$hearts',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '⭐ $price',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15
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
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Image.asset(imagePath, width: 88, height: 88),
            ),
          ),
          Text(
            '⭐ $price',
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}