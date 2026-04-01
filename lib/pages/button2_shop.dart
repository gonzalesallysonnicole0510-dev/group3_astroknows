import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int totalStar = 0;

  @override
  void initState() {
    super.initState();
    _loadStars();
  }

  // New Logic: Load stars from local storage
  Future<void> _loadStars() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalStar = prefs.getInt('totalStars') ?? 0;
    });
  }

  // New Logic: Save stars to local storage
  Future<void> _saveStars(int newBalance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalStars', newBalance);
  }

  void _showDialog(int price) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Purchase'),
          content: Text('Spend $price ⭐?'),
          actions: [
            // Purchase Button
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                buyItem(price);
              },
              child: const Text('Purchase'),
            ),
            // Cancel Button
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void buyItem(int price) {
    if (totalStar >= price) {
      int newBalance = totalStar - price;
      setState(() {
        totalStar = newBalance;
      });
      _saveStars(newBalance); // Keeps memory updated

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Purchase Successful ⭐'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
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
        // Old Layout: Back Arrow Circle Styling
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.lightBlueAccent,
                width: 1,
              ),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        // Old Layout: Star Currency Pill Design
        actions: [
          Container(
            height: 30,
            width: 110,
            margin: const EdgeInsets.only(right: 25, top: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade800,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.lightBlue,
                width: 1,
              ),
            ),
            child: Text(
              '⭐ $totalStar',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // Row 1: Premium Spaceships
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Merchandise(
                  imagePath: 'images/premium1.png',
                  price: 3000,
                  onBuy: () => _showDialog(3000),
                ),
                Merchandise(
                  imagePath: 'images/premium2.png',
                  price: 3000,
                  onBuy: () => _showDialog(3000),
                ),
                Merchandise(
                  imagePath: 'images/premium3.png',
                  price: 3000,
                  onBuy: () => _showDialog(3000),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Row 2: Extra Lives
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExtraLives(
                  imagePath: 'images/live1.png',
                  price: 3000,
                  onBuy: () => _showDialog(3000),
                ),
                ExtraLives(
                  imagePath: 'images/lives2.png',
                  price: 5000,
                  onBuy: () => _showDialog(5000),
                ),
                ExtraLives(
                  imagePath: 'images/lives3.png',
                  price: 7000,
                  onBuy: () => _showDialog(7000),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- Old Layout Helper Widgets Restored ---

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
              child: Image.asset(
                imagePath,
                width: 55,
                height: 55,
              ),
            ),
          ),
          Text(
            '⭐ $price',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class ExtraLives extends StatelessWidget {
  final int price;
  final VoidCallback onBuy;
  final String imagePath;

  const ExtraLives({
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
              child: Image.asset(
                imagePath,
                width: 50,
                height: 50,
              ),
            ),
          ),
          Text(
            '⭐ $price',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}