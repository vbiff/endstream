import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/auth/auth_cubit.dart';
import '../../../core/cubits/settings/settings_cubit.dart';
import 'settings_about_section.dart';
import 'settings_account_section.dart';
import 'settings_audio_section.dart';
import 'settings_game_section.dart';
import 'settings_notification_section.dart';
import 'settings_visual_section.dart';

/// Settings screen with sections for account, notifications, audio, visual, game, and about.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthCubitState>(
        listenWhen: (previous, current) => current is Unauthenticated,
        listener: (context, state) {
          if (state is Unauthenticated) {
            context.go('/login');
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              const _SettingsTopBar(),
              Expanded(
                child: BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, settings) {
                    final cubit = context.read<SettingsCubit>();
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SettingsAccountSection(),
                          SettingsNotificationSection(
                            pushNotifications: settings.pushNotifications,
                            turnReminders: settings.turnReminders,
                            onPushChanged: cubit.setPushNotifications,
                            onRemindersChanged: cubit.setTurnReminders,
                          ),
                          SettingsAudioSection(
                            musicVolume: settings.musicVolume,
                            sfxVolume: settings.sfxVolume,
                            onMusicChanged: cubit.setMusicVolume,
                            onSfxChanged: cubit.setSfxVolume,
                          ),
                          SettingsVisualSection(
                            reduceMotion: settings.reduceMotion,
                            treeDensity: settings.treeDensity,
                            onReduceMotionChanged: cubit.setReduceMotion,
                            onTreeDensityChanged: cubit.setTreeDensity,
                          ),
                          SettingsGameSection(
                            autoEndTurn: settings.autoEndTurn,
                            confirmEndTurn: settings.confirmEndTurn,
                            onAutoEndChanged: cubit.setAutoEndTurn,
                            onConfirmEndChanged: cubit.setConfirmEndTurn,
                          ),
                          const SettingsAboutSection(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTopBar extends StatelessWidget {
  const _SettingsTopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Semantics(
            button: true,
            label: 'Go back',
            child: GestureDetector(
              onTap: () => context.pop(),
              child: const Text(
                '<',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 18,
                  color: TreeColors.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'SETTINGS',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 2.0,
              color: TreeColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
