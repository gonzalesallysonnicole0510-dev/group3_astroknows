import 'package:flutter/material.dart';


int star = 10000;


class ShopPage extends StatefulWidget {
  final int star;
  const ShopPage({super.key, required this.star});


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
  if (star >= price) {
    setState(() {
      star -= price;
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
                  Navigator.pop(context, star);
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
                '$star',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ),
          ],
        ),

        // Merchandise (premium spaceship designs) items
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Merchandise(
                    price: 10000,
                    onBuy: () => _showDialog(10000),
                    ),
                  Merchandise(
                    price: 10000,
                    onBuy: () => _showDialog(10000),
                    ),
                  Merchandise(
                    price: 10000,
                    onBuy: () => _showDialog(10000),
                    ),
                ],
              ),
              SizedBox(height: 25),

              // Extra Lives Items
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExtraLives(
                    price: 200000,
                    onBuy: () => _showDialog(200000),
                    ),
                  ExtraLives(
                    price: 300000,
                    onBuy: () => _showDialog(300000),
                    ),
                  ExtraLives(
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
  const Merchandise({super.key, required this.price, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBuy,
      child: Column(
        children: [
          Container( // container of shop items
            height: 95,
            width: 95,
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),

            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15),
            ),

            child: Icon (
              Icons.rocket,
              color: Colors.white,
              size: 50,
            ),
          ),

          Text (
            '$price',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            )
          )
        ]
        ),
    );
  }
}

class ExtraLives extends StatelessWidget {
  final int price;
  final VoidCallback onBuy;
  const ExtraLives({super.key, required this.price, required this.onBuy});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBuy,
      child: Column(
        children: [
          Container( // container of shop items
            height: 95,
            width: 95,
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),


            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15),
            ),


            child: Icon (
              Icons.favorite,
              color: Colors.white,
              size: 50,
            ),
          ),


          Text (
            '$price',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            )
          )
        ]
        ),
    );
  }
}