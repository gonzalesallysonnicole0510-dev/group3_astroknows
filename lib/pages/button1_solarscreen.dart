import 'dart:math';
import 'splashscreen_countdown.dart';
import 'package:flutter/material.dart';


//STAR DATA MODEL
class Star {
  final double x;
  final double y;
  final double size;
  final double twinklePhase; // Random starting point for the twinkle
  final double twinkleSpeed; // How fast this specific star twinkles
  final double minOpacity;   // The dimmest this star gets
  final double maxOpacity;   // The brightest this star gets


  Star()
      : x = Random().nextDouble(),
        y = Random().nextDouble(),
        // Multiplying two randoms skews the distribution so most stars are tiny, with a few larger ones for depth
        size = Random().nextDouble() * Random().nextDouble() * 1.8 + 0.5,
        twinklePhase = Random().nextDouble() * 2 * pi,
        // Slower, more ambient twinkle speed to avoid distraction
        twinkleSpeed = Random().nextDouble() * 1.0 + 0.5,
        // Set distinct bounds for how dim/bright each star naturally gets
        minOpacity = Random().nextDouble() * 0.2 + 0.05, // 0.05 to 0.25
        maxOpacity = Random().nextDouble() * 0.4 + 0.4;  // 0.4 to 0.8
}


class SolarSystemInterface extends StatefulWidget {
  const SolarSystemInterface({super.key});


  @override
  State<SolarSystemInterface> createState() => _SolarSystemInterfaceState();
}


class _SolarSystemInterfaceState extends State<SolarSystemInterface>
    with SingleTickerProviderStateMixin {
  late AnimationController _blinkController;
  final List<Star> stars = List.generate(150, (i) => Star());


  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this, 
      // Increased duration to 20 seconds for a much slower, calmer, continuous space ambient loop
      duration: const Duration(seconds: 20),
    )..repeat();
  }


  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0.0,
        
        //back arrow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 72, 72, 72)),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Stack(
        children: [
          // Background Star Field
          AnimatedBuilder(
            animation: _blinkController,
            builder: (context, child) {
              return CustomPaint(
                painter: StarFieldPainter(
                  animationValue: _blinkController.value,
                  stars: stars,
                ),
                size: Size(w, h),
              );
            },
          ),
         
          _pos(
            context,
            top: -h * 0.15,
            left: w * 0.25,
            size: h * 0.5,
            path: 'images/sun.png',
            name: 'Sun',
            planetScreens: [
              const Text(//basic
                '''The Sun is a star located at the center of our solar system. It is a dynamic star, constantly sending out energy in all directions, which lights up and warms the entire solar system. Without the Sun’s energy, life on Earth would not be possible.

Unlike Earth or other planets, the Sun does not have a solid surface. Instead, it is made mostly of hot gases, hydrogen and helium, held together by its powerful gravity. This gravity is so strong that it keeps everything in orbit, from the largest planet, Jupiter, to the smallest bits of space dust.

The Sun is the largest object in our solar system. It is about 10 times wider than Jupiter, the biggest planet. But compared to other stars, it is medium-sized.

The Sun also sends out solar wind, which are streams of charged particles. When they reach Earth, they can create auroras, the colorful lights near the North and South Poles.

Fun fact: if the Sun were hollow, you could fit around 1.3 million Earths inside it!''',
                style: TextStyle(color: Colors.white),
              ),
              const Text(//intermediate
                '''The Sun is made of plasma, a hot form of matter where atoms are electrically charged.

The core is the hottest part, reaching 15 million °C (27 million °F). Here, hydrogen atoms fuse into helium in a process called nuclear fusion, which gives the Sun its energy.

Long ago, the Sun was surrounded by a disk of gas and dust, where the planets, moons, and asteroids formed. Some dust still exists today in rings around the Sun, showing the paths of planets.

The Sun rotates on its axis, but because it is not solid, different parts spin at different speeds. At the equator, it rotates every 25 Earth days, while near the poles it takes 36 Earth days.

The Sun and its solar system travel through the Milky Way galaxy at 720,000 km/h (450,000 mph). It takes about 230 million years to make a full orbit.

Fun fact: The Sun’s surface (photosphere) is cooler than its outer atmosphere (corona), which can reach 2 million °C (3.5 million °F). ''',
                style: TextStyle(color: Colors.white),
              ),
              const Text(// advanced
                '''The Sun is a G-type Main-Sequence star, also called a yellow dwarf. This means it is a normal, active star that produces its own light and heat.

The part of the Sun that we can see is called the photosphere, and it has a temperature of about 5,500 °C (10,000 °F). Above it is the corona, which is the Sun’s outer layer, and it is much hotter, reaching about 2 million °C (3.5 million °F).

The Sun is very massive. It contains about 99.8% of all the mass in the solar system, which makes it the heaviest object in our system.

In the future, the Sun will slowly change. After about 5 billion years, it will run out of fuel, grow bigger into a red giant, and later become a white dwarf.

The Sun is very important to Earth. It helps plants make food through photosynthesis and drives the water cycle, weather, and climate.

Scientists study the Sun using special spacecraft like the Solar Dynamics Observatory and the Parker Solar Probe to learn more about it.

Fun fact: The Sun may look calm, but it is actually very active. It has sunspots, solar flares, and bursts of solar wind, showing that it is always changing.
 ''',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),


          _pos(
            context,
            top: h * 0.15,
            right: w * 0.38,
            size: h * 0.08,
            path: 'images/mercury.png',
            name: 'Mercury',
            planetScreens: [
              const Text(//basic
                '''Mercury is the closest planet to the Sun, but it is not the hottest planet. This is because Mercury does not have a thick atmosphere to trap heat. Instead, it only has a very thin layer of gas called an exosphere, so heat quickly escapes into space.

Because it is so close to the Sun, Mercury is often hard to see from Earth. It is best seen during dawn or twilight, when the Sun is not too bright. Sometimes, Mercury passes directly in front of the Sun. This event is called a transit, and it happens about 13 times in a century, appearing as a black figure or tiny dot.

Mercury is the smallest planet in the solar system and is only slightly larger than Earth’s Moon. Its surface is full of craters, caused by space rocks hitting it over billions of years, which makes it look very similar to the Moon.

Mercury has no moons and no rings, making it one of the simplest planets in structure.

Fun fact: A year on Mercury (orbit around the Sun) is much shorter than on Earth—it only takes 88 Earth days! ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(//intermediate
                '''Mercury moves very fast around the Sun. It takes only 88 Earth days to complete one orbit, making it the fastest planet in the solar system to orbit the Sun. It travels at about 47.87 kilometers per second (47.87 km/s).

Even though Mercury moves fast around the Sun, its rotation (day-night cycle) is much slower compared to Earth. One Mercury solar day (day-night cycle) takes about 175.97 Earth days.

Mercury has extreme temperatures. During the day, it can reach about 430°C (800°F), while at night it can drop to -180°C (-290°F). This huge difference happens because it has no thick atmosphere to keep heat in.

From Mercury, the Sun would appear more than 3 times as large as it does when viewed from Earth, and the sunlight would be as much as 7 times brighter.

Inside Mercury is a large metallic core with a radius measuring about 2,000 kilometers (1,240 miles), making up about 80% of the planet’s size, with a thin outer layer.

Fun fact: Mercury is the second densest planet, after Earth!
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(// advanced
                '''Mercury’s exosphere is made of atoms like sodium, oxygen, and hydrogen. These atoms are constantly being knocked off the planet’s surface by the solar wind of the Sun. The solar wind refers to the Sun’s continuous release of energy into space.

Because Mercury is very close to the Sun and has no thick atmosphere, and solar radiation pressure, small space rocks (micrometeoroids) and solar particles hit its surface and send atoms into space. This escape of atoms flown into space forms a long comet-like “tail” behind Mercury.

In 2011, a NASA spacecraft called MESSENGER became the first to orbit Mercury and study it closely. It helped scientists learn about Mercury’s surface, composition, and magnetic field.

Surprisingly, even though Mercury is very hot, some deep craters near its poles never receive sunlight. These areas stay extremely cold and contain water ice at its north and south poles.

Fun fact: Mercury has a weak magnetic field, but it is still strong enough to interact with the solar wind and create space weather around the planet.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),


          _pos(
            context,
            top: h * 0.15,
            left: w * 0.12,
            size: h * 0.18,
            path: 'images/venus.png',
            name: 'Venus',
            planetScreens: [
              const Text(//basic
                '''Venus is the second planet from the Sun and is the hottest planet in our solar system. Even though it is not the closest planet to the Sun, its temperature can reach up to 471°C, which is hot enough to melt metals like lead. This happens because of Venus’ thick atmosphere that traps heat, making it feel like a giant oven.

Venus is almost the same size as Earth, which is why it is often called Earth’s “Evil Twin.” However, it is very different because its air is toxic, and the surface is extremely hot. No humans or animals can survive there.

If you look at the sky early in the morning or at night, Venus is the brightest planet you can see because its clouds reflect sunlight very well. Because of this, it is sometimes called the “Morning Star” or “Evening Star.”

Unlike most planets, Venus rotates backward, which means the Sun rises in the West and sets in the East if you were standing on Venus. It also has no moons, making it one of the few planets without any natural satellites.

Fun fact: A day on Venus is so long that it actually lasts longer than its year!
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(//intermediate
                '''Venus has a very thick atmosphere made mostly of carbon dioxide, the same gas humans breathe out. Its clouds are made of sulfuric acid, which is very dangerous and can burn skin. Because of this thick atmosphere, the air pressure on Venus is about 90 times stronger than on Earth, like being deep underwater in the ocean.

A very interesting fact about Venus is that a day is longer than a year. One full rotation (day) on Venus takes 243 Earth days, while one orbit around the Sun (year) takes only 225 Earth days. This means a day is longer than a year on Venus.

Scientists have discovered that Venus has lightning, but it forms in acid clouds, not water clouds like on Earth. This shows that Venus has active and powerful weather.

Sometimes, Venus can be seen passing in front of the Sun when viewed from Earth. This event is called a transit, and it happens very rarely.

Fun fact: Venus has many volcanoes, and some may still be active today!
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(// advanced
                '''Venus is extremely hot because of something called the greenhouse effect. This happens when gases in the atmosphere trap heat from the Sun and prevent it from escaping. Because Venus has a lot of carbon dioxide, the heat builds up, making it even hotter than Mercury.

The atmosphere of Venus spins very fast, creating strong wind and thick clouds that cover the whole planet. Even though the surface is extremely hot, the upper part of the clouds is cooler and always moving.

In 2007, a spacecraft called Venus Express confirmed that there is lightning on Venus. Scientists believe this lightning is caused by movement inside the sulfuric acid clouds.

Venus also spins backward, which is called retrograde rotation. Because of this, the Sun rises in the West and sets in the East. This makes Venus very unique compared to most planets.

Venus also has almost no water. Any water that may have existed before has likely evaporated because of the extreme heat.

Fun fact: Even though Venus spins slowly, its atmosphere moves much faster than the planet itself!
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),


          _pos(
            context,
            top: h * 0.29,
            right: w * 0.07,
            size: h * 0.2,
            path: 'images/earth.png',
            name: 'Earth',
            planetScreens: [
              const Text(//basic
                '''Earth is the third planet from the Sun and the fifth largest in the solar system. Our home planet and the only known planet that supports life. It has the right conditions for living things, including liquid water, breathable air, and a temperature that is not too hot or too cold.

Earth’s atmosphere acts like a protective shield. It provides the air we breathe and burns up small meteors before they can hit the ground. This protection helps keep life safe.

Earth takes 24 hours to rotate once, creating day and night, and about 365.25 days to orbit the Sun (complete a year). That extra 0.25 day adds up, which is why we have a leap year every four years.

Earth is also the densest planet, mainly because of its large iron core. Unlike most planets like Mars or Venus, Earth is not named after a Greek or Roman god. Its name comes from Old English.

Fun fact: From space, Earth looks blue because most of its surface is covered with water!
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(//intermediate
                '''Earth is not a perfect sphere, but an oblate spheroid or a flattened oval shape. This happens because of Earth’s rotation, making the middle part, the equator, bulges outward and the north and south poles a little flat.

Earth is tilted at about 23.5 degrees, which causes the four seasons. When a part of Earth is tilted toward the Sun, it becomes warmer (summer). When tilted away, it becomes colder (winter).

Six months later, the pattern reverses. During spring and fall, both hemispheres receive almost equal sunlight.

About 71% of Earth’s surface is covered by water, mostly oceans. This water helps regulate temperature and supports life. The atmosphere also protects Earth by blocking harmful radiation and keeping the planet warm.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(// advanced
                '''About 71% of Earth is covered by water, but 97% is salty ocean water and only 3% is fresh water, which can be used by living things. This limited fresh water is very important for life.

Earth’s outer layer, called the lithosphere, is broken into tectonic plates that slowly move. When these plates collide, they form mountains, and when they pull apart or grind past each other they cause earthquakes.

Many of Earth’s features, like mountain ranges and volcanoes, are found underwater. In fact, most of Earth’s volcanoes are located beneath the oceans.

Earth has one natural satellite, the Moon, which helps keep Earth’s tilt stable. This stability helps maintain a consistent climate and smooth rotation.

Earth’s atmosphere is made up of about 78% nitrogen, 21% oxygen, and 1% other gases. It affects both weather (short-term) and climate (long-term).

Fun fact: Without the Moon, Earth’s tilt could wobble, causing extreme climate changes!
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          _pos(
            context,
            top: h * 0.21,
            right: w * 0.22,
            size: h * 0.14,
            path: 'images/mars.png',
            name: 'Mars',
            planetScreens: [
              const Text(//basic
                '''Mars is the fourth planet from the Sun and is often called the “Red Planet” because of the rusty, iron-rich dust that covers its surface. This dust gives Mars its reddish color.

Mars is one of the most explored planets in the solar system. Scientists have sent rovers to move around and study its surface.

Like Earth, Mars has four seasons because its axis is tilted at about 25 degrees (25°). However, since Mars is farther from the Sun, each season lasts longer than on Earth because Mars takes 687 Earth days to orbit the Sun (year).

Mars has a thin atmosphere made mostly of carbon dioxide, which affects how light scatters in the sky. Because of this, the sky looks reddish-orange during the day, while sunsets appear blue.

Mars does not have rings, unlike some other planets.

Fun fact: Mars’ polar ice caps grow in winter and shrink in summer due to cycles of carbon dioxide and water ice, similar to Earth’s snow but under much colder and drier conditions.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(//intermediate
                '''Mars is much colder than Earth because it is farther from the Sun and its atmosphere is very thin, letting heat escape easily.

Temperatures on Mars can reach 20°C (70°F) near the equator during the day, but at night can drop to -153°C (-225°F). Because of this, liquid water cannot exist on the surface for long, but water is trapped in polar ice caps at the north and south poles.

Mars has a day-night cycle similar to Earth because its axis is tilted at about 25 degrees. One solar day, called a sol, is 24.6 hours. However, since Mars is farther from the Sun, each season lasts longer than on Earth because Mars takes 687 Earth days to orbit the Sun (year).

The thin atmosphere still allows wind, clouds, and even snow, which makes the planet active despite its cold.

Fun fact: A day on Mars is only 37 minutes longer than an Earth day.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(// advanced
                '''Mars has two tiny moons, Phobos and Deimos, which are potato-shaped due to their small mass. Phobos is the innermost moon and has many craters and deep grooves, while Deimos is smoother because loose dust fills its craters.

Mars’ core is dense, made of iron, nickel, and sulfur, and is partially liquid. The rocky mantle above it contains moving molten rock, causing “marsquakes.” The crust on top is made of iron, magnesium, aluminum, calcium, and potassium, and is 10–50 kilometers deep (6–30 miles).

Mars is home to Olympus Mons, the largest volcano in the solar system. Its base is roughly the size of Arizona, United States of America (USA).

Fun fact: Even though Mars seems quiet from a distance, the planet quakes, blows dust storms, and has the tallest volcano, showing it’s geologically active!
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),


         
          _pos(
            context,
            bottom: h * 0.08,
            right: w * 0.05,
            size: h * 0.3,
            path: 'images/jupiter.png',
            name: 'Jupiter',
            planetScreens: [
              const Text(//basic
                '''Jupiter is the largest planet in the solar system. To imagine its size, over 1,300 Earths can fit inside this planet. Its immense gravity and many moons make it often described as a “miniature solar system.”

Jupiter has 95 officially recognized moons, with four large moons: Io, Europa, Callisto, and Ganymede. Ganymede is the largest moon in the Solar System, even bigger than Mercury. These large moons are also known as Galilean satellites. Jupiter also has faint rings, discovered by NASA’s Voyager 1 in 1979, which are made of tiny, dark particles that are difficult to see unless lit by the Sun.

Jupiter is a gas giant, meaning it does not have a solid surface and is mostly made of hydrogen and helium gases. Its massive gravity acts like a space vacuum, pulling in comets and asteroids that could otherwise threaten other planets.

Fun fact: Jupiter’s strong gravity helps protect Earth by capturing nearby space rocks.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(//intermediate
                '''Jupiter has the shortest day of all planets, completing a rotation (day-night cycle) in just 9.9 Earth hours, which produces strong winds and rapid weather changes. However, it takes Jupiter to orbit the Sun for about 12 Earth years. Similar to Venus, Jupiter has a very small axial tilt of only 3 degrees, meaning it spins nearly upright and does not experience strong seasonal changes like Earth.

Deep inside Jupiter, the extreme pressure and temperature compresses hydrogen into a liquid metallic form, forming the largest “ocean” of liquid metallic hydrogen in the solar system. This liquid conducts electricity and helps generate Jupiter’s powerful magnetic field.

Because Jupiter is mostly gas and liquid, there is no solid surface for spacecraft to land on. Even if a spacecraft tried to fly through, it wouldn’t make it far undamaged, and eventually be crushed or vaporized by the intense pressure and heat.

Fun fact: Jupiter spins so fast that it is slightly wider at the equator than at the poles.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(// advanced
                '''Jupiter is known for its distinct colorful bands, called Belts (dark) and Zones (light), caused by differences in temperature, chemical composition, and rising gases. Its clouds are layered: the top layer is ammonia ice, the middle layer is ammonium hydrosulfide ice, and the innermost layer is water vapor and ice.

With no solid land to slow down the strong jet streams produced by Jupiter's fast rotation, its storms can last for hundreds of years. The planet’s Great Red Spot is a giant storm wider than Earth, continuously spinning over 300 years. Jupiter also has a strong magnetic field, which is 14 times stronger than Earth’s, protecting the planet and its moons from solar and cosmic radiation.

Some of Jupiter’s moons, like Europa, may have oceans beneath their icy crusts, making them targets for future exploration. Jupiter’s massive gravity and fast rotation also produce powerful auroras at its poles.

Fun fact: Jupiter’s Great Red Spot is so big that two Earths could fit inside it.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),


          _pos(
            context,
            bottom: h * 0.12,
            left: w * 0.08,
            size: h * 0.28,
            path: 'images/saturn.png',
            name: 'Saturn',
            planetScreens: [
              const Text(//basic
                '''Saturn is the sixth planet from the Sun and is a gas giant famous for its vast rings wrapping the planet. Just like Jupiter and the Sun, this planet is mostly made of hydrogen and helium, no solid land, but it is less dense than liquid water. Therefore, water would just float as a large pool.

Saturn is famous for its extensive ring system, which is composed of ice and rock particles, ranging in size from tiny dust grains to objects tens of meters across. The planet has 146 known moons, with Titan being the largest. In the solar system, it is the second-largest moon, and is so big it is larger than the planet Mercury and has a dense nitrogen-rich atmosphere, making it look almost like a planet on its own.

Fun fact: Saturn’s rings are so wide but thin that if you scaled the planet down to the size of a basketball, the rings would appear as a nearly flat disk.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(//intermediate
                '''The rings of Saturn are labeled A–G in the order they were discovered. Between the B ring and A ring there is a large gap separating the two rings called the Cassini Division, which is easily visible through telescopes.

Saturn rotates very quickly, completing a full spin in just 10.7 Earth hours, making its day extremely short. However, because it is far from the Sun, it takes 29.4 Earth years to complete a full orbit, so its year is very long. The planet is extremely cold, with an average temperature of -138°C (-218°F).

As Saturn has no solid surface as it is mostly made of gas and liquid, meaning a spacecraft could not safely land or fly through it. The extreme pressure and temperature deep inside would crush, melt, and vaporize any spacecraft that tried to fly through the planet.

Saturn’s weather is some of the wildest in the solar system. In the upper atmosphere, winds can reach 1,800 kilometers per hour (1,800 km/h), much faster than the strongest hurricanes on Earth, and its storms are massive, dynamic, and constantly shifting.

Fun fact: Saturn spins so fast that it is slightly flattened at the poles and bulges at the equator, giving it a squashed appearance compared to a perfect sphere.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(// advanced
                '''At Saturn’s north pole, there is a giant hexagon-shaped cloud pattern, a swirling windstorm about 30,000 km (20,000 miles) across, big enough to fit nearly three Earths inside. At the center of this hexagon is a massive, hurricane-like storm, first observed by the Voyager I spacecraft.

In 2009, NASA’s Spitzer Space Telescope discovered a faint, massive ring much larger than Saturn’s main rings. This ring, named the Phoebe ring, is composed of dark dust particles likely coming from the moon Phoebe. Later observations with NASA’s WISE telescope revealed the Phoebe ring stretches about 100–270 times the diameter of Saturn and is 10 times larger than the E ring, which was previously the largest known ring.

Saturn’s atmosphere also features layered clouds like Jupiter, with ammonia ice, ammonium hydrosulfide crystals, and water ice forming distinct cloud decks. Combined with its fast rotation, these layers contribute to turbulent storms, lightning, and shifting weather patterns visible from space.

Fun fact: Saturn radiates more energy than it receives from the Sun, due to leftover heat from its formation, giving the planet a faint golden glow even in the cold depths of space.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),


          _pos(
            context,
            bottom: h * 0.1,
            right: w * 0.32,
            size: h * 0.18,
            path: 'images/neptune.png',
            name: 'Neptune',
            planetScreens: [
              const Text(//basic
                '''hatdog ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(//intermediate
                '''sakit sa ulo neto mga sis ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(// advanced
                '''sana kumita tayo dito ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),


         
          _pos(
            context,
            bottom: h * 0.08,
            left: w * 0.35,
            size: h * 0.18,
            path: 'images/uranus.png',
            name: 'Uranus',
            planetScreens: [
              const Text(//basic
                '''Uranus is the seventh planet from the Sun and is known for its unusual position in space. Unlike other planets, Uranus rotates on its side, making it look like it is rolling around the Sun instead of spinning upright.

Uranus is called an ice giant because it is mostly made of icy materials like water, methane, and ammonia. It also has a small rocky core inside. The planet has a blue-green color, which comes from methane gas in its atmosphere.

It is also the coldest planet in the solar system, even colder than Neptune, because it does not produce much internal heat. Uranus has rings and many moons, and it was the first planet discovered using a telescope by William Herschel.

Fun fact: Uranus looks like a smooth blue ball, but its clouds are actually very faint and hard to see compared to other planets.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(//intermediate
                '''Uranus has an extreme tilt, which causes very unusual seasons. Each side of the planet can face the Sun for about 21 years, while the other side stays in darkness, creating the most extreme seasonal changes in the solar system.

The planet has 13 narrow and dark rings, made of small particles that reflect very little light, making them hard to see. Uranus also has 28 known moons, and many are named after characters from famous writers like William Shakespeare and Alexander Pope, such as Titania and Oberon.

A day on Uranus is relatively short, taking about 17 hours to complete one rotation, which is shorter than a day on Earth.

Fun fact: Because of its tilt, Uranus can have decades-long daylight or darkness, unlike Earth’s daily sunrise and sunset cycle.
   ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(// advanced
                '''Uranus is extremely far from the Sun, about 1.8 billion miles away, so sunlight takes around 2 hours and 40 minutes to reach it. This great distance contributes to its very cold environment.

Even though Uranus is closer to the Sun than Neptune, it is colder because it releases very little internal heat, unlike most other planets. Uranus also has a retrograde rotation, meaning it spins in the opposite direction compared to most planets, adding to its unusual motion.

The only spacecraft to visit Uranus was Voyager 2, which flew by the planet in 1986 and provided valuable information about its atmosphere, rings, and moons.

Fun fact: Because of its sideways tilt and backward spin, Uranus has one of the strangest motions of any planet—you could say it “rolls” through space.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),


          _pos(
            context,
            bottom: h * 0.1,
            right: w * 0.32,
            size: h * 0.18,
            path: 'images/neptune.png',
            name: 'Neptune',
            planetScreens: [
              const Text(//basic
                '''Neptune is the farthest planet from the Sun, and because of this great distance, it takes a very long time to travel around it. In fact, one full orbit takes about 165 Earth years, making its year extremely long compared to Earth.

Unlike many planets that were first seen through telescopes, Neptune was discovered using mathematical calculations. Scientists predicted its existence based on strange movements of other planets before it was ever directly observed.

Neptune is known as the windiest world in the solar system, with supersonic winds that can move faster than the speed of sound on Earth. These powerful winds sweep across the planet, making its atmosphere very active and stormy.

Like Uranus, Neptune is an ice giant, meaning it is made mostly of water, methane, and ammonia in a hot, dense fluid form above a rocky core. It does not have a solid surface like Earth.

Neptune has a deep blue color, which is why it is named after the Roman god of the sea. It is also about four times wider than Earth, making it a very large planet.

Fun fact: Neptune has storms that can move faster than a fighter jet, so if you could “ride the wind” there, you’d be traveling at over 2,000 km/h—faster than any roller coaster on Earth!
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(//intermediate
                '''Neptune’s atmosphere is made mostly of hydrogen and helium, with small amounts of methane, which gives the planet its rich blue color. However, Neptune appears more vividly blue than Uranus, and scientists believe an unknown atmospheric component enhances this deeper color.

The planet has at least 16 known moons, with Triton being the largest. Triton is unique because it orbits Neptune in the opposite direction of its planet’s rotation (a retrograde orbit). This suggests that Triton did not form with Neptune but was likely a dwarf planet captured by Neptune's gravity from the Kuiper Belt.

Neptune also has a system of 5 main rings and 4 ring arcs, which are clumps of dust and debris. These arcs are unusual because instead of forming complete rings, they appear as uneven segments held together by nearby moons.

Because Neptune is so far away, sunlight there is roughly 900 times fainter than what we see on our home planet. It takes about 4 hours for sunlight to reach the planet, and even at noon, the light would look like a dim twilight compared to Earth’s bright daylight.

Fun fact: Triton has geysers that erupt nitrogen gas, making it one of the most geologically active moons in the solar system.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(// advanced
                '''Neptune holds the title as the windiest world in the solar system, with wind speeds reaching over 2,000 km/h (1,200 miles per hour), almost as fast as a fighter jet. These winds can move clouds of frozen methane across the planet, forming massive and fast-changing weather systems.

In 1989, the spacecraft Voyager 2 discovered a large, oval-shaped storm in Neptune’s southern hemisphere called the Great Dark Spot, which was large enough to fit Earth inside it. Unlike Jupiter’s long-lasting storm, Neptune’s storms appear and disappear over time, showing how unstable and active its atmosphere is.

Neptune also experiences seasons similar to Earth because its axis is tilted at 28 degrees; however, because it takes 165 Earth years to orbit the Sun, each of its seasons lasts for more than 40 years.

Neptune also radiates 2.6 times more energy than it receives from the Sun, likely due to internal heat from gravitational compression and processes like “diamond rain,” where carbon crystallizes under pressure and sinks toward the core.

Its magnetic field is highly unusual, tilted at 47 degrees and offset from the center of the planet by about 13,500 km. This suggests the magnetic field is generated in a slushy layer of water and ammonia, rather than a solid core like Earth’s.

Fun fact: Deep inside Neptune, carbon may crystallize into diamonds and fall like rain, forming literal diamond storms.
 ''',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _pos(
    BuildContext context, {
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required String path,
    required String name,
    required List<Widget> planetScreens,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SoloPlanetPage(
                name: name,
                imagePath: path,
                planetScreens: planetScreens,
              ),
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: Image.asset(path, fit: BoxFit.contain),
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// SOLO PLANET PAGE 
class SoloPlanetPage extends StatefulWidget {
  final String name;
  final String imagePath;
  final List<Widget> planetScreens;


  const SoloPlanetPage({
    super.key,
    required this.name,
    required this.imagePath,
    required this.planetScreens,
  });

  @override
  State<SoloPlanetPage> createState() => _SoloPlanetPageState();
}

class _SoloPlanetPageState extends State<SoloPlanetPage> {
  int _currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.name.toUpperCase(),
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        //back arrow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(widget.imagePath, height: 150, fit: BoxFit.contain),
                const SizedBox(width: 20),
                Expanded(child: widget.planetScreens[_currentScreenIndex]),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentScreenIndex > 0
                    ? TextButton(
                        onPressed: () => setState(() => _currentScreenIndex--),
                        child: const Text(
                          "Previous",
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : const SizedBox(width: 80),


                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashScreen_Countdown(
                              planet: widget.name,
                              level: _currentScreenIndex + 1,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Quizteroid Quest Level ${_currentScreenIndex + 1} ",
                      ),
                    ),


                    const SizedBox(
                      width: 10,
                    ),
                    _currentScreenIndex < widget.planetScreens.length - 1
                        ? TextButton(
                            onPressed: () =>
                                setState(() => _currentScreenIndex++),
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : const SizedBox(
                            width: 60,
                          ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// --- PAINTER ---
class StarFieldPainter extends CustomPainter {
  final double animationValue; // This value will drive the continuous twinkle effect (from 0 to 1)
  final List<Star> stars;
 
  StarFieldPainter({required this.animationValue, required this.stars});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
   
    // time variable to drive the continuous sine wave
    double time = animationValue * 2 * pi;

    for (var star in stars) {
      // Calculate a unique twinkle value for each star based on its own phase and speed
      double normalizedSin = (sin(time * star.twinkleSpeed + star.twinklePhase) + 1) / 2;

      // Smoothly interpolate between the star's unique minimum and maximum opacity
      double currentOpacity = star.minOpacity + (normalizedSin * (star.maxOpacity - star.minOpacity));
     
      // Add a subtle glow effect for larger stars to enhance the visual depth
      if (star.size > 1.2) {
         paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.8);
      } else {
         paint.maskFilter = null;
      }

      paint.color = Colors.white.withValues(alpha: currentOpacity.clamp(0.0, 1.0));

      // Draw the star based on relative screen size
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}