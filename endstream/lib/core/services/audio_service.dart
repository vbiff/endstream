import '../models/audio_types.dart';

export '../models/audio_types.dart';

/// Abstract interface for music and sound effect playback.
abstract class AudioService {
  /// Update music volume (0.0-1.0). Takes effect immediately.
  void updateMusicVolume(double volume);

  /// Update SFX volume (0.0-1.0). Applies to future SFX plays.
  void updateSfxVolume(double volume);

  /// Start playing a looping music track. Stops any current music first.
  Future<void> playMusic(MusicTrack track);

  /// Stop the currently playing music track.
  Future<void> stopMusic();

  /// Pause the current music track (can be resumed).
  Future<void> pauseMusic();

  /// Resume a paused music track.
  Future<void> resumeMusic();

  /// Play a one-shot sound effect. Fire-and-forget.
  Future<void> playSfx(SfxType type);

  /// Release all audio resources.
  void dispose();
}
