import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/settings/settings_cubit.dart';
import '../../components/tree_button.dart';

/// Full-screen view shown when the tutorial is complete.
class TutorialCompleteView extends StatelessWidget {
  const TutorialCompleteView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: TreeColors.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _CompleteTitle(),
              const SizedBox(height: 12),
              const _CompleteSubtitle(),
              const SizedBox(height: 32),
              _BeginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompleteTitle extends StatelessWidget {
  const _CompleteTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      'TRAINING COMPLETE',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: TreeColors.activation,
          ),
    );
  }
}

class _CompleteSubtitle extends StatelessWidget {
  const _CompleteSubtitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      'You are ready to enter the stream.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: TreeColors.textSecondary,
          ),
    );
  }
}

class _BeginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: TreeButton(
        onPressed: () {
          context.read<SettingsCubit>().completeTutorial();
          context.go('/hub');
        },
        label: 'BEGIN',
      ),
    );
  }
}
