import 'package:dictaphone_app/utils/record.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerController extends ChangeNotifier {
  MyRecord? settedRecord;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  Future<Duration?> setRecord({required MyRecord record}) async {
    final duration = await _audioPlayer.setFilePath(record.path);
    settedRecord = record;
    return duration;
  }

  Future<void> play() async {
    await _audioPlayer.play();
    notifyListeners();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    notifyListeners();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    notifyListeners();
  }

  void changePlayState() {
    isPlaying = !isPlaying;
    notifyListeners();
  }

  // Stream<PlayerState> get playerState => _audioPlayer.playerStateStream;

  @override
  Future<void> dispose() async {
    super.dispose();
    await _audioPlayer.dispose();
  }
}

enum State {
  stopped,
  paused,
  playing,
}
