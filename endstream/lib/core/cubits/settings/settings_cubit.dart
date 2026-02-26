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

  void _loadSettings() {
    emit(SettingsState(
      pushNotifications: _prefs.getBool(_keyPushNotifications) ?? true,
      turnReminders: _prefs.getBool(_keyTurnReminders) ?? true,
      musicVolume: _prefs.getDouble(_keyMusicVolume) ?? 0.5,
      sfxVolume: _prefs.getDouble(_keySfxVolume) ?? 0.7,
      reduceMotion: _prefs.getBool(_keyReduceMotion) ?? false,
      treeDensity: _prefs.getDouble(_keyTreeDensity) ?? 0.7,
      autoEndTurn: _prefs.getBool(_keyAutoEndTurn) ?? false,
      confirmEndTurn: _prefs.getBool(_keyConfirmEndTurn) ?? true,
    ));
  }

  Future<void> setPushNotifications(bool value) async {
    await _prefs.setBool(_keyPushNotifications, value);
    emit(state.copyWith(pushNotifications: value));
  }

  Future<void> setTurnReminders(bool value) async {
    await _prefs.setBool(_keyTurnReminders, value);
    emit(state.copyWith(turnReminders: value));
  }

  Future<void> setMusicVolume(double value) async {
    await _prefs.setDouble(_keyMusicVolume, value);
    emit(state.copyWith(musicVolume: value));
  }

  Future<void> setSfxVolume(double value) async {
    await _prefs.setDouble(_keySfxVolume, value);
    emit(state.copyWith(sfxVolume: value));
  }

  Future<void> setReduceMotion(bool value) async {
    await _prefs.setBool(_keyReduceMotion, value);
    emit(state.copyWith(reduceMotion: value));
  }

  Future<void> setTreeDensity(double value) async {
    await _prefs.setDouble(_keyTreeDensity, value);
    emit(state.copyWith(treeDensity: value));
  }

  Future<void> setAutoEndTurn(bool value) async {
    await _prefs.setBool(_keyAutoEndTurn, value);
    emit(state.copyWith(autoEndTurn: value));
  }

  Future<void> setConfirmEndTurn(bool value) async {
    await _prefs.setBool(_keyConfirmEndTurn, value);
    emit(state.copyWith(confirmEndTurn: value));
  }
}
