import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/cubits/settings/settings_cubit.dart';
import '../core/services/audio_service.dart';

/// Syncs [AudioService] volume with [SettingsCubit] settings changes.
///
/// Sits in the widget tree above [MaterialApp] and listens for volume
/// setting changes, forwarding them to the audio service.
class AudioInitializer extends StatefulWidget {
  const AudioInitializer({
    super.key,
    required this.audioService,
    required this.child,
  });

  final AudioService audioService;
  final Widget child;

  @override
  State<AudioInitializer> createState() => _AudioInitializerState();
}

class _AudioInitializerState extends State<AudioInitializer>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Apply initial volume from settings
    final settings = context.read<SettingsCubit>().state;
    widget.audioService.updateMusicVolume(settings.musicVolume);
    widget.audioService.updateSfxVolume(settings.sfxVolume);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.audioService.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Pause music when app goes to background, resume when foreground
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        widget.audioService.pauseMusic();
      case AppLifecycleState.resumed:
        widget.audioService.resumeMusic();
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (prev, curr) =>
          prev.musicVolume != curr.musicVolume ||
          prev.sfxVolume != curr.sfxVolume,
      listener: (context, state) {
        widget.audioService.updateMusicVolume(state.musicVolume);
        widget.audioService.updateSfxVolume(state.sfxVolume);
      },
      child: widget.child,
    );
  }
}
