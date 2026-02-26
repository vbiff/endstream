import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubits/settings/settings_cubit.dart';
import 'time_tree_controller.dart';
import 'time_tree_scope.dart';
import 'video_tree_background.dart';

/// Root shell widget that renders the Time Tree background behind all routes.
///
/// Wraps [MaterialApp.router]'s child via the `builder:` parameter.
/// Owns a single [TimeTreeController] and provides it to descendants
/// through [TimeTreeScope].
///
/// Uses a looping video as the persistent background layer. Falls back
/// to solid black when reduceMotion is enabled or the video fails to load.
class TimeTreeShell extends StatefulWidget {
  const TimeTreeShell({super.key, required this.child});

  final Widget child;

  @override
  State<TimeTreeShell> createState() => _TimeTreeShellState();
}

class _TimeTreeShellState extends State<TimeTreeShell>
    with SingleTickerProviderStateMixin {
  TimeTreeController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mq = MediaQuery.of(context);
    final settings = context.read<SettingsCubit>().state;

    if (_controller == null) {
      _controller = TimeTreeController(
        vsync: this,
        screenSize: mq.size,
        density: settings.treeDensity,
        reduceMotion: settings.reduceMotion,
      );
    } else {
      _controller!.updateScreenSize(mq.size);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = context.watch<SettingsCubit>().state.reduceMotion;

    return TimeTreeScope(
      controller: _controller!,
      child: BlocListener<SettingsCubit, SettingsState>(
        listenWhen: (prev, curr) =>
            prev.treeDensity != curr.treeDensity ||
            prev.reduceMotion != curr.reduceMotion,
        listener: (context, state) {
          _controller!.updateDensity(state.treeDensity);
          _controller!.updateReduceMotion(state.reduceMotion);
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: ExcludeSemantics(
                child: RepaintBoundary(
                  child: VideoTreeBackground(reduceMotion: reduceMotion),
                ),
              ),
            ),
            Positioned.fill(
              child: ColoredBox(
                color: Colors.black.withValues(alpha: 0.55),
              ),
            ),
            Positioned.fill(child: widget.child),
          ],
        ),
      ),
    );
  }
}
