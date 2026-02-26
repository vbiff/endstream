import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import 'onboarding_deck_page.dart';
import 'onboarding_lore_page.dart';
import 'onboarding_mechanics_page.dart';
import 'onboarding_navigation_bar.dart';
import 'onboarding_page_indicator.dart';
import 'onboarding_win_page.dart';

/// 4-page onboarding flow shown after first registration.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const _pageCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pageCount - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: const Cubic(0.25, 0.1, 0.25, 1.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TreeColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            OnboardingPageIndicator(
              pageCount: _pageCount,
              currentPage: _currentPage,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const ClampingScrollPhysics(),
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: const [
                  OnboardingLorePage(),
                  OnboardingMechanicsPage(),
                  OnboardingWinPage(),
                  OnboardingDeckPage(),
                ],
              ),
            ),
            OnboardingNavigationBar(
              isLastPage: _currentPage == _pageCount - 1,
              onNext: _nextPage,
            ),
          ],
        ),
      ),
    );
  }
}
