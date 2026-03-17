import 'dart:math';

import 'button0_charac.dart';
import 'button2_shop.dart';
import 'button3_settings.dart';
import 'title.dart';
import 'package:flutter/material.dart';


// Main menu page that shows the solar system interface
class SolarSystemInterface extends StatefulWidget {
  const SolarSystemInterface({super.key});

  @override
  State<SolarSystemInterface> createState() => _SolarSystemInterfaceState();
}

class _SolarSystemInterfaceState extends State<SolarSystemInterface> with SingleTickerProviderStateMixin {
  late AnimationController _blinkController;


  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }


  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }


  // POPUP DIALOG: This shows the info when you tap a planet
  void _showInfo(BuildContext context, String name, String info) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1B35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.cyanAccent, width: 1),
        ),
        title: Text(name.toUpperCase(),
          style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, letterSpacing: 2)),
        content: SingleChildScrollView(
          child: Text(
            info,
            style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.4),
          ),
        ),
        actions: [
          // Quizteroid Quest Button
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TitlePage(),
                ),
              ),
            child: const Text(
              "Quizteroid Quest",
              style: TextStyle(
                color: Colors.cyanAccent
                ),
              ),
          ),
          
          // Close Button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close', 
              style: TextStyle(
                color: Colors.cyanAccent
                ),
              ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
       backgroundColor: Colors.black,
       extendBodyBehindAppBar: true,
       
        appBar: AppBar(
          backgroundColor: Colors.black.withValues(alpha: 0.0),  // transparent
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
            height: 47,
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
              size: 30,
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
            height: 47,
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
              size: 30,
            ),
            ),
            ),
          ],
        ),


        body: Stack(
        children: [
          // Background Star Field
          AnimatedBuilder(
            animation: _blinkController,
            builder: (context, child) => CustomPaint(
              painter: StarFieldPainter(_blinkController.value),
              size: Size(w, h),
            ),
          ),


          // --- PLANET LAYOUT ---

          // Sun
          _pos(context, top: -h * 0.15, left: w * 0.25, size: h * 0.5, path: 'assets/sun.png', name: 'Sun',
            info: 'The star at the center of our Solar System.'),


          // Venus
          _pos(context, top: h * 0.22, left: w * 0.12, size: h * 0.18, path: 'assets/venus.png', name: 'Venus',
            info: 'Venus is the second planet from the Sun and the hottest planet in our solar system.'),


          // Mars
          _pos(context, top: h * 0.45, left: w * 0.05, size: h * 0.14, path: 'assets/mars.png', name: 'Mars',
            info: 'Mars is known as the Red Planet due to iron oxide on its surface.'),


          // Saturn
          _pos(context, bottom: h * 0.12, left: w * 0.08, size: h * 0.28, path: 'assets/saturn.png', name: 'Saturn',
            info: 'Saturn is a gas giant famous for its extensive ring system.'),


          // Mercury
          _pos(context, top: h * 0.25, right: w * 0.22, size: h * 0.1, path: 'assets/mercury.png', name: 'Mercury', 
            info: '''Mercury is the smallest planet in our solar system and nearest to the Sun. It's only slightly larger than Earth's Moon. 

From the surface of Mercury, the Sun would appear more than three times as large as it does when viewed from Earth, and the sunlight would be as much as seven times brighter.

Mercury's surface temperatures are both extremely hot and cold. Because the planet is so close to the Sun, day temperatures can reach highs of 800°F (430°C). Without an atmosphere to retain that heat at night, temperatures can dip as low as -290°F (-180°C).

Despite its proximity to the Sun, Mercury is not the hottest planet in our solar system – that title belongs to nearby Venus, thanks to its dense atmosphere. But Mercury is the fastest planet, zipping around the Sun every 88 Earth days.

Mercury doesn't have moons nor rings.'''),


          // Earth
          _pos(context, top: h * 0.32, right: w * 0.05, size: h * 0.2, path: 'assets/earth.png', name: 'Earth',
            info: 'Our home planet and the only known world to support life.'),


          // Jupiter
          _pos(context, bottom: h * 0.08, right: w * 0.05, size: h * 0.3, path: 'assets/jupiter.png', name: 'Jupiter',
            info: 'The largest planet in our Solar System.'),


          // Uranus
          _pos(context, bottom: h * 0.08, left: w * 0.35, size: h * 0.18, path: 'assets/uranus.png', name: 'Uranus',
            info: 'An ice giant that rotates on its side.'),


          // Neptune
          _pos(context, bottom: h * 0.1, right: w * 0.32, size: h * 0.18, path: 'assets/neptune.png', name: 'Neptune',
            info: 'The most distant planet from the Sun.'),
        ],
      ),
    );
  }


  Widget _pos(BuildContext context, {double? top, double? bottom, double? left, double? right, required double size, required String path, required String name, required String info}) {
    return Positioned(
      top: top, bottom: bottom, left: left, right: right,
      child: GestureDetector(
        onTap: () => _showInfo(context, name, info),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: size, height: size,
              child: Image.asset(path, fit: BoxFit.contain,
                errorBuilder: (c, e, s) => Icon(Icons.help_outline, color: Colors.white24, size: size/2)),
            ),
            const SizedBox(height: 4),
            Text(name, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          ],
        ),
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
      double opacity = (i % 2 == 0) ? 0.2 + (blinkValue * 0.8) : 1.0 - (blinkValue * 0.8);
      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), starSize, paint);
    }
  }


  @override
  bool shouldRepaint(covariant StarFieldPainter oldDelegate) => oldDelegate.blinkValue != blinkValue;
}
