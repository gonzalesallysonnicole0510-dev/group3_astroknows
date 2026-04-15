import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';


const Map<String, Map<String, Map<int, String>>> _quizNarrationMap = {

  'Sun': {
    'basic': {
      0: 'assets/narration/sun_basic_q1.mp3',
      1: 'assets/narration/sun_basic_q2.mp3',
      2: 'assets/narration/sun_basic_q3.mp3',
      3: 'assets/narration/sun_basic_q4.mp3',
      4: 'assets/narration/sun_basic_q5.mp3',
      5: 'assets/narration/sun_basic_q6.mp3',
      6: 'assets/narration/sun_basic_q7.mp3',
      7: 'assets/narration/sun_basic_q8.mp3',
      8: 'assets/narration/sun_basic_q9.mp3',
      9: 'assets/narration/sun_basic_q10.mp3',
    },
    'intermediate': {
      0: 'assets/narration/sun_intermediate_q1.mp3',
      1: 'assets/narration/sun_intermediate_q2.mp3',
      2: 'assets/narration/sun_intermediate_q3.mp3',
      3: 'assets/narration/sun_intermediate_q4.mp3',
      4: 'assets/narration/sun_intermediate_q5.mp3',
      5: 'assets/narration/sun_intermediate_q6.mp3',
      6: 'assets/narration/sun_intermediate_q7.mp3',
      7: 'assets/narration/sun_intermediate_q8.mp3',
      8: 'assets/narration/sun_intermediate_q9.mp3',
      9: 'assets/narration/sun_intermediate_q10.mp3',
    },
    'advanced': {
      0: 'assets/narration/sun_advanced_q1.mp3',
      1: 'assets/narration/sun_advanced_q2.mp3',
      2: 'assets/narration/sun_advanced_q3.mp3',
      3: 'assets/narration/sun_advanced_q4.mp3',
      4: 'assets/narration/sun_advanced_q5.mp3',
      5: 'assets/narration/sun_advanced_q6.mp3',
      6: 'assets/narration/sun_advanced_q7.mp3',
      7: 'assets/narration/sun_advanced_q8.mp3',
      8: 'assets/narration/sun_advanced_q9.mp3',
      9: 'assets/narration/sun_advanced_q10.mp3',
    },
  },


  'Mercury': {
    'basic': {
      0: 'assets/narration/mercury_basic_q1.mp3',
      1: 'assets/narration/mercury_basic_q2.mp3',
      2: 'assets/narration/mercury_basic_q3.mp3',
      3: 'assets/narration/mercury_basic_q4.mp3',
      4: 'assets/narration/mercury_basic_q5.mp3',
      5: 'assets/narration/mercury_basic_q6.mp3',
      6: 'assets/narration/mercury_basic_q7.mp3',
      7: 'assets/narration/mercury_basic_q8.mp3',
      8: 'assets/narration/mercury_basic_q9.mp3',
      9: 'assets/narration/mercury_basic_q10.mp3',
    },
    'intermediate': {
      0: 'assets/narration/mercury_intermediate_q1.mp3',
      1: 'assets/narration/mercury_intermediate_q2.mp3',
      2: 'assets/narration/mercury_intermediate_q3.mp3',
      3: 'assets/narration/mercury_intermediate_q4.mp3',
      4: 'assets/narration/mercury_intermediate_q5.mp3',
      5: 'assets/narration/mercury_intermediate_q6.mp3',
      6: 'assets/narration/mercury_intermediate_q7.mp3',
      7: 'assets/narration/mercury_intermediate_q8.mp3',
      8: 'assets/narration/mercury_intermediate_q9.mp3',
      9: 'assets/narration/mercury_intermediate_q10.mp3',
    },
    'advanced': {
      0: 'assets/narration/mercury_advanced_q1.mp3',
      1: 'assets/narration/mercury_advanced_q2.mp3',
      2: 'assets/narration/mercury_advanced_q3.mp3',
      3: 'assets/narration/mercury_advanced_q4.mp3',
      4: 'assets/narration/mercury_advanced_q5.mp3',
      5: 'assets/narration/mercury_advanced_q6.mp3',
      6: 'assets/narration/mercury_advanced_q7.mp3',
      7: 'assets/narration/mercury_advanced_q8.mp3',
      8: 'assets/narration/mercury_advanced_q9.mp3',
      9: 'assets/narration/mercury_advanced_q10.mp3',
    },
  },


  'Venus': {
    'basic': {
      0: 'assets/narration/venus_basic_q1.mp3',
      1: 'assets/narration/venus_basic_q2.mp3',
      2: 'assets/narration/venus_basic_q3.mp3',
      3: 'assets/narration/venus_basic_q4.mp3',
      4: 'assets/narration/venus_basic_q5.mp3',
      5: 'assets/narration/venus_basic_q6.mp3',
      6: 'assets/narration/venus_basic_q7.mp3',
      7: 'assets/narration/venus_basic_q8.mp3',
      8: 'assets/narration/venus_basic_q9.mp3',
      9: 'assets/narration/venus_basic_q10.mp3',
    },
    'intermediate': {
      0: 'assets/narration/venus_intermediate_q1.mp3',
      1: 'assets/narration/venus_intermediate_q2.mp3',
      2: 'assets/narration/venus_intermediate_q3.mp3',
      3: 'assets/narration/venus_intermediate_q4.mp3',
      4: 'assets/narration/venus_intermediate_q5.mp3',
      5: 'assets/narration/venus_intermediate_q6.mp3',
      6: 'assets/narration/venus_intermediate_q7.mp3',
      7: 'assets/narration/venus_intermediate_q8.mp3',
      8: 'assets/narration/venus_intermediate_q9.mp3',
      9: 'assets/narration/venus_intermediate_q10.mp3',
    },
    'advanced': {
      0: 'assets/narration/venus_advanced_q1.mp3',
      1: 'assets/narration/venus_advanced_q2.mp3',
      2: 'assets/narration/venus_advanced_q3.mp3',
      3: 'assets/narration/venus_advanced_q4.mp3',
      4: 'assets/narration/venus_advanced_q5.mp3',
      5: 'assets/narration/venus_advanced_q6.mp3',
      6: 'assets/narration/venus_advanced_q7.mp3',
      7: 'assets/narration/venus_advanced_q8.mp3',
      8: 'assets/narration/venus_advanced_q9.mp3',
      9: 'assets/narration/venus_advanced_q10.mp3',
    },
  },


  'Earth': {
    'basic': {
      0: 'assets/narration/earth_basic_q1.mp3',
      1: 'assets/narration/earth_basic_q2.mp3',
      2: 'assets/narration/earth_basic_q3.mp3',
      3: 'assets/narration/earth_basic_q4.mp3',
      4: 'assets/narration/earth_basic_q5.mp3',
      5: 'assets/narration/earth_basic_q6.mp3',
      6: 'assets/narration/earth_basic_q7.mp3',
      7: 'assets/narration/earth_basic_q8.mp3',
      8: 'assets/narration/earth_basic_q9.mp3',
      9: 'assets/narration/earth_basic_q10.mp3',
    },
    'intermediate': {
      0: 'assets/narration/earth_intermediate_q1.mp3',
      1: 'assets/narration/earth_intermediate_q2.mp3',
      2: 'assets/narration/earth_intermediate_q3.mp3',
      3: 'assets/narration/earth_intermediate_q4.mp3',
      4: 'assets/narration/earth_intermediate_q5.mp3',
      5: 'assets/narration/earth_intermediate_q6.mp3',
      6: 'assets/narration/earth_intermediate_q7.mp3',
      7: 'assets/narration/earth_intermediate_q8.mp3',
      8: 'assets/narration/earth_intermediate_q9.mp3',
      9: 'assets/narration/earth_intermediate_q10.mp3',
    },
    'advanced': {
      0: 'assets/narration/earth_advanced_q1.mp3',
      1: 'assets/narration/earth_advanced_q2.mp3',
      2: 'assets/narration/earth_advanced_q3.mp3',
      3: 'assets/narration/earth_advanced_q4.mp3',
      4: 'assets/narration/earth_advanced_q5.mp3',
      5: 'assets/narration/earth_advanced_q6.mp3',
      6: 'assets/narration/earth_advanced_q7.mp3',
      7: 'assets/narration/earth_advanced_q8.mp3',
      8: 'assets/narration/earth_advanced_q9.mp3',
      9: 'assets/narration/earth_advanced_q10.mp3',
    },
  },


  'Mars': {
    'basic': {
      0: 'assets/narration/mars_basic_q1.mp3',
      1: 'assets/narration/mars_basic_q2.mp3',
      2: 'assets/narration/mars_basic_q3.mp3',
      3: 'assets/narration/mars_basic_q4.mp3',
      4: 'assets/narration/mars_basic_q5.mp3',
      5: 'assets/narration/mars_basic_q6.mp3',
      6: 'assets/narration/mars_basic_q7.mp3',
      7: 'assets/narration/mars_basic_q8.mp3',
      8: 'assets/narration/mars_basic_q9.mp3',
      9: 'assets/narration/mars_basic_q10.mp3',
    },
    'intermediate': {
      0: 'assets/narration/mars_intermediate_q1.mp3',
      1: 'assets/narration/mars_intermediate_q2.mp3',
      2: 'assets/narration/mars_intermediate_q3.mp3',
      3: 'assets/narration/mars_intermediate_q4.mp3',
      4: 'assets/narration/mars_intermediate_q5.mp3',
      5: 'assets/narration/mars_intermediate_q6.mp3',
      6: 'assets/narration/mars_intermediate_q7.mp3',
      7: 'assets/narration/mars_intermediate_q8.mp3',
      8: 'assets/narration/mars_intermediate_q9.mp3',
      9: 'assets/narration/mars_intermediate_q10.mp3',
    },
    'advanced': {
      0: 'assets/narration/mars_advanced_q1.mp3',
      1: 'assets/narration/mars_advanced_q2.mp3',
      2: 'assets/narration/mars_advanced_q3.mp3',
      3: 'assets/narration/mars_advanced_q4.mp3',
      4: 'assets/narration/mars_advanced_q5.mp3',
      5: 'assets/narration/mars_advanced_q6.mp3',
      6: 'assets/narration/mars_advanced_q7.mp3',
      7: 'assets/narration/mars_advanced_q8.mp3',
      8: 'assets/narration/mars_advanced_q9.mp3',
      9: 'assets/narration/mars_advanced_q10.mp3',
    },
  },


  'Jupiter': {
    'basic': {
      0: 'assets/narration/jupiter_basic_q1.mp3',
      1: 'assets/narration/jupiter_basic_q2.mp3',
      2: 'assets/narration/jupiter_basic_q3.mp3',
      3: 'assets/narration/jupiter_basic_q4.mp3',
      4: 'assets/narration/jupiter_basic_q5.mp3',
      5: 'assets/narration/jupiter_basic_q6.mp3',
      6: 'assets/narration/jupiter_basic_q7.mp3',
      7: 'assets/narration/jupiter_basic_q8.mp3',
      8: 'assets/narration/jupiter_basic_q9.mp3',
      9: 'assets/narration/jupiter_basic_q10.mp3',
    },
    'intermediate': {
      0: 'assets/narration/jupiter_intermediate_q1.mp3',
      1: 'assets/narration/jupiter_intermediate_q2.mp3',
      2: 'assets/narration/jupiter_intermediate_q3.mp3',
      3: 'assets/narration/jupiter_intermediate_q4.mp3',
      4: 'assets/narration/jupiter_intermediate_q5.mp3',
      5: 'assets/narration/jupiter_intermediate_q6.mp3',
      6: 'assets/narration/jupiter_intermediate_q7.mp3',
      7: 'assets/narration/jupiter_intermediate_q8.mp3',
      8: 'assets/narration/jupiter_intermediate_q9.mp3',
      9: 'assets/narration/jupiter_intermediate_q10.mp3',
    },
    'advanced': {
      0: 'assets/narration/jupiter_advanced_q1.mp3',
      1: 'assets/narration/jupiter_advanced_q2.mp3',
      2: 'assets/narration/jupiter_advanced_q3.mp3',
      3: 'assets/narration/jupiter_advanced_q4.mp3',
      4: 'assets/narration/jupiter_advanced_q5.mp3',
      5: 'assets/narration/jupiter_advanced_q6.mp3',
      6: 'assets/narration/jupiter_advanced_q7.mp3',
      7: 'assets/narration/jupiter_advanced_q8.mp3',
      8: 'assets/narration/jupiter_advanced_q9.mp3',
      9: 'assets/narration/jupiter_advanced_q10.mp3',
    },
  },


  'Saturn': {
    'basic': {
      0: 'assets/narration/saturn_basic_q1.mp3',
      1: 'assets/narration/saturn_basic_q2.mp3',
      2: 'assets/narration/saturn_basic_q3.mp3',
      3: 'assets/narration/saturn_basic_q4.mp3',
      4: 'assets/narration/saturn_basic_q5.mp3',
      5: 'assets/narration/saturn_basic_q6.mp3',
      6: 'assets/narration/saturn_basic_q7.mp3',
      7: 'assets/narration/saturn_basic_q8.mp3',
      8: 'assets/narration/saturn_basic_q9.mp3',
      9: 'assets/narration/saturn_basic_q10.mp3',
    },
    'intermediate': {
      0: 'assets/narration/saturn_intermediate_q1.mp3',
      1: 'assets/narration/saturn_intermediate_q2.mp3',
      2: 'assets/narration/saturn_intermediate_q3.mp3',
      3: 'assets/narration/saturn_intermediate_q4.mp3',
      4: 'assets/narration/saturn_intermediate_q5.mp3',
      5: 'assets/narration/saturn_intermediate_q6.mp3',
      6: 'assets/narration/saturn_intermediate_q7.mp3',
      7: 'assets/narration/saturn_intermediate_q8.mp3',
      8: 'assets/narration/saturn_intermediate_q9.mp3',
      9: 'assets/narration/saturn_intermediate_q10.mp3',
    },
    'advanced': {
      0: 'assets/narration/saturn_advanced_q1.mp3',
      1: 'assets/narration/saturn_advanced_q2.mp3',
      2: 'assets/narration/saturn_advanced_q3.mp3',
      3: 'assets/narration/saturn_advanced_q4.mp3',
      4: 'assets/narration/saturn_advanced_q5.mp3',
      5: 'assets/narration/saturn_advanced_q6.mp3',
      6: 'assets/narration/saturn_advanced_q7.mp3',
      7: 'assets/narration/saturn_advanced_q8.mp3',
      8: 'assets/narration/saturn_advanced_q9.mp3',
      9: 'assets/narration/saturn_advanced_q10.mp3',
    },
  },


  'Uranus': {
    'basic': {
      0: 'assets/narration/uranus_basic_q1.mp3',
      1: 'assets/narration/uranus_basic_q2.mp3',
      2: 'assets/narration/uranus_basic_q3.mp3',
      3: 'assets/narration/uranus_basic_q4.mp3',
      4: 'assets/narration/uranus_basic_q5.mp3',
      5: 'assets/narration/uranus_basic_q6.mp3',
      6: 'assets/narration/uranus_basic_q7.mp3',
      7: 'assets/narration/uranus_basic_q8.mp3',
      8: 'assets/narration/uranus_basic_q9.mp3',
      9: 'assets/narration/uranus_basic_q10.mp3',
    },
    'intermediate': {
      0: 'assets/narration/uranus_intermediate_q1.mp3',
      1: 'assets/narration/uranus_intermediate_q2.mp3',
      2: 'assets/narration/uranus_intermediate_q3.mp3',
      3: 'assets/narration/uranus_intermediate_q4.mp3',
      4: 'assets/narration/uranus_intermediate_q5.mp3',
      5: 'assets/narration/uranus_intermediate_q6.mp3',
      6: 'assets/narration/uranus_intermediate_q7.mp3',
      7: 'assets/narration/uranus_intermediate_q8.mp3',
      8: 'assets/narration/uranus_intermediate_q9.mp3',
      9: 'assets/narration/uranus_intermediate_q10.mp3',
    },
    'advanced': {
      0: 'assets/narration/uranus_advanced_q1.mp3',
      1: 'assets/narration/uranus_advanced_q2.mp3',
      2: 'assets/narration/uranus_advanced_q3.mp3',
      3: 'assets/narration/uranus_advanced_q4.mp3',
      4: 'assets/narration/uranus_advanced_q5.mp3',
      5: 'assets/narration/uranus_advanced_q6.mp3',
      6: 'assets/narration/uranus_advanced_q7.mp3',
      7: 'assets/narration/uranus_advanced_q8.mp3',
      8: 'assets/narration/uranus_advanced_q9.mp3',
      9: 'assets/narration/uranus_advanced_q10.mp3',
    },
  },


  'Neptune': {
    'basic': {
      0: 'assets/narration/neptune_basic_q1.mp3',
      1: 'assets/narration/neptune_basic_q2.mp3',
      2: 'assets/narration/neptune_basic_q3.mp3',
      3: 'assets/narration/neptune_basic_q4.mp3',
      4: 'assets/narration/neptune_basic_q5.mp3',
      5: 'assets/narration/neptune_basic_q6.mp3',
      6: 'assets/narration/neptune_basic_q7.mp3',
      7: 'assets/narration/neptune_basic_q8.mp3',
      8: 'assets/narration/neptune_basic_q9.mp3',
      9: 'assets/narration/neptune_basic_q10.mp3',
    },
    'intermediate': {
      0: 'assets/narration/neptune_intermediate_q1.mp3',
      1: 'assets/narration/neptune_intermediate_q2.mp3',
      2: 'assets/narration/neptune_intermediate_q3.mp3',
      3: 'assets/narration/neptune_intermediate_q4.mp3',
      4: 'assets/narration/neptune_intermediate_q5.mp3',
      5: 'assets/narration/neptune_intermediate_q6.mp3',
      6: 'assets/narration/neptune_intermediate_q7.mp3',
      7: 'assets/narration/neptune_intermediate_q8.mp3',
      8: 'assets/narration/neptune_intermediate_q9.mp3',
      9: 'assets/narration/neptune_intermediate_q10.mp3',
    },
    'advanced': {
      0: 'assets/narration/neptune_advanced_q1.mp3',
      1: 'assets/narration/neptune_advanced_q2.mp3',
      2: 'assets/narration/neptune_advanced_q3.mp3',
      3: 'assets/narration/neptune_advanced_q4.mp3',
      4: 'assets/narration/neptune_advanced_q5.mp3',
      5: 'assets/narration/neptune_advanced_q6.mp3',
      6: 'assets/narration/neptune_advanced_q7.mp3',
      7: 'assets/narration/neptune_advanced_q8.mp3',
      8: 'assets/narration/neptune_advanced_q9.mp3',
      9: 'assets/narration/neptune_advanced_q10.mp3',
    },
  },
};


const Map<String, Map<int, String>> _infoNarrationMap = {
  'Sun':     { 0: 'assets/narration/-sun_basic.mp3',  
               1: 'assets/narration/-sun_intermediate.mp3',
               2: 'assets/narration/-sun_advanced.mp3'},

  'Mercury': { 0: 'assets/narration/-mercury_basic.mp3', 
               1: 'assets/narration/-mercury_intermediate.mp3',
               2: 'assets/narration/-mercury_advanced.mp3'},

  'Venus':   { 0: 'assets/narration/-venus_basic_info.mp3', 
               1: 'assets/narration/-venus_intermediate_info.mp3',
               2: 'assets/narration/-venus_advanced_info.mp3'},

  'Earth':   { 0: 'assets/narration/-earth_basic.mp3',  
               1: 'assets/narration/-earth_intermediate.mp3',
               2: 'assets/narration/-earth_advanced.mp3'},

 'Mars':    { 0: 'assets/narration/-mars_basic.mp3',
               1: 'assets/narration/-mars_intermediate.mp3',
               2: 'assets/narration/-mars_advanced.mp3'},

  'Jupiter': { 0: 'assets/narration/-jupiter_basic.mp3',
               1: 'assets/narration/-jupiter_intermediate.mp3',
               2: 'assets/narration/-jupiter_advanced.mp3'}, 
               
  'Saturn':  { 0: 'assets/narration/-saturn_basic.mp3',
               1: 'assets/narration/-saturn_intermediate.mp3',
               2: 'assets/narration/-saturn_advanced.mp3'},

  'Uranus':  { 0: 'assets/narration/-uranus_basic.mp3',
               1: 'assets/narration/-uranus_intermediate.mp3',
               2: 'assets/narration/-uranus_advanced.mp3'},

  'Neptune': { 0: 'assets/narration/-neptune_basic.mp3',
               1: 'assets/narration/-neptune_intermediate.mp3',
               2: 'assets/narration/-neptune_advanced.mp3'},
};



class NarrationManager {
  NarrationManager._();
  static final NarrationManager instance = NarrationManager._();

  final AudioPlayer _player = AudioPlayer();
  bool _enabled = false;
  double _volume = 0.5;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _enabled = prefs.getBool('narrationEnabled') ?? false;
    _volume = (prefs.getInt('narrationLevel') ?? 5) / 10.0;
    await _player.setVolume(_volume);
  }

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('narrationEnabled', value);
    if (!value) await _player.stop();
  }

  bool get isEnabled => _enabled;

  Future<void> setVolume(int level) async {
    _volume = level / 10.0;
    await _player.setVolume(_volume);
  }


  Future<void> playQuiz(String planet, String level, int questionIndex) async {
    if (!_enabled) return;

    final path = _quizNarrationMap[planet]?[level]?[questionIndex];
    if (path == null) return;

    await _player.stop();
    await _player.play(AssetSource(path.replaceFirst('assets/', '')));
  }


  Future<void> playPlanetInfo(String planet, int levelIndex) async {
    if (!_enabled) return;

    final path = _infoNarrationMap[planet]?[levelIndex];
    if (path == null) return;

    await _player.stop();
    await _player.play(AssetSource(path.replaceFirst('assets/', '')));
  }

  Future<void> stop() async {
    await _player.stop();
  }

  void dispose() {
    _player.dispose();
  }
}