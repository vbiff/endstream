import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._prefs) : super(const SettingsState()) {
    _loadSettings();
  }

  final SharedPreferences _prefs;

  static const _keyPushNotifications = 'push_notifications';
  static const _keyTurnReminders = 'turn_reminders';
  static const _keyMusicVolume = 'music_volume';
  static const _keySfxVolume = 'sfx_volume';
  static const _keyReduceMotion = 'reduce_motion';
  static const _keyTreeDensity = 'tree_density';
  static const _keyAutoEndTurn = 'auto_end_turn';
  static const _keyConfirmEndTurn = 'confirm_end_turn';
  static const _keyOnboardingCompleted = 'onboarding_completed';
  static const _keyTutorialCompleted = 'tutorial_completed';

  void _loadSettings() {
    try {
      emit(SettingsState(
        pushNotifications: _prefs.getBool(_keyPushNotifications) ?? true,
        turnReminders: _prefs.getBool(_keyTurnReminders) ?? true,
        musicVolume: _prefs.getDouble(_keyMusicVolume) ?? 0.5,
        sfxVolume: _prefs.getDouble(_keySfxVolume) ?? 0.7,
        reduceMotion: _prefs.getBool(_keyReduceMotion) ?? false,
        treeDensity: _prefs.getDouble(_keyTreeDensity) ?? 0.7,
        autoEndTurn: _prefs.getBool(_keyAutoEndTurn) ?? false,
        confirmEndTurn: _prefs.getBool(_keyConfirmEndTurn) ?? true,
        onboardingCompleted: _prefs.getBool(_keyOnboardingCompleted) ?? false,
        tutorialCompleted: _prefs.getBool(_keyTutorialCompleted) ?? false,
      ));
    } catch (_) {
      // Use defaults if preferences are corrupted
      emit(const SettingsState());
    }
  }

  Future<void> setPushNotifications(bool value) async {
    emit(state.copyWith(pushNotifications: value));
    await _prefs.setBool(_keyPushNotifications, value);
  }

  Future<void> setTurnReminders(bool value) async {
    emit(state.copyWith(turnReminders: value));
    await _prefs.setBool(_keyTurnReminders, value);
  }

  Future<void> setMusicVolume(double value) async {
    emit(state.copyWith(musicVolume: value));
    await _prefs.setDouble(_keyMusicVolume, value);
  }

  Future<void> setSfxVolume(double value) async {
    emit(state.copyWith(sfxVolume: value));
    await _prefs.setDouble(_keySfxVolume, value);
  }

  Future<void> setReduceMotion(bool value) async {
    emit(state.copyWith(reduceMotion: value));
    await _prefs.setBool(_keyReduceMotion, value);
  }

  Future<void> setTreeDensity(double value) async {
    emit(state.copyWith(treeDensity: value));
    await _prefs.setDouble(_keyTreeDensity, value);
  }

  Future<void> setAutoEndTurn(bool value) async {
    emit(state.copyWith(autoEndTurn: value));
    await _prefs.setBool(_keyAutoEndTurn, value);
  }

  Future<void> setConfirmEndTurn(bool value) async {
    emit(state.copyWith(confirmEndTurn: value));
    await _prefs.setBool(_keyConfirmEndTurn, value);
  }

  Future<void> completeOnboarding() async {
    emit(state.copyWith(onboardingCompleted: true));
    await _prefs.setBool(_keyOnboardingCompleted, true);
  }

  Future<void> completeTutorial() async {
    emit(state.copyWith(tutorialCompleted: true));
    await _prefs.setBool(_keyTutorialCompleted, true);
  }
}
