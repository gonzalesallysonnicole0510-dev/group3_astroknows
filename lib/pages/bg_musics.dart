import 'package:audioplayers/audioplayers.dart';

class BgMusics {
  BgMusics._();
  static final BgMusics instance = BgMusics._();

  final AudioPlayer _player = AudioPlayer();

  int _volumeLevel = 5;

  Future<void> play(String assetName) async {
    await _player.stop();
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setVolume(_volumeLevel / 10.0);
    await _player.play(AssetSource(assetName));
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> setVolume(int level) async {
    _volumeLevel = level;
    await _player.setVolume(level / 10.0);
  }
}
