import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/tutorial/tutorial_data.dart';
import '../../components/tree_card.dart';

/// Hint overlay positioned at the bottom of the tutorial board.
class TutorialHintOverlay extends StatelessWidget {
  const TutorialHintOverlay({
    super.key,
    required this.hint,
    required this.onSkip,
  });

  final TutorialHint hint;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: TreeCard(
          key: ValueKey(hint.title),
          highlighted: true,
          highlightColor: TreeColors.activation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HintTitle(title: hint.title),
              const SizedBox(height: 6),
              _HintBody(body: hint.body),
              const SizedBox(height: 12),
              _SkipTutorialLink(onSkip: onSkip),
            ],
          ),
        ),
      ),
    );
  }
}

class _HintTitle extends StatelessWidget {
  const _HintTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: TreeColors.activation,
          ),
    );
  }
}

class _HintBody extends StatelessWidget {
  const _HintBody({required this.body});

  final String body;

  @override
  Widget build(BuildContext context) {
    return Text(
      body,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: TreeColors.textSecondary,
          ),
    );
  }
}

class _SkipTutorialLink extends StatelessWidget {
  const _SkipTutorialLink({required this.onSkip});

  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onSkip,
        child: Text(
          'SKIP TUTORIAL',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: TreeColors.dormant,
              ),
        ),
      ),
    );
  }
}
