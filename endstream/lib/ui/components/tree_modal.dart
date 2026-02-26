import 'package:flutter/material.dart';

import 'tree_card.dart';

/// Overlay panel with backdrop dismiss.
class TreeModal extends StatelessWidget {
  const TreeModal({super.key, required this.child, this.onClose});

  final Widget child;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Semantics(
          label: 'Close dialog',
          button: true,
          child: GestureDetector(
            onTap: onClose,
            child: const ColoredBox(
              color: Color(0xB3000000), // black 70% opacity
              child: SizedBox.expand(),
            ),
          ),
        ),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320, maxHeight: 500),
            child: TreeCard(highlighted: true, child: child),
          ),
        ),
      ],
    );
  }
}
