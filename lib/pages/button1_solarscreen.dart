import 'dart:math';


import 'splash_screen.dart';
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
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SplashScreen(planet: name)), // navigate to splash screen first as a countdown before the quiz starts
              );
            },
            child: Text(
              "Quizteroid Quest for ${name[0].toUpperCase()}${name.substring(1).toLowerCase()}", // uppercase first letter only
              style: const TextStyle(
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
          _pos(context, top: -h * 0.15, left: w * 0.25, size: h * 0.5, path: 'images/sun.png', name: 'Sun',
            info: '''The star at the center of our Solar System.
           
          The sun holds 99.8% of the solar system's mass.


          Its gravity keeps everything from the biggest planets to the smallest debris in orbit.


          The Sun is classified as a G-type Main-Sequence Star.


          The surface temperature of the Sun is approximately 5,500°C.


          Light from the Sun takes about 8 minutes and 20 seconds to reach Earth.


            '''),




          // Venus
          _pos(context, top: h * 0.15, left: w * 0.12, size: h * 0.18, path: 'images/venus.png', name: 'Venus',
            info: '''Venus is the second planet from the Sun and the hottest planet in our solar system with surface temperatures reaching 471°C.
           
          Venus is often called Earth's 'Evil Twin' due to its similar size but toxic atmosphere.
 
          It rotates backward compared to most other planets, meaning the Sun rises in the West.


          The atmospheric pressure on the surface is 90 times greater than Earth's—like being 3,000 feet underwater.


          A day on Venus is longer than its year; it takes 243 Earth days to rotate once but only 225 to orbit the Sun.


          It is the brightest object in our night sky after the Moon.
            '''),




          // Mars
          _pos(context, top: h * 0.21, right: w * 0.22, size: h * 0.14, path: 'images/mars.png', name: 'Mars',
            info: '''Mars is known as the Red Planet due to iron oxide on its surface.
           
          It is home to Olympus Mons, which is the largest volcano in the solar system.


          The planet has the largest dust storms in the solar system, which can cover the entire globe for months.


          Mars has two tiny, lumpy moons named Phobos (Fear) and Deimos (Panic).


          The Martian sky appears pinkish-red during the day, but the sunsets are actually blue.


          Liquid water cannot exist on the surface today because the atmosphere is too thin, but ice is trapped at the poles.


            '''),




          // Saturn
          _pos(context, bottom: h * 0.12, left: w * 0.08, size: h * 0.28, path: 'images/saturn.png', name: 'Saturn',
            info: '''Saturn is a gas giant famous for its extensive ring system made of ice and rock.
           
          The planet is mostly made of hydrogen and helium and is less dense than water—it would float in a giant pool.


          There is a massive, permanent hexagonal-shaped storm swirling at Saturn's north pole.


          Saturn has 146 moons, the most of any planet in the solar system.


          Winds in Saturn's upper atmosphere can reach 1,800 km/h, much faster than the strongest Earth hurricane.


            '''),




          // Mercury
          _pos(context, top: h * 0.15, right: w * 0.38, size: h * 0.08, path: 'images/mercury.png', name: 'Mercury',
            info: '''Mercury is the smallest planet in our solar system and nearest to the Sun. It's only slightly larger than Earth's Moon.


          From the surface of Mercury, the Sun would appear more than three times as large as it does when viewed from Earth, and the sunlight would be as much as seven times brighter.


          Mercury's surface temperatures are both extremely hot and cold. Because the planet is so close to the Sun, day temperatures can reach highs of 800°F (430°C). Without an atmosphere to retain that heat at night, temperatures can dip as low as -290°F (-180°C).


          Despite its proximity to the Sun, Mercury is not the hottest planet in our solar system.
         
          Mercury is the fastest planet, zipping around the Sun every 88 Earth days.


          Mercury doesn't have moons nor rings.'''),






          // Earth
          _pos(context, top: h * 0.29, right: w * 0.07, size: h * 0.2, path: 'images/earth.png', name: 'Earth',
            info: '''Our home planet and the only known world to support life.
         
          It is the densest planet in the solar system due to its large iron core.


          The Earth is not a perfect sphere; it bulges at the equator because of its rotation.


          About 70% of the surface is covered by oceans, but only 3% of that water is fresh.


          It is the only planet not named after a Greek or Roman god; its name comes from Old English.
            '''),




          // Jupiter
          _pos(context, bottom: h * 0.08, right: w * 0.05, size: h * 0.3, path: 'images/jupiter.png', name: 'Jupiter',
            info: '''The largest planet in our Solar System that all other planets in the solar system could fit in it twice.


          It has the shortest day of any planet, spinning once every 10 hours.


          The Great Red Spot is a hurricane-like storm that has been shrinking for decades but is still wider than Earth.
         
          Jupiter acts as a 'space vacuum' because its massive gravity pulls in many dangerous comets and asteroids.


          It has a moon called Ganymede, which is the only moon known to have its own magnetic field.
           
            '''),




          // Uranus
          _pos(context, bottom: h * 0.08, left: w * 0.35, size: h * 0.18, path: 'images/uranus.png', name: 'Uranus',
            info: '''An ice giant that rotates on its side.
           
          It is the only planet that tilts so far it effectively orbits the Sun on its side.


          Uranus was the first planet discovered using a telescope (in 1781).


          The temperature can drop to -224°C, making it even colder than the more distant Neptune.


          Its 27 moons are uniquely named after characters created by William Shakespeare and Alexander Pope.


            '''),




          // Neptune
          _pos(context, bottom: h * 0.1, right: w * 0.32, size: h * 0.18, path: 'images/neptune.png', name: 'Neptune',
            info: '''The most distant planet from the Sun.
         
          Neptune was the first planet discovered through mathematical calculations rather than direct observation.


          It is the windiest world, with supersonic winds that move faster than the speed of sound on Earth.


          Because it is so far away, Neptune takes 165 Earth years to complete just one orbit around the Sun.


          Neptune has a 'Great Dark Spot,' a massive storm that disappears and reappears every few years.


          Its largest moon, Triton, is the only large moon in the solar system that orbits in the opposite direction of its planet.


            '''),
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

