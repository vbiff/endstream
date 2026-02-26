part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.pushNotifications = true,
    this.turnReminders = true,
    this.musicVolume = 0.5,
    this.sfxVolume = 0.7,
    this.reduceMotion = false,
    this.treeDensity = 0.7,
    this.autoEndTurn = false,
    this.confirmEndTurn = true,
    this.onboardingCompleted = false,
    this.tutorialCompleted = false,
  });

  final bool pushNotifications;
  final bool turnReminders;
  final double musicVolume;
  final double sfxVolume;
  final bool reduceMotion;
  final double treeDensity;
  final bool autoEndTurn;
  final bool confirmEndTurn;
  final bool onboardingCompleted;
  final bool tutorialCompleted;

  SettingsState copyWith({
    bool? pushNotifications,
    bool? turnReminders,
    double? musicVolume,
    double? sfxVolume,
    bool? reduceMotion,
    double? treeDensity,
    bool? autoEndTurn,
    bool? confirmEndTurn,
    bool? onboardingCompleted,
    bool? tutorialCompleted,
  }) =>
      SettingsState(
        pushNotifications: pushNotifications ?? this.pushNotifications,
        turnReminders: turnReminders ?? this.turnReminders,
        musicVolume: musicVolume ?? this.musicVolume,
        sfxVolume: sfxVolume ?? this.sfxVolume,
        reduceMotion: reduceMotion ?? this.reduceMotion,
        treeDensity: treeDensity ?? this.treeDensity,
        autoEndTurn: autoEndTurn ?? this.autoEndTurn,
        confirmEndTurn: confirmEndTurn ?? this.confirmEndTurn,
        onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
        tutorialCompleted: tutorialCompleted ?? this.tutorialCompleted,
      );

  @override
  List<Object?> get props => [
        pushNotifications,
        turnReminders,
        musicVolume,
        sfxVolume,
        reduceMotion,
        treeDensity,
        autoEndTurn,
        confirmEndTurn,
        onboardingCompleted,
        tutorialCompleted,
      ];
}
