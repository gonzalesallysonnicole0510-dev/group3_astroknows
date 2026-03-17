import 'package:flutter/material.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Center(
        child: Text(
          'Congratulations! You have earned 500 stars!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24
            ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
