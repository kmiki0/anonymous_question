import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SoundService {
  Soundpool? pool;
  Map<String, int> soundIds = {}; // サウンドファイル名と対応するsoundIdのマップ

  SoundService() {
    init();
  }

  Future init() async {
    pool = Soundpool.fromOptions();
    soundIds['ON'] = await loadSound('SE_btn_on.mp3');
    soundIds['OFF'] = await loadSound('SE_btn_off.mp3');
    // 他のSEも同様にロード
  }

  Future<int> loadSound(String assetPath) async {
    ByteData soundData = await rootBundle.load('assets/se/$assetPath');
    return await pool!.load(soundData);
  }

  playSound(String soundName) {
    pool!.play(soundIds[soundName]!);
  }
}