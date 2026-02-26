import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// Row of square dots indicating current page in onboarding flow.
class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  final int pageCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: _IndicatorDot(isActive: index == currentPage),
        );
      }),
    );
  }
}

class _IndicatorDot extends StatelessWidget {
  const _IndicatorDot({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? TreeColors.highlight : TreeColors.dormant,
      ),
    );
  }
}
