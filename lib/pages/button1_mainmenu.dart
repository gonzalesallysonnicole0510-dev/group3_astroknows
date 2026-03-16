import 'button0_charac.dart';
import 'button2_shop.dart';
import 'button3_settings.dart';
import 'package:flutter/material.dart';
import 'solar_screen1.dart';


class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
       
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0, //removes shadow of the appBar


          // Character Customization Button
          leading: GestureDetector(
            onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CharacCustPage())
                  );
            },
          child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100)
              ),
            ),
          ),


          // Shop Button
          actions: [
            GestureDetector(
            onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShopPage(star: 0))
                  );
            },
          child: Container(
            margin: EdgeInsets.all(5),
            width: 47,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              border: Border.all(
              color: Colors.lightBlue,
              width: 1,
              ),
              borderRadius: BorderRadius.circular(100)
              ),
            child: Icon (
              Icons.shop,
              color: Colors.white,
              size: 50,
            ),
            ),
            ),


            // Settings Button
            GestureDetector(
            onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage())
                  );
            },
          child: Container(
            margin: EdgeInsets.all(5),
            width: 47,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              border: Border.all(
              color: Colors.lightBlue,
              width: 1,
              ),
              borderRadius: BorderRadius.circular(100)
              ),
            child: Icon (
              Icons.settings,
              color: Colors.white,
              size: 50,
            ),
            ),
            ),
          ],
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SolarSystemInterface()), 
              );
            },
            child: Text("Go to Solar Screen"),
          )
        )
    );
  }
}
