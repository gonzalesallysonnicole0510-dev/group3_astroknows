import 'package:audioplayers/audioplayers.dart';

class SfxManager {
  SfxManager._();
  static final SfxManager instance = SfxManager._();

  int _sfxLevel = 5;

  Future<void> setVolume(int level) async {
    _sfxLevel = level;
  }

  Future<void> play(String assetPath) async {
    try {
      final player = AudioPlayer(); // multiple sounds allowed
      await player.setVolume(_sfxLevel / 10.0);

      await player.play(
        AssetSource(assetPath.replaceFirst('assets/', '')),
      );
    } catch (e) {
      print("SFX ERROR: $e");
    }
  }

  final AudioPlayer _loopPlayer = AudioPlayer();  // for space travel sound

  Future<void> playLoop(String assetPath) async {
    await _loopPlayer.stop();
    await _loopPlayer.setReleaseMode(ReleaseMode.loop);
    await _loopPlayer.setVolume(_sfxLevel / 10.0);

    await _loopPlayer.play(
      AssetSource(assetPath.replaceFirst('assets/', '')),
    );
  }

  Future<void> stopLoop() async {
    await _loopPlayer.stop();
  }

  // All sound effects:
  void mainButton() => play('assets/mainButton_click.mp3');
  void secButton() => play('assets/secButton_click.mp3');
  void selection() => play('assets/selection_click.mp3');
  void pause() => play('assets/pauseButton_click.mp3');
  void backButton() => play('assets/backButton_click.mp3');
  void launch() => play('assets/countdown_launch.mp3');
  void travelSpace() => playLoop('assets/space_travel.mp3');
  void laser() => play('assets/laser_shoot.mp3');
  void correct() => play('assets/correct_answer.mp3');
  void wrong() => play('assets/wrong_answer.mp3');
  void accomplished() => play('assets/mission_accomplished.mp3');
  void claim() => play('assets/claim.mp3');
  void missionFailed() => play('assets/mission_failed.mp3');
}