import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/settings/settings_cubit.dart';
import '../../components/tree_button.dart';

/// Bottom bar with SKIP and NEXT/START buttons for onboarding.
class OnboardingNavigationBar extends StatelessWidget {
  const OnboardingNavigationBar({
    super.key,
    required this.isLastPage,
    required this.onNext,
  });

  final bool isLastPage;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _SkipButton(),
          SizedBox(
            width: 120,
            child: TreeButton(
              onPressed: isLastPage
                  ? () {
                      context.read<SettingsCubit>().completeOnboarding();
                      context.go('/tutorial');
                    }
                  : onNext,
              label: isLastPage ? 'START' : 'NEXT',
            ),
          ),
        ],
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SettingsCubit>().completeOnboarding();
        context.go('/hub');
      },
      child: Text(
        'SKIP',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: TreeColors.textSecondary,
            ),
      ),
    );
  }
}
