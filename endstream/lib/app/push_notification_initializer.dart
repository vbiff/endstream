import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/cubits/auth/auth_cubit.dart';
import '../core/cubits/settings/settings_cubit.dart';
import '../core/services/push_service.dart';
import 'routes.dart';

/// Manages push notification lifecycle based on auth and settings state.
class PushNotificationInitializer extends StatefulWidget {
  const PushNotificationInitializer({
    super.key,
    required this.pushService,
    required this.child,
  });

  final PushService pushService;
  final Widget child;

  @override
  State<PushNotificationInitializer> createState() =>
      _PushNotificationInitializerState();
}

class _PushNotificationInitializerState
    extends State<PushNotificationInitializer> {
  bool _initialized = false;

  Future<void> _initPush() async {
    if (_initialized) return;
    try {
      await widget.pushService.initialize(
        onNotificationTapped: _handleNotificationTap,
      );
      _initialized = true;
    } catch (_) {
      // Firebase not configured — silently fail
    }
  }

  Future<void> _cleanupPush() async {
    if (!_initialized) return;
    try {
      await widget.pushService.removeTokens();
    } catch (_) {}
    _initialized = false;
  }

  void _handleNotificationTap(Map<String, dynamic> data) {
    final type = data['type'] as String?;
    final gameId = data['game_id'] as String?;

    if (type == 'turn_notification' && gameId != null) {
      GoRouter.of(context).go('${AppRoutes.activeGames}/$gameId');
    } else if (type == 'challenge' && gameId != null) {
      GoRouter.of(context).go(AppRoutes.friends);
    }
  }

  @override
  void dispose() {
    widget.pushService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthCubitState>(
          listener: (context, authState) {
            if (authState is Authenticated) {
              final settings = context.read<SettingsCubit>().state;
              if (settings.pushNotifications) {
                _initPush();
              }
            } else if (authState is Unauthenticated) {
              _cleanupPush();
            }
          },
        ),
        BlocListener<SettingsCubit, SettingsState>(
          listener: (context, settings) {
            final authState = context.read<AuthCubit>().state;
            if (authState is! Authenticated) return;

            if (settings.pushNotifications) {
              _initPush();
            } else {
              _cleanupPush();
            }
          },
        ),
      ],
      child: widget.child,
    );
  }
}
