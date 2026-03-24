import 'package:flutter/material.dart';

int totalStar = 0;
Set<String> claimedQuizzes = {};

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});


  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  void _showDialog (int price) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Purchase'),
          content: Text ('Spend $price ⭐?'),
          actions: [

            // Purchase Button
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                buyItem(price);
              },
              child: Text('Purchase'),
            ),

            // Cancel Button
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }


  void buyItem(int price) {
  if (totalStar >= price) {
    setState(() {
      totalStar -= price;
    });


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Purchase Successful ⭐'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1)
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Not Enough Stars :('),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1)
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
         
          // Back Arrow Button
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
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                ),
            ),
          ),

          // Star Currency/Points
          actions: [
            Container(
              height: 30,
              width: 110,
              margin: EdgeInsets.only(right: 25, top: 5),
              alignment: Alignment.center,


              decoration: BoxDecoration(
                color: Colors.blueGrey.shade800,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.lightBlue,
                  width: 1,
                )
              ),
              child: Text(
                '⭐ $totalStar',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ),
          ],
        ),


      body: Center(
        child: Column(
          children: [

            // Premium Spaceships
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Merchandise(
                  imagePath: 'images/premium1.png',
                  price: 10000,
                  onBuy: () => _showDialog(10000),
                ),
                Merchandise(
                  imagePath: 'images/premium2.png',
                  price: 10000,
                  onBuy: () => _showDialog(10000),
                ),
                Merchandise(
                  imagePath: 'images/premium3.png',
                  price: 10000,
                  onBuy: () => _showDialog(10000),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Extra Lives
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExtraLives(
                  imagePath: 'images/x2.png',
                  price: 200000,
                  onBuy: () => _showDialog(200000),
                ),
                ExtraLives(
                  imagePath: 'images/x3.png',
                  price: 300000,
                  onBuy: () => _showDialog(300000),
                ),
                ExtraLives(
                  imagePath: 'images/x5.png',
                  price: 450000,
                  onBuy: () => _showDialog(450000),
                ),
              ],
            ),
          ],
        ),
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