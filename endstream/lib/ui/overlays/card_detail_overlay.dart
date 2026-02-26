import 'package:flutter/material.dart';

import '../../core/models/game_card.dart';
import '../components/card_full.dart';
import '../components/tree_modal.dart';

/// Full-screen overlay showing detailed card information.
class CardDetailOverlay extends StatelessWidget {
  const CardDetailOverlay({
    super.key,
    required this.card,
    required this.onClose,
  });

  final GameCard card;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return TreeModal(
      onClose: onClose,
      child: SingleChildScrollView(
        child: CardFull(card: card),
      ),
    );
  }
}
