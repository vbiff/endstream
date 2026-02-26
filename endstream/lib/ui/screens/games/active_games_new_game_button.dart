import 'package:flutter/material.dart';

import '../../components/components.dart';

/// Button to navigate to new game setup.
class ActiveGamesNewGameButton extends StatelessWidget {
  const ActiveGamesNewGameButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: TreeButton(
        onPressed: onPressed,
        label: '+ NEW GAME',
      ),
    );
  }
}
