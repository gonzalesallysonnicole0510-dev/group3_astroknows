import 'package:flutter/material.dart';


class CharacCustPage extends StatelessWidget {
  const CharacCustPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
       
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
        ),


        body: Center(
          child: Text('CHARACTER CUSTOMIZATION',
          style: TextStyle(
            fontSize: 25,
          )
          ),
        )
    );
  }
}

