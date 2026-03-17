import 'package:flutter/material.dart';

class MissionFailedPage extends StatelessWidget {
  const MissionFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Center(
        child: Text(
          'Mission Failed :(',
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
