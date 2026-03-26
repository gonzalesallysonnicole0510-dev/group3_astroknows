import 'dart:math';

import 'splashscreen_countdown.dart';
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
                MaterialPageRoute(builder: (context) => SplashScreen_Countdown(planet: name)), // navigate to splash screen first as a countdown before the quiz starts
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
            info: '''The star at the center of the Solar System. The sun holds 99.8% of the solar system's mass. Its gravity keeps everything from the biggest planets to the smallest debris in orbit. 

The Sun is classified as a G-type Main-Sequence Star. The surface temperature of the Sun is approximately 5,500°C. 

The core is the hottest part of the Sun. Nuclear reactions here – where hydrogen is fused to form helium – power the Sun’s heat and light. 

The Sun orbits the center of the Milky Way, bringing with it the planets, asteroids, comets, and other objects in our solar system. 

Our solar system is moving with an average velocity of 450,000 miles per hour (720,000 kilometers per hour). But even at this speed, it takes about 230 million years for the Sun to make one complete trip around the Milky Way.

The Sun rotates on its axis as it revolves around the galaxy. Its spin has a tilt of 7.25 degrees with respect to the plane of the planets’ orbits. 

Since the Sun is not solid, different parts rotate at different rates. At the equator, the Sun spins around once about every 25 Earth days, but at its poles, the Sun rotates once on its axis every 36 Earth days.
'''),



          // Mercury
          _pos(context, top: h * 0.15, right: w * 0.38, size: h * 0.08, path: 'images/mercury.png', name: 'Mercury', 
            info: '''Mercury is the closest planet to the Sun that does not have any atmosphere to retain the heat. Instead, Mercury possesses a thin exosphere made up of atoms blasted off the surface by the solar wind and striking micrometeoroids.

At daytime, the temperature surface can reach highs of 800°F (430°C). Whereas, nighttime temperatures on the surface can drop as low as -290°F (-180°C). Despite its proximity to the Sun, Mercury is not the hottest planet in our solar system.

The only way to observe Mercury from Earth is during dawn or twilight time and the planet makes an appearance indirectly.  However, an event called transit that happens about 13 times in a century, observers on Earth can watch and visibly see Mercury pass across the Sun.

From the surface of Mercury, the Sun would appear more than three times as large as it does when viewed from Earth, and the sunlight would be as much as seven times brighter. One Mercury solar day is equal to 175.97 Earth days. 

Mercury speeds around the Sun every 88 days, traveling through space at nearly 50 kilometers (31 miles) per second, making the planet the fastest in the solar system to orbit the Sun. 

Mercury is also the smallest planet in the solar system, measuring just 3,032 miles wide at its equator. To imagine its size, Mercury is only slightly larger than Earth’s Moon. 

Correspondingly, Mercury resembles the look of Earth’s moon, with its surface involving many impact craters from collisions with meteoroids and comets. Additionally, Mercury doesn't have its own moons nor rings.

Mercury is the second densest planet after Earth, with a large metallic core having a radius of about 2,000 kilometers (1,240 miles), which is about 80 percent of the planet’s radius. 

Mercury’s outer shell, comparable to Earth’s outer shell (called the mantle and crust), is only about 400 kilometers (250 miles) thick.
'''),



          // Venus
          _pos(context, top: h * 0.15, left: w * 0.12, size: h * 0.18, path: 'images/venus.png', name: 'Venus',
            info: '''Venus is the second planet from the Sun and the hottest planet in our solar system with surface temperatures reaching 471°C. This is because Venus is covered by a thick, rapidly spinning atmosphere that traps the Sun's heat, creating a scorched world with temperatures hot enough to melt lead.

Venus’ atmosphere consists mainly of carbon dioxide, with clouds of sulfuric acid droplets. Only trace amounts of water have been detected in the atmosphere. The atmospheric pressure on the surface is 90 times greater than Earth's—like being 3,000 feet underwater. 

Atmospheric lightning bursts, long suspected by scientists, were confirmed in 2007 by the European Venus Express orbiter. The lightning on Venus is associated with sulfuric acid clouds. Compared to Earth, Jupiter, and Saturn, it is associated with water clouds.

Venus also appears to be the brightest planet in the sky due to its proximity to Earth and the way its clouds reflect sunlight. 

Venus is often called Earth's 'Evil Twin' due to its similar size, mass, density, composition, and gravity, but toxic atmosphere. 

Venus rotates backward compared to most other planets, meaning the Sun rises in the West. 

A day on Venus is longer than its year; it takes 243 Earth days to rotate once but only 225 to orbit the Sun.

Like Mercury, Venus can be seen periodically passing across the face of the Sun. These “transits” of Venus occur in pairs with more than a century separating each pair.
'''),



          // Earth
          _pos(context, top: h * 0.29, right: w * 0.07, size: h * 0.2, path: 'images/earth.png', name: 'Earth',
            info: '''Our home planet and the only known world to support life. Earth is the third planet from the Sun and the fifth largest in the solar system. It is the densest planet in the solar system due to its large iron core. 

About 70% of the surface is covered by oceans, but only 3% of that water is fresh. Fresh water exists as a liquid only within a small temperature range from 0 to 100°C (32 to 212°F). This range is very tiny compared to the extreme temperatures on other planets in the solar system. 

The presence and distribution of water vapor in the atmosphere is responsible for much of Earth’s weather.

The Earth is not a perfect sphere; it bulges at the equator because of its rotation being tilted 23.45°C. As a result of Earth’s axis of rotation, the four seasons of spring, summer, fall, and winter happen. 

During part of the year, the northern hemisphere is tilted toward the Sun and the southern hemisphere is tilted away, producing summer in the north and winter in the south.  Six months later, the situation will be reversed. When spring and fall begin, both hemispheres receive roughly equal amounts of solar illumination.

Near the surface, an atmosphere that consists of 78% nitrogen, 21% oxygen, and 1% other ingredients envelops Earth. The atmosphere affects Earth’s long-term climate and short-term local weather, shielding life from the harmful radiation coming from the Sun, and burning up falling meteors before they can strike the surface as meteorites.

It is the only planet not named after a Greek or Roman god; its name comes from Old English.
'''),



          // Mars
          _pos(context, top: h * 0.21, right: w * 0.22, size: h * 0.14, path: 'images/mars.png', name: 'Mars',
            info: '''Mars is known as the Red Planet due to iron oxide on its surface. It is home to Olympus Mons, which is the largest volcano in the solar system. 

The planet has the largest dust storms in the solar system, which can cover the entire globe for months. 

Mars has two tiny, lumpy moons named Phobos (Fear) and Deimos (Panic). Potato-shaped, they have too little mass for gravity to make them spherical. The innermost moon, Phobos, is heavily cratered, with deep grooves on its surface.

The Martian sky appears pinkish-red during the day, but the sunsets are actually blue. Liquid water cannot exist on the surface today because the atmosphere is too thin, but ice is trapped at the poles.

While Mars' atmosphere is much thinner than Earth's, it is still active enough to produce wind, clouds, and even snow. However, because the atmosphere is so thin, heat from the Sun easily escapes. 

Temperatures on Mars can reach a high of about 70°F (20°C) near the equator during the day, but at night, they can plummet to as low as -225°F (-153°C).

Mars has a day-night cycle very similar to Earth's; one solar day on Mars (called a "sol") is 24.6 hours. However, because it is further from the Sun, it takes much longer to complete an orbit—about 687 Earth days. 

Mars also has seasons like Earth because its axis is tilted at 25 degrees, but these seasons last twice as long due to its longer orbital period.

There is strong evidence that Mars was much warmer and wetter billions of years ago, with a thicker atmosphere and liquid water on its surface. 

Today, water on Mars exists primarily as ice in the polar caps and just beneath the surface, making it a primary focus for scientists searching for signs of past life.
'''),



          // Jupiter
          _pos(context, bottom: h * 0.08, right: w * 0.05, size: h * 0.3, path: 'images/jupiter.png', name: 'Jupiter',
            info: '''The largest planet in our Solar System that approximately over 1,300 Earths can fit inside it. As a gas giant, Jupiter does not have a true solid surface. It is composed primarily of hydrogen and helium, similar to the composition of the Sun. 

Deep within its atmosphere, the intense pressure and temperature compress the hydrogen gas into a liquid, creating the largest ocean in the solar system—one made of liquid metallic hydrogen instead of water.

Jupiter acts as a “space vacuum” because its massive gravity pulls in many dangerous comets and asteroids. It has a moon called Ganymede, which is the only moon known to have its own magnetic field.

Jupiter has the shortest day of any planet, spinning once every 10 hours. Because there is no solid surface to slow them down, Jupiter’s storms can persist for centuries. The most famous of these is the Great Red Spot, a swirling oval of clouds wider than Earth that has been observed for more than 300 years.

The planet is often described as a "miniature solar system" because of its many moons and rings. Jupiter has 95 officially recognized moons, including the four large Galilean satellites: Io, Europa, Ganymede, and Callisto. 

Ganymede is the largest moon in the solar system, even larger than the planet Mercury. 

While Jupiter itself is unlikely to support life, its moon Europa is considered one of the most promising places to search for life elsewhere, due to evidence of a vast ocean hidden beneath its icy crust.
'''),



          // Saturn
          _pos(context, bottom: h * 0.12, left: w * 0.08, size: h * 0.28, path: 'images/saturn.png', name: 'Saturn',
            info: '''Saturn is a gas giant famous for its extensive ring system made of ice and rock. These rings are divided into major sections named with letters, such as the prominent Cassini Division, a large gap between the main rings.

The planet is mostly made of hydrogen and helium and is less dense than water—it would float in a giant pool. 

There is a massive, permanent hexagonal-shaped storm swirling at Saturn's north pole. 

Saturn has 146 moons, the most of any planet in the solar system. Titan, is a world of its own, the largest moon of Saturn. In the solar system, it is the second-largest moon (larger than the planet Mercury) and is the only moon known to have a dense atmosphere.

Winds in Saturn's upper atmosphere can reach 1,800 km/h, much faster than the strongest Earth hurricane.

Time moves differently on Saturn. It has one of the shortest days in the solar system, completing a full rotation in just 10.7 hours. However, because it is so far from the Sun, its journey around it is much slower; one year on Saturn lasts about 29.4 Earth years. Because of its distance, the average temperature on the planet is a frigid -218°F (-138°C).

Known since ancient times because it is visible to the naked eye, Saturn was named after the Roman god of agriculture.
'''),




          // Uranus
          _pos(context, bottom: h * 0.08, left: w * 0.35, size: h * 0.18, path: 'images/uranus.png', name: 'Uranus',
            info: '''An ice giant that rotates on its side. It is the only planet that tilts so far it effectively orbits the Sun on its side. Because of its extreme tilt, Uranus experiences the most dramatic seasons in the solar system. 

For nearly 21 years—a quarter of its 84-Earth-year orbit—one pole is bathed in continuous sunlight while the other is plunged into a dark, frozen winter. 

Uranus is classified as an ice giant because at least 80% of its mass is composed of a hot, dense fluid of "icy" materials—water, methane, and ammonia—swirling above a small rocky core.

Uranus was the first planet discovered using a telescope (by astronomer William Herschel in 1781). 

Uranus is surrounded by a system of 13 known rings. These rings are narrow and very dark, composed of particles that reflect only about 2% of incoming light.

The planet also has 28 known moons that are uniquely named after characters created by William Shakespeare and Alexander Pope, such as Titania, Oberon, and Miranda.

Uranus gets its signature blue-green or cyan color from methane gas in its atmosphere. While the atmosphere is mostly hydrogen and helium, the methane absorbs red light and reflects the blue-green spectrum back into space. 

Despite being closer to the Sun than Neptune, Uranus actually has the coldest atmosphere of any planet, with minimum temperatures dropping as low as -371°F (-224°C). This is largely because it has very little internal heat to supplement the energy it receives from the Sun.

To date, the only spacecraft to ever visit Uranus was NASA's Voyager 2, which flew by the planet in 1986. 
'''),



          // Neptune
          _pos(context, bottom: h * 0.1, right: w * 0.32, size: h * 0.18, path: 'images/neptune.png', name: 'Neptune',
            info: '''The most distant planet from the Sun. Because it is so far away, Neptune takes 165 Earth years to complete just one orbit around the Sun.

Neptune was the first planet discovered through mathematical calculations rather than direct observation. 

It is the windiest world, with supersonic winds that move faster than the speed of sound on Earth. 

Like Uranus, Neptune is an ice giant. It is slightly smaller in diameter than Uranus but actually more massive, as its greater density packs more material into a slightly tighter space. 

Most of its mass is a hot, dense fluid of "icy" materials—water, methane, and ammonia—resting above a solid, Earth-sized rocky core.

Neptune’s atmosphere is composed primarily of hydrogen and helium, with a small amount of methane. While both ice giants have methane, Neptune is a much more vivid, bright blue than the pale cyan of Uranus. Scientists believe an as-of-yet unknown atmospheric component contributes to this intense color. 

Neptune has a 'Great Dark Spot,' a massive storm that disappears and reappears every few years. 

Neptune has at least 16 known moons. The largest, Triton, is the only large moon in the solar system that orbits in the opposite direction of its planet’s rotation (a retrograde orbit). This suggests that Triton did not form with Neptune but was likely a dwarf planet captured by Neptune's gravity from the Kuiper Belt.

Neptune also possesses at least 5 main rings and 4 prominent ring arcs, which are clumps of dust and debris likely held together by the gravity of nearby small moons.
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
      paint.color = Colors.white.withValues(alpha: opacity);
      canvas.drawCircle(Offset(x, y), starSize, paint);
    }
  }


  @override
  bool shouldRepaint(covariant StarFieldPainter oldDelegate) => oldDelegate.blinkValue != blinkValue;
}