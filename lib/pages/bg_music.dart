import 'package:audioplayers/audioplayers.dart';

/// Global singleton audio manager.
/// One player = only one track plays at a time, guaranteed.
class BgMusics {
  BgMusics._();
  static final BgMusics instance = BgMusics._();

  final AudioPlayer _player = AudioPlayer();

  // Stores the current volume level (0–10) so it persists across screens
  int _volumeLevel = 5;

  Future<void> play(String assetName) async {
    await _player.stop();
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setVolume(_volumeLevel / 10.0); // always apply saved volume
    await _player.play(AssetSource(assetName));
  }

  Future<void> stop() async {
    await _player.stop();
  }

  /// Call this whenever the Music Volume slider changes.
  /// level is 0–10, converted to 0.0–1.0
  Future<void> setVolume(int level) async {
    _volumeLevel = level;
    await _player.setVolume(level / 10.0);
  }
}
