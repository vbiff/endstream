import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';

import '../audio_service.dart';

class AudioPlayerAudioService implements AudioService {
  AudioPlayerAudioService();

  final AudioPlayer _musicPlayer = AudioPlayer();
  double _musicVolume = 0.5;
  double _sfxVolume = 0.7;
  MusicTrack? _currentTrack;

  static const _sfxPaths = <SfxType, String>{
    SfxType.buttonTap: 'audio/sfx/button_tap.wav',
    SfxType.cardPlay: 'audio/sfx/card_play.wav',
    SfxType.cardDraw: 'audio/sfx/card_draw.wav',
    SfxType.attackHit: 'audio/sfx/attack_hit.wav',
    SfxType.operatorEliminated: 'audio/sfx/operator_eliminated.wav',
    SfxType.turnStart: 'audio/sfx/turn_start.wav',
    SfxType.turnEnd: 'audio/sfx/turn_end.wav',
    SfxType.abilityActivate: 'audio/sfx/ability_activate.wav',
    SfxType.victory: 'audio/sfx/victory.wav',
    SfxType.defeat: 'audio/sfx/defeat.wav',
    SfxType.matchFound: 'audio/sfx/match_found.wav',
    SfxType.error: 'audio/sfx/error.wav',
  };

  static const _musicPaths = <MusicTrack, String>{
    MusicTrack.menu: 'audio/music/menu.mp3',
    MusicTrack.battle: 'audio/music/battle.mp3',
    MusicTrack.ambient: 'audio/music/ambient.mp3',
  };

  @override
  void updateMusicVolume(double volume) {
    _musicVolume = volume.clamp(0.0, 1.0);
    _musicPlayer.setVolume(_musicVolume);
  }

  @override
  void updateSfxVolume(double volume) {
    _sfxVolume = volume.clamp(0.0, 1.0);
  }

  @override
  Future<void> playMusic(MusicTrack track) async {
    if (_currentTrack == track) return;
    _currentTrack = track;

    final path = _musicPaths[track];
    if (path == null) return;

    try {
      await _musicPlayer.stop();
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      await _musicPlayer.setVolume(_musicVolume);
      await _musicPlayer.play(AssetSource(path));
    } catch (e) {
      log('AudioService: Failed to play music $track: $e', name: 'Audio');
    }
  }

  @override
  Future<void> stopMusic() async {
    _currentTrack = null;
    try {
      await _musicPlayer.stop();
    } catch (e) {
      log('AudioService: Failed to stop music: $e', name: 'Audio');
    }
  }

  @override
  Future<void> pauseMusic() async {
    try {
      await _musicPlayer.pause();
    } catch (e) {
      log('AudioService: Failed to pause music: $e', name: 'Audio');
    }
  }

  @override
  Future<void> resumeMusic() async {
    try {
      await _musicPlayer.resume();
    } catch (e) {
      log('AudioService: Failed to resume music: $e', name: 'Audio');
    }
  }

  @override
  Future<void> playSfx(SfxType type) async {
    if (_sfxVolume <= 0) return;

    final path = _sfxPaths[type];
    if (path == null) return;

    try {
      final player = AudioPlayer();
      await player.setVolume(_sfxVolume);
      await player.play(AssetSource(path));
      player.onPlayerComplete.listen((_) => player.dispose());
    } catch (e) {
      log('AudioService: Failed to play SFX $type: $e', name: 'Audio');
    }
  }

  @override
  void dispose() {
    _musicPlayer.dispose();
  }
}
