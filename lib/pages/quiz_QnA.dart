final Map<String, Map<String, dynamic>> allQuizzes = {
  'sun_quiz': {
    'planet': 'Sun',
    'levels': {
      'basic': [
        // Sun basic level
        {
          'question': '1.  What type of object is the Sun?',
          'answers': ['Planet', 'Star', 'Gas giant'],
          'correct': 1  //Star
        },
        {
          'question': '2.  The Sun is shaped like a…',
          'answers': ['Sphere', 'Oblong', 'Circle'],
          'correct': 0 //Sphere
        },
        {
          'question': '3.  What gases make up most of the Sun?',
          'answers': ['Neon and\n  Helium', ' Hydrogen\nand Helium', 'Carbon Dioxide\n   and Helium'],
          'correct': 1  //Hydrogen and Helium
        },
        {
          'question': '4.  Does the Sun have a solid surface?',
          'answers': ['Yes', '   Only at\n the center', 'No'],
          'correct': 2  //No
        },
        {
          'question': '5.  What is the reason that keeps everything surrounding the Sun in orbit?',
          'answers': ['  Sun’s\nradiation', ' Sun’s\ngravity', ' Sun’s\nenergy'],
          'correct': 1 //Sun’s gravity
        },
        {
          'question': '6.  The Sun is the _____ object in the solar system.',
          'answers': ['Biggest', 'Fastest', 'Reddest'],
          'correct': 0 //Biggest
        },
        {
          'question': '7.  What streams of charged particles does the Sun send out?',
          'answers': [' Meteor\nshowers', 'Comets', 'Solar\nwind'],
          'correct': 2  //Solar wind
        },
        {
          'question': '8.  Where can you see the auroras caused by the Sun?',
          'answers': [' North and\nSouth Poles', 'Equator', ' Tropical\ncountries'],
          'correct': 0  //North and South Poles
        },
        {
          'question': '9.  Compared to other stars, the Sun is considered _________.',
          'answers': ['Tiny', 'Medium\n -sized', 'Huge'],
          'correct': 1  //Medium-sized
        },
        {
          'question': '10.  Why is the Sun important for life on Earth?',
          'answers': ['  It provides\nlight and heat', ' It makes\nEarth spin', '  It creates\nmoon phases'],
          'correct': 0 //It provides light and heat
        },
      ],
      // Sun intermediate level
      'intermediate': [
        {
          'question': '1.  The Sun is made mostly of a state of matter called _______.',
          'answers': ['Liquid', 'Gas', 'Plasma'],
          'correct': 2  //Plasma
        },
        {
          'question': '2.  Which part is the hottest part of the Sun?',
          'answers': ['Core', 'Surface', 'Flares'],
          'correct': 0 //Core
        },
        {
          'question': '3. What process produces the Sun’s energy?',
          'answers': ['  Photo-\nsynthesis', 'Nuclear\n fusion', 'Combustion'],
          'correct': 1  //Nuclear fusion
        },
        {
          'question': '4.  How long does the Sun take to rotate at the equator?',
          'answers': ['25 days', '39 days', '36 days'],
          'correct': 0  //25 days
        },
        {
          'question': '5.  How long does it take to rotate near the poles?',
          'answers': ['33 days', '36 days', '39 days'],
          'correct': 1 //36 days
        },
        {
          'question': '6.  What do the rings of dust around the Sun show?',
          'answers': ['Paths of\n planets', 'Comets', 'Asteroids'],
          'correct': 0 //Paths of planets
        },
        {
          'question': '7.  How fast does the Sun move through the Milky Way?',
          'answers': [' 100,000 \n   km/h ', ' 850,000 \n   km/h ', ' 720,000 \n   km/h '],
          'correct': 2  //720,000 km/h
        },
        {
          'question': '8.  How long does it take the Sun to orbit the galaxy?',
          'answers': ['  135M  \n  years  ', '  230M  \n  years  ', '  500M  \n  years  '],
          'correct': 1  //230 million years
        },
        {
          'question': '9.  Which part of the Sun is cooler than the corona?',
          'answers': ['Core', 'Flare', 'Photosphere'],
          'correct': 2  //Photosphere
        },
        {
          'question': '10. Plasma is special because it is:',
          'answers': ['Electrically\n  charged', 'Frozen', 'Solid'],
          'correct': 0 //Electrically charged
        },
      ],
      // Sun advanced level
      'advanced': [
        {
          'question': '1.  The Sun is what type of star?',
          'answers': ['G-type Main\n Sequence', 'Red Giant', 'F-type Main\n Sequence'],
          'correct': 0  //G-type Main-Sequence
        },
        {
          'question': '2.  What is another name for this type of star?',
          'answers': ['White giant', 'Blue dwarf', '  Yellow  \n  dwarf  '],
          'correct': 2 //Yellow dwarf
        },
        {
          'question': '3. What is the visible surface of the Sun called?',
          'answers': ['Photosphere', 'Corona', 'Core'],
          'correct': 0  //Photosphere
        },
        {
          'question': '4.  About how hot is the Sun’s photosphere?',
          'answers': ['2,500 °C', '5,500 °C', '15M °C'],
          'correct': 1  //5,500 °C
        },
        {
          'question': '5.  Which part of the Sun is hotter than the photosphere?',
          'answers': ['Core', 'Surface', 'Corona'],
          'correct': 2 //Corona
        },
        {
          'question': '6.  What percentage of the solar system’s mass does the Sun hold?',
          'answers': ['99.8%', '98.8%', '97.8%'],
          'correct': 0 //99.8%
        },
        {
          'question': '7. What will the Sun become after it runs out of fuel?',
          'answers': ['Gas giant', 'Red giant', 'Ice giant'],
          'correct': 1 //Red giant
        },
        {
          'question': '8.  What is the Sun’s final stage after becoming a red giant?',
          'answers': ['Black hole', 'Neutron\n   star', 'White dwarf'],
          'correct': 2  //White dwarf
        },
        {
          'question': '9.  Which process on Earth depends on the Sun for plants to make food?',
          'answers': ['  Photo-\nsynthesis', 'Respiration', 'Digestion'],
          'correct': 0  //Photosynthesis
        },
        {
          'question': '10. What are some signs that the Sun is active?',
          'answers': [' Rings & \n   rocks ', 'Sunspots &\n solar flares', '  Gas &  \n   dust  '],
          'correct': 1 //Sunspots and solar flares
        },
      ],
    }
  },

  'mercury_quiz': {
    'planet': 'mercury',
    'levels': {
      'basic': [
        {
          'question': '1.  At what time can people only observe Mercury from Earth?',
          'answers': ['Afternoon', 'Dawn', 'Midnight'],
          'correct': 1  //175.97
        },
        {
          'question': '2.  Mercury is slightly larger than which natural object in the solar system?',
          'answers': ['Earth’s Moon', 'Mars', 'Earth'],
          'correct': 0  //Earth’s Moon
        },
        {
          'question': '3.  What is the event called where Mercury can be observed from Earth as a black figure passing across the Sun?',
          'answers': ['Eclipse', 'Transit', 'Occultation'],
          'correct': 1  //Transit
        },
        {
          'question': '4.  Which natural object in the solar system does Mercury resemble due to its cratered look to its surface?',
          'answers': ['Mars', 'Earth’s Moon', 'Venus'],
          'correct': 1  //Earth’s Moon
        },
        {
          'question': '5.  How many moons or rings does Mercury have?',
          'answers': ['Zero', 'One', 'Two'],
          'correct': 0  //Zero
        },
        {
          'question': '6.  Despite being closest to the Sun, why is Mercury not the hottest planet?',
          'answers': ['It’s too small', 'It has no atmosphere to trap heat', 'It is covered in ice'],
          'correct': 1  //It has no atmosphere to trap heat
        },
        {
          'question': '7.  Which is NOT a similarity between Mercury and Earth’s Moon?',
          'answers': ['Cratered look', 'No rings', 'Gravity'],
          'correct': 2  //Gravity
        },
        {
          'question': '8.  How many times in a century does Mercury pass between the Sun and Earth?',
          'answers': ['13 times', '15 times', '18 times'],
          'correct': 0  //13 times
        },
        {
          'question': '9.  Mercury doesn’t have any atmosphere to retain Sun heat. Instead, it has a very thin outer layer called an _______.',
          'answers': ['Mesosphere', 'Thermosphere', 'Exosphere'],
          'correct': 2  //Exosphere
        },
        {
          'question': '10.  Which planet is the smallest and fastest to orbit in the solar system?',
          'answers': ['Mercury', 'Mars', 'Venus'],
          'correct': 0 //Mercury
        },
      ],
      'intermediate': [
        {
          'question': '1.  How long does Mercury take to orbit around the Sun?',
          'answers': ['365 days', '88 days', '30 days'],
          'correct': 1  //88 days
        },
        {
          'question': '2.  How fast does Mercury travel around the Sun?',
          'answers': ['47.87 km/s', '35.02 km/s', '29.78 km/s'],
          'correct': 0  //47.87 km/s
        },
        {
          'question': '3.  What is the equivalent number of Earth days in one mercury solar day (Day-Night cycle)?',
          'answers': ['160.25 days', '175.97 days', '186.97 days'],
          'correct': 1  //175.97 days
        },
        {
          'question': '4.  What is Mercury’s temperature during the day?',
          'answers': ['435°C', '471°C', '430°C'],
          'correct': 2  //430°C
        },
        {
          'question': '5.  What is Mercury’s temperature at night?',
          'answers': ['0°C', '-180°C', '-160°C'],
          'correct': 1  //-180°C
        },
        {
          'question': '6.  What makes up 80% of Mercury’s radius?',
          'answers': ['Metallic Core', 'Outer Shell', 'Mantle'],
          'correct': 0  //Metallic Core
        },
        {
          'question': '7.  Mercury is the ______ planet to orbit the Sun.',
          'answers': ['Slowest', 'Fastest', 'Average'],
          'correct': 1  //Fastest
        },
        {
          'question': '8.  Why does Mercury have extreme temperatures?',
          'answers': ['It has many moons', 'It has no thick atmosphere', 'It spins very fast'],
          'correct': 1  //It has no thick atmosphere
        },
        {
          'question': '9.  How does the Sun appear from Mercury?',
          'answers': ['Smaller', 'The same size', 'More than three times larger'],
          'correct': 2  //More than three times larger
        },
        {
          'question': '10.  Mercury is the ______ densest planet.',
          'answers': ['Least', 'Second', 'Third'],
          'correct': 1  //Second
        },
      ],
      'advanced': [
        {
          'question': '1.  What is Mercury’s thin outer layer called?',
          'answers': ['Mesosphere', 'Thermosphere', 'Exosphere'],
          'correct': 2  //Exosphere
        },
        {
          'question': '2.  What pushes atoms away from Mercury?',
          'answers': ['Gravity', 'Solar Wind', 'Transit'],
          'correct': 1  //Solar Wind
        },
        {
          'question': '3.  What element/s are found in Mercury’s exosphere?',
          'answers': ['Helium only', 'Carbon dioxide and nitrogen', 'Sodium, oxygen, and hydrogen'],
          'correct': 2  //Sodium, oxygen, and hydrogen
        },
        {
          'question': '4.  What forms behind Mercury due to escaping particles?',
          'answers': ['Comet-like tail', 'Rings', 'Darkness'],
          'correct': 0  //Comet-like tail
        },
        {
          'question': '5.  What spacecraft studied Mercury closely?',
          'answers': ['Venera 14', 'Artemis II', 'MESSENGER'],
          'correct': 2  //MESSENGER
        },
        {
          'question': '6.  When did MESSENGER orbit Mercury?',
          'answers': ['1986', '2011', '2000'],
          'correct': 1  //2011
        },
        {
          'question': '7.  What was found in Mercury’s polar craters?',
          'answers': ['Water ice', 'Methane', 'Carbon dioxide'],
          'correct': 0  //Water ice
        },
        {
          'question': '8.  Why do some craters on Mercury stay very cold?',
          'answers': ['They are underwater', 'No sunlight reaches them', 'They spin away from the Sun'],
          'correct': 1  //No sunlight reaches them
        },
        {
          'question': '9.  What causes atoms to escape Mercury’s surface?',
          'answers': ['Solar Wind', 'Gravity', 'Magnetic Field'],
          'correct': 0  //Solar Wind
        },
        {
          'question': '10.  What type of magnetic field does Mercury have?',
          'answers': ['None', 'Weak magnetic field', 'Very strong magnetic field'],
          'correct': 1  //Weak magnetic field
        },
      ],
    }
  },

  'venus_quiz': {
    'planet': 'venus',
    'levels': {
      'basic': [
        {
          'question': '1.  Which planet is called Earth’s “Evil Twin”?',
          'answers': ['Mars', 'Mercury', 'Venus'],
          'correct': 2  //Venus
        },
        {
          'question': '2.  What is the maximum surface temperature on Venus?',
          'answers': ['300°C', '400°C', '471°C'],
          'correct': 2  //471°C
        },
        {
          'question': '3.  Venus is often called Earth’s _________ because of their similar size?',
          'answers': ['Neighbor planet', 'Evil twin', 'Sister planet'],
          'correct': 1  //Evil twin
        },
        {
          'question': '4.  Why is Venus the hottest planet?',
          'answers': ['It is closest to the Sun', 'Its atmosphere traps heat', 'It has more volcanoes'],
          'correct': 1  //Its atmosphere traps heat
        },
        {
          'question': '5.  Why is Venus very bright in the sky?',
          'answers': ['It produces its own light', 'Its clouds reflect sunlight', 'It is covered in ice'],
          'correct': 1  //Its clouds reflect sunlight
        },
        {
          'question': '6.  What direction does the Sun rise on Venus?',
          'answers': ['East', 'West', 'North'],
          'correct': 1  //West
        },
        {
          'question': '7.  How many moons does Venus have?',
          'answers': ['Zero', 'One', 'Two'],
          'correct': 0  //Zero
        },
        {
          'question': '8.  Venus is the _______ planet from the Sun.',
          'answers': ['First', 'Second', 'Third'],
          'correct': 1  //Second
        },
        {
          'question': '9.  What nickname is given to Venus because it shines brightly?',
          'answers': ['Red Planet', 'Blue Planet', 'Morning Star'],
          'correct': 2  //Morning Star
        },
        {
          'question': '10.  What can Venus’ heat melt?',
          'answers': ['Iron', 'Aluminium', 'Lead'],
          'correct': 2  //Lead
        },
      ],
      'intermediate': [
        {
          'question': '1.  Venus’ atmosphere is mainly made of what gas?',
          'answers': ['Oxygen', 'Carbon dioxide', 'Nitrogen'],
          'correct': 1  //Carbon dioxide
        },
        {
          'question': '2.  What are Venus’ clouds made of?',
          'answers': ['Water vapor', 'Sulfuric acid', 'Methane'],
          'correct': 1  //Sulfuric acid
        },
        {
          'question': '3.  How strong is the air pressure on Venus compared to Earth?',
          'answers': ['10 times', '50 times', '90 times'],
          'correct': 2  //90 times
        },
        {
          'question': '4.  What is special about time on Venus?',
          'answers': ['A day is shorter than a year', 'A day is longer than a year', 'A day is 24 hours'],
          'correct': 1  //A day is longer than a year
        },
        {
          'question': '5.  How many Earth days does Venus take to rotate once?',
          'answers': ['100 days', '243 days', '365 days'],
          'correct': 1  //243 days
        },
        {
          'question': '6.  How many Earth days does Venus take to orbit the Sun?',
          'answers': ['225 days', '365 days', '500 days'],
          'correct': 0  //225 days
        },
        {
          'question': '7.  What weather phenomenon was confirmed on Venus in 2007?',
          'answers': ['Snow', 'Lightning', 'Rain'],
          'correct': 1  //Lightning
        },
        {
          'question': '8.  Venus’ lightning is related to what type of clouds?',
          'answers': ['Water clouds', 'Sulfuric acid clouds', 'Ice clouds'],
          'correct': 1  //Sulfuric acid clouds
        },
        {
          'question': '9. What is it like to stand on Venus because of pressure?',
          'answers': ['Like flying', 'Like being in space', 'Like being deep underwater'],
          'correct': 2  //Like being deep underwater
        },
        {
          'question': '10.  What is the event called when Venus passes in front of the Sun?',
          'answers': ['Transit', 'Eclipse', 'Rotation'],
          'correct': 0  //Transit
        },
      ],
      'advanced': [
        {
          'question': '1.  What causes Venus to be extremely hot?',
          'answers': ['Distance from the Sun', 'Greenhouse effect', 'Lack of gravity'],
          'correct': 1  //Greenhouse effect
        },
        {
          'question': '2.  What is the greenhouse effect?',
          'answers': ['Trapping of heat by gases', 'Cooling of the planet', 'Freezing of clouds'],
          'correct': 0  //Trapping of heat by gases
        },
        {
          'question': '3.  Which spacecraft confirmed lightning on Venus?',
          'answers': ['Venera 11', 'Venera 12', 'Venus Express'],
          'correct': 2  //Venus Express
        },
        {
          'question': '4.  What is the rotation of Venus called?',
          'answers': ['Retrograde rotation', 'Forward rotation', 'Side rotation'],
          'correct': 0  //Retrograde rotation
        },
        {
          'question': '5.  Why does the Sun rise in the West on Venus?',
          'answers': ['Cloud reflection', 'Backward rotation', 'Fast orbit'],
          'correct': 1  //Backward rotation
        },
        {
          'question': '6.  How does Venus compare to Mercury in temperature?',
          'answers': ['Colder', 'Same', 'Hotter'],
          'correct': 2  //Hotter
        },
        {
          'question': '7.  What happens to water on Venus?',
          'answers': ['It freezes', 'It evaporates', 'It turns into ice clouds'],
          'correct': 1  //It evaporates
        },
        {
          'question': '8.  What moves faster on Venus?',
          'answers': ['The atmosphere', 'The ground', 'The core'],
          'correct': 0  //The atmosphere
        },
        {
          'question': '9. Why is Venus considered dangerous?',
          'answers': ['It has no gravity', 'It has toxic air and extreme heat', 'It is too small'],
          'correct': 2  //It has toxic air and extreme heat
        },
        {
          'question': '10.  What type of clouds help create lightning on Venus?',
          'answers': ['Ice clouds', 'Dust clouds', 'Sulfuric acid clouds '],
          'correct': 2  //Sulfuric acid clouds
        },
      ],
    }
  },

  'earth_quiz': {
    'planet': 'earth',
    'levels': {
      'basic': [
        {
          'question': '1. Earth is the only known world in the solar system to support what?',
          'answers': ['Life', 'Rings', 'Gas'],
          'correct': 0  //Life
        },
        {
          'question': '2. Where does the name “Earth” originate from?',
          'answers': ['Roman Mythology', 'Greek Mythology', 'Old English'],
          'correct': 2  //Old English
        },
        {
          'question': '3. Earth is the ____ planet from the Sun.',
          'answers': ['First', 'Second', 'Third'],
          'correct': 2  //Third
        },
        {
          'question': '4. Earth is the densest planet because of its large core made of…',
          'answers': ['Gold', 'Iron', 'Rock'],
          'correct': 1  //Iron
        },
        {
          'question': '5. Why is Earth the densest planet in the solar system?',
          'answers': ['Due to its many oceans', 'Because it has life', 'Due to its large iron core'],
          'correct': 2  //Due to its large iron core
        },
        {
          'question': '6. Unlike the other planets, Earth is NOT named after what?',
          'answers': ['Greek or Roman gods', 'Famous scientists and astronauts', 'Different types of rocks'],
          'correct': 0  //Greek or Roman gods
        },
        {
          'question': '7. What helps protect Earth from small meteors?',
          'answers': ['The Moon', 'The atmosphere', 'The oceans'],
          'correct': 1  //The atmosphere
        },
        {
          'question': '8. How long does the Earth take to rotate once?',
          'answers': ['12 hours', '24 hours', '48 hours'],
          'correct': 1  //24 hours
        },
        {
          'question': '9. Why do we have a leap year?',
          'answers': ['Because Earth spins faster', 'Because of the Moon', 'Because of the extra 0.25 day'],
          'correct': 2  //Because of the extra 0.25 day
        },
        {
          'question': '10. What color does Earth primarily appear as when seen from outer space?',
          'answers': ['Blue', 'Green', 'Red'],
          'correct': 0 //Blue
        },
      ],
      'intermediate': [
        {
          'question': '1. Which best describes the shape of Earth?',
          'answers': ['Perfect sphere', 'Oblate spheroid', 'Oblong'],
          'correct': 1  //Oblate spheroid
        },
        {
          'question': '2. What causes Earth to bulge slightly at the equator?',
          'answers': ['Strong winds', 'Its rotation', 'Ocean movement'],
          'correct': 1  //Its rotation
        },
        {
          'question': '3. Earth’s axis is tilted at 23.45°, which results in what?',
          'answers': ['Four Seasons', 'Day and night cycles', 'Weather patterns'],
          'correct': 0  //Four Seasons
        },
        {
          'question': '4. What happens when a part of Earth is tilted toward the Sun?',
          'answers': ['It gets less sunlight', 'It freezes', 'It becomes warmer'],
          'correct': 2  //It becomes warmer
        },
        {
          'question': '5. What happens six months after one hemisphere experiences summer?',
          'answers': ['It stays the same', 'The opposite hemisphere experiences summer', 'The Sun stops moving'],
          'correct': 1  //The opposite hemisphere experiences summer
        },
        {
          'question': '6. What is special about spring and fall in terms of sunlight?',
          'answers': ['Both hemispheres receive similar sunlight', 'Only one hemisphere gets light', 'The poles receive the most sunlight'],
          'correct': 0  //Both hemispheres receive similar sunlight
        },
        {
          'question': '7. What percentage of Earth’s surface is covered by water?',
          'answers': ['30%', '50%', '71%'],
          'correct': 2  //71%
        },
        {
          'question': '8. Why is water important to Earth?',
          'answers': ['It makes Earth spin faster', 'It helps control temperature and supports life', 'It creates gravity'],
          'correct': 1  //It helps control temperature and supports life
        },
        {
          'question': '9. What does Earth’s atmosphere mainly do for the planet?',
          'answers': ['Protects from harmful radiation and keeps it warm', 'Changes Earth’s shape', 'Creates oceans'],
          'correct': 0  //Protects from harmful radiation and keeps it warm
        },
        {
          'question': '10. Why do places near the equator stay warm most of the year?',
          'answers': ['They are closer to the Sun', 'They have fewer clouds', 'They receive more direct sunlight'],
          'correct': 2  //They receive more direct sunlight
        },
      ],
      'advanced': [
        {
          'question': '1. What is 97% of Earth’s water?',
          'answers': ['Sweet oceans', 'Drinkable water', 'Salty oceans'],
          'correct': 2  //Salty oceans
        },
        {
          'question': '2. What percentage of Earth’s water is fresh water?',
          'answers': ['3%', '10%', '25%'],
          'correct': 0  //3%
        },
        {
          'question': '3. What is Earth’s outer layer called?',
          'answers': ['Thermosphere', 'Lithosphere', 'Exosphere'],
          'correct': 1  //Lithosphere
        },
        {
          'question': '4. Near the surface, our atmosphere is 78% of which gas?',
          'answers': ['Oxygen', 'Hydrogen', 'Nitrogen'],
          'correct': 2  //Nitrogen
        },
        {
          'question': '5. What are the large moving pieces of Earth’s outer layer called?',
          'answers': ['Tectonic plates', 'Continents', 'Magma layers'],
          'correct': 0  //Tectonic plates
        },
        {
          'question': '6. What forms when tectonic plates collide?',
          'answers': ['Volcanoes', 'Mountain ranges', 'Earthquakes'],
          'correct': 1  //Mountain ranges
        },
        {
          'question': '7. What can happen when tectonic plates move apart or slide past each other?',
          'answers': ['Earthquakes', 'Ocean tides', 'Sink holes'],
          'correct': 0  //Earthquakes
        },
        {
          'question': '8. How many moons does Earth have?',
          'answers': ['Zero', 'One', 'Two'],
          'correct': 1  //One
        },
        {
          'question': '9. Which is NOT the effect on Earth by the moon’s gravity?',
          'answers': ['Secure Earth’s gravity', 'Stabilizes the climate', 'Steadies the rotation'],
          'correct': 0  //Secure Earth’s gravity
        },
        {
          'question': '10. Besides nitrogen and oxygen, what percentage of the atmosphere is made of “other ingredients”?',
          'answers': ['1%', '10%', '21%'],
          'correct': 0  //1%
        },
      ],
    }
  },

  'mars_quiz': {
    'planet': 'mars',
    'levels': {
      'basic': [
        {
          'question': '1.  Which planet is known as the ‘Red Planet’ because of the iron minerals in its soil?',
          'answers': ['Mercury', 'Venus', 'Mars'],
          'correct': 2  //Mars
        },
        {
          'question': '2. Mars has seasons because its axis is tilted by how many degrees?',
          'answers': ['0°', '25°', '45°'],
          'correct': 1  //25°
        },
        {
          'question': '3. Compared to Earth, how long does a Martian year last?',
          'answers': ['365 days', '687 days', '10 days'],
          'correct': 1  //687 days
        },
        {
          'question': '4. What color does the Martian sky appear during the day?',
          'answers': ['Blue-green', 'Reddish-orange', 'Yellowish-white'],
          'correct': 1  //Reddish-orange
        },
        {
          'question': '5. Sunsets on Mars actually appear as what color?',
          'answers': ['Blue', 'Red', 'Green'],
          'correct': 0 //Blue
        },
        {
          'question': '6. Mars is actively explored by what?',
          'answers': ['Satellites', 'Comets', 'Rovers'],
          'correct': 2  //Rovers
        },
        {
          'question': '7. Does Mars have rings?',
          'answers': ['Yes', 'No', 'Only at night'],
          'correct': 1  //No
        },
        {
          'question': '8. Why does Mars appear red?',
          'answers': ['Iron minerals in its soil', 'Oxygen in the atmosphere', 'Methane clouds'],
          'correct': 0  //Iron minerals in its soil
        },
        {
          'question': '9. The ice on Mars grows in winter and shrinks in summer. What is it made of?',
          'answers': ['Ice water and Oxygen', 'Nitrogen and Ice water', 'Carbon dioxide and Ice water'],
          'correct': 2  //Carbon dioxide and Ice water
        },
        {
          'question': '10. Mars is similar to Earth because it has:',
          'answers': ['Oceans', 'Seasons', 'Gas rings'],
          'correct': 1  //Seasons
        },
      ],
      'intermediate': [
        {
          'question': '1.  A Martian solar day is called a what?',
          'answers': ['Sol', 'Sun-day', 'Mars-day'],
          'correct': 0  //Sol
        },
        {
          'question': '2. How long is one sol on Mars?',
          'answers': ['24 hours', '24.6 hours', '25.6 hours'],
          'correct': 1  //24.6 hours
        },
        {
          'question': '3. How long does it take Mars to complete one orbit around the Sun?',
          'answers': ['365 days', '687 days', '10 days'],
          'correct': 1  //687 days
        },
        {
          'question': '4. WWhy can’t liquid water exist on the Martian surface today?',
          'answers': ['It’s too hot', 'The atmosphere is too thin', 'There is no gravity'],
          'correct': 1  //The atmosphere is too thin
        },
        {
          'question': '5. Where is water currently trapped on Mars?',
          'answers': ['In the polar ice caps', 'In the oceans', 'In the volcanoes'],
          'correct': 1 //In the polar ice caps
        },
        {
          'question': '6. Mars has seasons similar to Earth because its axis is tilted about:',
          'answers': ['22°', '25°', '30.5°'],
          'correct': 1  //25°
        },
        {
          'question': '7. Which factor causes Mars to be so cold compared to Earth?',
          'answers': ['Closer to the Sun', 'Thin atmosphere', 'Fast rotation'],
          'correct': 1  //Thin atmosphere
        },
        {
          'question': '8. Mars can have clouds, wind, and snow because:',
          'answers': ['Its atmosphere is active enough', 'Its core is hot', 'Its moons create storms'],
          'correct': 0  //Its atmosphere is active enough
        },
        {
          'question': '9. Which planet also has ice that grows and shrinks seasonally like Mars?',
          'answers': ['Venus', 'Jupiter', 'Earth'],
          'correct': 2  //Earth
        },
        {
          'question': '10. Why is the Martian day slightly longer than an Earth day?',
          'answers': ['Rotation is faster', '24.6 hours sol', 'Orbit is longer'],
          'correct': 1  //24.6 hours sol
        },
      ],
      'advanced': [
        {
          'question': '1. What is the name of the innermost moon of Mars?',
          'answers': ['Phobos', 'Deimos', 'Oberon'],
          'correct': 0  //Phobos
        },
        {
          'question': '2. Mars has two tiny, lumpy moons named Phobos and…',
          'answers': ['Titan', 'Io', 'Deimos'],
          'correct': 2  //Deimos
        },
        {
          'question': '3. What is the shape of Mars’ moons, Phobos and Deimos?',
          'answers': ['Perfectly round', 'Potato-shaped', 'Square-shaped'],
          'correct': 1  //Potato-shaped
        },
        {
          'question': '4. Phobos is heavily cratered and has:',
          'answers': ['Smooth plains', 'Volcanoes', 'Deep grooves'],
          'correct': 2  //Deep grooves
        },
        {
          'question': '5. Deimos is smoother because:',
          'answers': ['Dust fills its craters', 'It is larger', 'It is closer to the Sun'],
          'correct': 0  //Dust fills its craters
        },
        {
          'question': '6. Mars’ core is made of:',
          'answers': ['Hydrogen', 'Helium', 'Iron, nickel, and sulfur'],
          'correct': 2  //Iron, nickel, and sulfur
        },
        {
          'question': '7. What layer above the core causes marsquakes?',
          'answers': ['Crust', 'Rocky mantle', 'Atmosphere'],
          'correct': 0  //Crust
        },
        {
          'question': '8. How thick is Mars’ crust?',
          'answers': ['1–5 km', '10–50 km', '50–100 km'],
          'correct': 1  //10–50 km
        },
        {
          'question': '9. What is the name of the largest volcano in the solar system located on Mars?',
          'answers': ['Olympus Mons', 'Olympus Mona', 'Mauna Loa'],
          'correct': 0  //Olympus Mons
        },
        {
          'question': '10. How big is the base of Olympus Mons roughly comparable to?',
          'answers': ['Texas', 'California', 'Arizona'],
          'correct': 2  //Arizona
        },
      ],
    }
  },

  'jupiter_quiz': {
    'planet': 'jupiter',
    'levels': {
      'basic': [
        {
          'question': '1. Jupiter is the largest planet. How many Earths can fit inside it?',
          'answers': ['100', '500', 'Over 1,300'],
          'correct': 2 //Over 1,300
        },
        {
          'question': '2. Jupiter is mostly composed of Hydrogen and…',
          'answers': ['Oxygen', 'Helium', 'Nitrogen'],
          'correct': 1 //Helium
        },
        {
          'question': '3. As Jupiter does not have a solid surface, this planet is considered a _________.',
          'answers': ['Gas giant', 'Landless planet', 'Air giant'],
          'correct': 0 //Gas giant
        },
        {
          'question': '4. Jupiter is often called a “miniature solar system” because of its…',
          'answers': ['Size', 'Many moons', 'Own Sun'],
          'correct': 1 //Many moons
        },
        {
          'question': '5. How many officially recognized moons does Jupiter have?',
          'answers': ['12', '50', '95'],
          'correct': 2 //95
        },
        {
          'question': '6. Which moon is the largest in the entire solar system?',
          'answers': ['Ganymede', 'Europa', 'Callisto'],
          'correct': 0 //Ganymede
        },
        {
          'question': '7. Jupiter acts like a “space vacuum” because its gravity pulls in…',
          'answers': ['Comets and asteroids', 'Other planets', 'The sun'],
          'correct': 0 //Comets and asteroids
        },
        {
          'question': '8. When were Jupiter’s rings discovered?',
          'answers': ['1969', '1979', '1989'],
          'correct': 1 //1979
        },
        {
          'question': '9. Jupiter’s faint rings are made up of…',
          'answers': ['Ice crystals', 'Rocks', 'Dark particles'],
          'correct': 2 //Dark particles
        },
        {
          'question': '10. Why is Jupiter considered a gas giant?',
          'answers': ['It has a solid core', 'It is made of gases', 'It has a solid surface'],
          'correct': 1 //It is made of gases
        }
      ],
      'intermediate': [
        {
          'question': '1. How long does it take Jupiter to spin once?',
          'answers': ['23.9 hours', '9.9 hours', '5.9 hours'],
          'correct': 1 //9.9 hours
        },
        {
          'question': '2. What is the “ocean” inside Jupiter actually made of?',
          'answers': ['Water', 'Liquid metallic hydrogen', 'Lava'],
          'correct': 1 //Liquid metallic hydrogen
        },
        {
          'question': '3. What is the reason why spacecrafts get crushed and vaporized if they fly through Jupiter?',
          'answers': ['Intense pressure', 'Intense storm', 'Intense oceans'],
          'correct': 0 //Intense pressure
        },
        {
          'question': '4. Jupiter features the largest ____ in the solar system.',
          'answers': ['Lake', 'Volcanoes', 'Oceans'],
          'correct': 2 //Oceans
        },
        {
          'question': '5. While there is no solid surface, how does this gas giant create liquid?',
          'answers': ['Freezing gas', 'Compressing hydrogen', 'Chemical reactions'],
          'correct': 1 //Compressing hydrogen
        },
        {
          'question': '6. Liquids help Jupiter to generate what?',
          'answers': ['Intense temperatures', 'Powerful magnetic field', 'Strong gravitational pull'],
          'correct': 1 //Powerful magnetic field
        },
        {
          'question': '7. Jupiter has a small axial tilt with only ___?',
          'answers': ['3 degrees', '4 degrees', '5 degrees'],
          'correct': 0 //3 degrees
        },
        {
          'question': '8. Due to Jupiter’s fast rotation, what effects happened at its equator?',
          'answers': ['Became flatter', 'Became brighter', 'Became wider'],
          'correct': 2 //Became wider
        },
        {
          'question': '9. How long does it take Jupiter to orbit around the Sun?',
          'answers': ['20 years', '12 years', '9.9 hours'],
          'correct': 1 //12 years
        },
        {
          'question': '10. Which is NOT the effect of Jupiter’s fast rotation?',
          'answers': ['Creates hexagon storms', 'Produces strong winds', 'Rapid weather changes'],
          'correct': 0 //Creates hexagon storms
        }
      ],
      'advanced': [
        {
          'question': '1. What did the difference in temperature, chemical composition, and rising gases create?',
          'answers': ['Distinct colorful bands', 'Distinct colorful moons', 'Distinct colorful oceans'],
          'correct': 0 //Distinct colorful bands
        },
        {
          'question': '2. What is the name of the hurricane-like storm that has lasted for centuries?',
          'answers': ['The Blue Spot', 'The Great Red Spot', 'The Giant Whirlpool'],
          'correct': 1  //The Great Red Spot
        },
        {
          'question': '3. Which moon is thought to have a vast ocean hidden under ice?',
          'answers': ['Europa', 'Io', 'Phobos'],
          'correct': 0 //Europa
        },
        {
          'question': '4. What are the two types of colorful bands of Jupiter?',
          'answers': ['Belts & Zones', 'Phobos & Deimos', 'Ring & Sash'],
          'correct': 0 //Belts & Zones
        },
        {
          'question': '5. How much stronger is Jupiter’s magnetic field compared to Earth’s?',
          'answers': ['50 times', '104 times', '14 times'],
          'correct': 2 //14 times
        },
        {
          'question': '6. What does Jupiter produce from its massive gravity and rotation?',
          'answers': ['Tornadoes', 'Auroras', 'Ice'],
          'correct': 1 //Auroras
        },
        {
          'question': '7. Which makes up the top layer of Jupiter’s clouds?',
          'answers': ['Ammonia ice', 'Ammonium hydrosulfide ice', 'Water vapor and ice'],
          'correct': 0 //Ammonia ice
        },
        {
          'question': '8. What do you call a darker band of Jupiter?',
          'answers': ['Zones', 'Belts', 'Flare'],
          'correct': 1 //Belts
        },
        {
          'question': '9. From what Jupiter protects Earth and its moons?',
          'answers': ['Cosmic dust', 'Solar wind', 'Solar radiation'],
          'correct': 2 //Solar radiation
        },
        {
          'question': '10. Which makes up the middle layer of Jupiter’s clouds?',
          'answers': ['Ammonia ice', 'Ammonium hydrosulfide ice', 'Water vapor and ice'],
          'correct': 1 //Ammonium hydrosulfide ice
        }
      ]
    }
  },

  'saturn_quiz': {
    'planet': 'saturn',
    'levels': {
      'basic': [
        {
          'question': '1. Saturn is the sixth planet from the Sun and is best known for its…',
          'answers': ['Volcanoes', 'Rings', 'Great Red Spot'],
          'correct': 1 //Rings
        },
        {
          'question': '2. Saturn is classified as what type of planet?',
          'answers': ['Liquid giant', 'Gas giant', 'Rocky planet'],
          'correct': 1 //Gas giant
        },
        {
          'question': '3. Saturn is mostly made up of which two gases?',
          'answers': ['Carbon dioxide and methane', 'Oxygen and nitrogen', 'Hydrogen and helium'],
          'correct': 2 //Hydrogen and helium
        },
        {
          'question': '4. Why does Saturn have no solid surface?',
          'answers': ['It is made of gas and liquid', 'It is covered in water', 'It is too hot to form land'],
          'correct': 0 //It is made of gas and liquid
        },
        {
          'question': '5. Saturn’s rings are mainly made of rock and…',
          'answers': ['Ice', 'Water', 'Dark particles'],
          'correct': 0 //Ice
        },
        {
          'question': '6. What is the name of Saturn’s largest moon?',
          'answers': ['Ganymede', 'Titan', 'Triton'],
          'correct': 1 //Titan
        },
        {
          'question': '7. Why does Titan look almost like a planet?',
          'answers': ['It has rings', 'It has a thick atmosphere', 'It glows in the dark'],
          'correct': 1 //It has a thick atmosphere
        },
        {
          'question': '8. How many moons does Saturn have?',
          'answers': ['50', '95', '146'],
          'correct': 2 //146
        },
        {
          'question': '9. Compared to water, Saturn is…',
          'answers': ['More dense', 'Less dense', 'Exactly the same density'],
          'correct': 1 //Less dense
        },
        {
          'question': '10. Because Saturn is less dense than water, it would actually…',
          'answers': ['Sink', 'Float', 'Melt'],
          'correct': 1 //Float
        }
      ],
      'intermediate': [
        {
          'question': '1. Saturn’s rings are labeled using which system?',
          'answers': ['Letters A–G', 'Numbers 1–7', 'Weight'],
          'correct': 0 //Letters A–G
        },
        {
          'question': '2. What is the name of the large gap between Saturn’s A and B rings?',
          'answers': ['The Great Gap', 'The Cassini Division', 'The Dark Zone'],
          'correct': 1 //The Cassini Division
        },
        {
          'question': '3. How long does Saturn take to rotate or complete a full spin?',
          'answers': ['10.7 hours', '10.9 hours', '11.7 hours'],
          'correct': 0 //10.7 hours
        },
        {
          'question': '4. Why does Saturn have a short day but a long year?',
          'answers': ['It spins fast but is far from the Sun', 'It spins slowly but is close to the Sun', 'It does not move'],
          'correct': 0 //It spins fast but is far from the Sun
        },
        {
          'question': '5. How long does it take Saturn to orbit the Sun?',
          'answers': ['25 years', '26.4 years', '29.4 years'],
          'correct': 2 //29.4 years
        },
        {
          'question': '6. What is the average temperature on Saturn?',
          'answers': ['0°C', '-108°C', '-138°C'],
          'correct': 2 //-138°C
        },
        {
          'question': '7. Why can’t a spacecraft safely land on Saturn?',
          'answers': ['Because of its strong gravitational pull', 'It has no solid surface', 'It is too small'],
          'correct': 1 //It has no solid surface
        },
        {
          'question': '8. What would happen to a spacecraft deep inside Saturn?',
          'answers': ['It would freeze only', 'It would be crushed and melted', 'It would float uncontrollably'],
          'correct': 1 //It would be crushed and melted
        },
        {
          'question': '9. Winds in Saturn’s atmosphere can reach speeds of…',
          'answers': ['100km/h', '500km/h', '1,800km/h'],
          'correct': 2 //1,800km/h
        },
        {
          'question': '10. Why does Saturn appear slightly flattened?',
          'answers': ['Because of its fast rotation', 'Because of its extremely low density', 'Because of its rings'],
          'correct': 0 //Because of its fast rotation
        }
      ],
      'advanced': [
        {
          'question': '1. What unique shape is the permanent storm at Saturn’s north pole?',
          'answers': ['Circle', 'Triangle', 'Hexagon'],
          'correct': 2 //Hexagon
        },
        {
          'question': '2. About how wide is this hexagon-shaped storm?',
          'answers': ['3,000 km', '30,000 km', '300,000 km'],
          'correct': 1 //30,000 km
        },
        {
          'question': '3. What lies at the center of the hexagon storm?',
          'answers': ['A volcano', 'A hurricane-like storm', 'A solid core'],
          'correct': 1 //A hurricane-like storm
        },
        {
          'question': '4. Which spacecraft first observed Saturn’s hexagon storm?',
          'answers': ['Voyager I', 'Artemis II', 'Apollo I'],
          'correct': 0 //Voyager I
        },
        {
          'question': '5. What is the name of the largest and invisible ring in Saturn, much bigger than the main rings?',
          'answers': ['Phoebe ring', 'E ring', 'Ebeoph ring'],
          'correct': 0 //Phoebe ring
        },
        {
          'question': '6. What is the Phoebe ring mostly made of?',
          'answers': ['Ice chunks', 'Dark dust particles', 'Liquid gas'],
          'correct': 1 //Dark dust particles
        },
        {
          'question': '7. The Phoebe ring likely came from which object?',
          'answers': ['Titan', 'Phoebe', 'Europa'],
          'correct': 1 //Phoebe
        },
        {
          'question': '8. How large is the Phoebe ring compared to Saturn?',
          'answers': ['Same size', '2–70 times larger', '100–270 times larger'],
          'correct': 2 //100–270 times larger
        },
        {
          'question': '9. What are Saturn’s upper cloud layers mainly made of?',
          'answers': ['Oxygen and nitrogen', 'Ammonia and other compounds', 'Pure ice water only'],
          'correct': 1 //Ammonia and other compounds
        },
        {
          'question': '10. Why does Saturn give off more energy than it receives from the Sun?',
          'answers': ['Leftover heat from formation', 'Nuclear fusion inside', 'Reflection of sunlight'],
          'correct': 0 //Leftover heat from formation
        }
      ]
    }
  },

  'uranus_quiz': {
    'planet': 'uranus',
    'levels': {
      'basic': [
        {
          'question': '1. Uranus is the _______ planet from the Sun.',
          'answers': ['Fifth', 'Sixth', 'Seventh'],
          'correct': 2 //Seventh
        },
        {
          'question': '2. What is unusual about how Uranus moves?',
          'answers': ['It spins very fast', 'It rotates on its side', 'It does not spin'],
          'correct': 1 //It rotates on its side
        },
        {
          'question': '3. Uranus is classified as what type of planet?',
          'answers': ['Gas giant', 'Ice giant', 'Rocky planet'],
          'correct': 1 //Ice giant
        },
        {
          'question': '4. What color is Uranus when seen from space?',
          'answers': ['Red', 'Yellow', 'Blue-green'],
          'correct': 2 //Blue-green
        },
        {
          'question': '5. What gas gives Uranus its blue-green color?',
          'answers': ['Oxygen', 'Carbon dioxide', 'Methane'],
          'correct': 2 //Methane
        },
        {
          'question': '6. Which planet is known as the coldest in the solar system?',
          'answers': ['Mars', 'Neptune', 'Uranus'],
          'correct': 2 //Uranus
        },
        {
          'question': '7. What is found at the center of Uranus?',
          'answers': ['Gas', 'Rock', 'Ice'],
          'correct': 1 //Rock
        },
        {
          'question': '8. Does Uranus have rings?',
          'answers': ['No', 'Yes', 'Only one'],
          'correct': 1 //Yes
        },
        {
          'question': '9. Uranus was the first planet discovered using what?',
          'answers': ['The naked eye', 'A telescope', 'A satellite'],
          'correct': 1 //A telescope
        },
        {
          'question': '10. Who discovered Uranus?',
          'answers': ['Galileo', 'William Herschel', 'Isaac Newton'],
          'correct': 1 //William Herschel
        }
      ],
      'intermediate': [
        {
          'question': '1. How long can one side of Uranus face the Sun?',
          'answers': ['18 years', '21 years', '37 years'],
          'correct': 1 //21 years
        },
        {
          'question': '2. Why does Uranus experience extreme seasons?',
          'answers': ['It is very far from the Sun', 'It has many moons', 'It is tilted on its side'],
          'correct': 2 //It is tilted on its side
        },
        {
          'question': '3. How many rings does Uranus have?',
          'answers': ['5', '10', '13'],
          'correct': 2 //13
        },
        {
          'question': '4. What are Uranus’ rings mostly made of?',
          'answers': ['Small dark particles', 'Ice blocks', 'Gas clouds'],
          'correct': 0 //Small dark particles
        },
        {
          'question': '5. How many moons does Uranus have?',
          'answers': ['12', '23', '28'],
          'correct': 2 //28
        },
        {
          'question': '6. Uranus’ moons are mostly named after characters created by…',
          'answers': ['Scientists', 'Writers and poets', 'Astronauts'],
          'correct': 1 //Writers and poets
        },
        {
          'question': '7. Which writers are specifically mentioned for Uranus’ moon names?',
          'answers': ['Charles Dickens and Maya Angelou', 'William Shakespeare and Alexander Pope', 'Mark Twain and Robert Frost'],
          'correct': 1 //William Shakespeare and Alexander Pope
        },
        {
          'question': '8. What are the names of some of Uranus’ moons mentioned in the info?',
          'answers': ['Titania and Oberon', 'Europa and Ganymede', 'Titan and Rhea'],
          'correct': 0 //Titania and Oberon
        },
        {
          'question': '9. About how long is one day on Uranus?',
          'answers': ['24 hours', '17 hours', '40 hours'],
          'correct': 1 //17 hours
        },
        {
          'question': '10. Compared to Earth, Uranus’ day is ___________.',
          'answers': ['Shorter', 'The same', 'Longer'],
          'correct': 0 //Shorter
        }
      ],
      'advanced': [
        {
          'question': '1. About how far is Uranus from the Sun?',
          'answers': ['500 million miles', '1 billion miles', '1.8 billion miles'],
          'correct': 2 //1.8 billion miles
        },
        {
          'question': '2. How long does sunlight take to reach Uranus?',
          'answers': ['4 hours', '2 hours and 40 minutes', '1 hour and 45 minutes'],
          'correct': 1 //2 hours and 40 minutes
        },
        {
          'question': '3. Why is Uranus colder than Neptune?',
          'answers': ['It is smaller', 'It has very little internal heat', 'It has thicker clouds'],
          'correct': 1 //It has very little internal heat
        },
        {
          'question': '4. What is Uranus’ type of rotation called?',
          'answers': ['Retrograde rotation', 'Forward rotation', 'Tilted rotation'],
          'correct': 0 //Retrograde rotation
        },
        {
          'question': '5. What makes Uranus unique among planets?',
          'answers': ['It has no moons', 'It rotates on its side', 'It has no atmosphere'],
          'correct': 1 //It rotates on its side
        },
        {
          'question': '6. Which spacecraft visited Uranus?',
          'answers': ['Cassini', 'Juno', 'Voyager 2'],
          'correct': 2  //Voyager 2
        },
        {
          'question': '7. When did Voyager 2 fly past Uranus?',
          'answers': ['1977', '1986', '2001'],
          'correct': 1 //1986
        },
        {
          'question': '8. What is Uranus mostly made of?',
          'answers': ['Fire and lava', 'Rock and metal', 'Icy materials like water and ammonia'],
          'correct': 2 //Icy materials like water and ammonia
        },
        {
          'question': '9. Why does Uranus receive less sunlight?',
          'answers': ['It spins slowly', 'It is very far from the Sun', 'It has thick rings'],
          'correct': 1 //It is very far from the Sun
        },
        {
          'question': '10. What makes Uranus different from Earth in temperature?',
          'answers': ['It is hotter', 'It has the same temperature', 'It is extremely colder'],
          'correct': 2
        }
      ]
    }
  },

  'neptune_quiz': {
    'planet': 'neptune',
    'levels': {
      'basic': [
        {
          'question': '1. Which planet is the farthest from the Sun?',
          'answers': ['Saturn', 'Neptune', 'Uranus'],
          'correct': 1 //Neptune
        },
        {
          'question': '2. How long does it take Neptune to orbit the Sun once?',
          'answers': ['84 years', '165 Earth years', '200 years'],
          'correct': 1 //165 Earth years
        },
        {
          'question': '3. Neptune was the first planet discovered using _______.',
          'answers': ['A telescope', 'Mathematical calculations', 'A space probe'],
          'correct': 1 //Mathematical calculations
        },
        {
          'question': '4. What is Neptune known for in terms of wind?',
          'answers': ['Calm winds', 'Strong storms', 'Supersonic winds'],
          'correct': 2 //Supersonic winds
        },
        {
          'question': '5. Neptune’s winds move faster than what?',
          'answers': ['A car', 'The speed of sound', 'A bird'],
          'correct': 1 //The speed of sound
        },
        {
          'question': '6. What type of planet is Neptune?',
          'answers': ['Rocky planet', 'Ice giant', 'Gas giant'],
          'correct': 1 //Ice giant
        },
        {
          'question': '7. Which planet in the solar system is also considered as an ice giant like Neptune?',
          'answers': ['Mars', 'Venus', 'Uranus'],
          'correct': 2 //Uranus
        },
        {
          'question': '8. Which Roman god is Neptune named after?',
          'answers': ['The god of war', 'The god of the sea', 'The god of the sky'],
          'correct': 1 //The god of the sea
        },
        {
          'question': '9. If Earth were the size of a nickel, Neptune would be ________.',
          'answers': ['A basketball', 'A baseball', 'A golf ball'],
          'correct': 1 //A baseball
        },
        {
          'question': '10. Neptune is slightly smaller in diameter than ________.',
          'answers': ['Mars', 'Saturn', 'Uranus'],
          'correct': 2 //Uranus
        }
      ],
      'intermediate': [
        {
          'question': '1. Neptune’s atmosphere is mostly made of __________.',
          'answers': ['Hydrogen and helium', 'Methane and carbon dioxide', 'Nitrogen and oxygen'],
          'correct': 0 //Hydrogen and helium
        },
        {
          'question': '2. What small gas in Neptune’s atmosphere gives it its vivid blue color?',
          'answers': ['Sulfur dioxide', 'Helium', 'Methane'],
          'correct': 2 //Methane
        },
        {
          'question': '3. Neptune appears more vividly blue than Uranus because of _________.',
          'answers': ['its closeness to the Sun', 'An unknown atmospheric component', 'its thicker ice layer'],
          'correct': 1 //An unknown atmospheric component
        },
        {
          'question': '4. How many moons does Neptune have?',
          'answers': ['At least 10', 'At least 16', 'At least 28'],
          'correct': 1 //At least 16
        },
        {
          'question': '5. What is the name of Neptune’s largest moon?',
          'answers': ['Triton', 'Titan', 'Deimos'],
          'correct': 0 //Triton
        },
        {
          'question': '6. Triton is unique because it orbits Neptune…',
          'answers': ['Backward', 'Very Slowly', 'Sideways'],
          'correct': 0 //Backward
        },
        {
          'question': '7. Neptune’s ring arcs are made of __________.',
          'answers': ['Chunks of ice', 'Clumps of dust and debris', 'Rocky surfaces'],
          'correct': 1 //Clumps of dust and debris
        },
        {
          'question': '8. How many major rings does Neptune have?',
          'answers': ['5', '10', '0'],
          'correct': 0 //5
        },
        {
          'question': '9. Sunlight takes about _____ to travel from the Sun to Neptune.',
          'answers': ['3 hours', '2 hours', '4 hours'],
          'correct': 2 //4 hours
        },
        {
          'question': '10. If it were noon on Neptune, the sunlight would appear as…',
          'answers': ['Bright daylight', 'Dark night', 'Dim twilight'],
          'correct': 2 //Dim twilight
        }
      ],
      'advanced': [
        {
          'question': '1. Which planet is known as the “windiest world” in the solar system?',
          'answers': ['Jupiter', 'Saturn', 'Neptune'],
          'correct': 2 //Neptune
        },
        {
          'question': '2. How fast can Neptune’s winds reach?',
          'answers': ['500 km/h', '1,200 km/h', 'Over 2,000 km/h'],
          'correct': 2 //Over 2,000 km/h
        },
        {
          'question': '3. What was the name of the large storm discovered by Voyager 2?',
          'answers': ['Great Red Spot', 'Great Dark Spot', 'Giant Storm Eye'],
          'correct': 1 //Great Dark Spot
        },
        {
          'question': '4. Why do Neptune’s storms change over time?',
          'answers': ['Weak gravity', 'Unstable atmosphere', 'Lack of clouds'],
          'correct': 1 //Unstable atmosphere
        },
        {
          'question': '5. How long does one season on Neptune last?',
          'answers': ['More than 20 years', 'More than 30 years', 'More than 40 years'],
          'correct': 2 //More than 40 years
        },
        {
          'question': '6. How much more energy does Neptune radiate than it receives from the Sun?',
          'answers': ['1.2 times', '2.6 times', '5.0 times'],
          'correct': 1 //2.6 times
        },
        {
          'question': '7. What process is theorized to release heat as carbon crystallizes and sinks toward Neptune\'s core?',
          'answers': ['Nuclear fusion', 'Diamond rain', 'Methane combustion'],
          'correct': 1 //Diamond rain
        },
        {
          'question': '8. At what angle is Neptune’s magnetic field tilted relative to its rotation axis?',
          'answers': ['10 degrees', '23.5 degrees', '47 degrees'],
          'correct': 2 //47 degrees
        },
        {
          'question': '9. Where is Neptune’s magnetic field believed to be generated?',
          'answers': ['A “slushy” layer of water and ammonia', 'A solid iron-nickel core', 'The upper cloud deck'],
          'correct': 0 //A “slushy” layer of water and ammonia
        },
        {
          'question': '10. Why is Neptune called a “blueprint” for the rest of the galaxy?',
          'answers': ['Neptune-sized exoplanets are extremely common', 'It was the first planet ever formed', 'It contains all the elements found in the Sun'],
          'correct': 0 //Neptune-sized exoplanets are extremely common
        }
      ]
    }
  }
};