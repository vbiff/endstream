import 'package:flutter/material.dart';

import '../../../core/models/game_card.dart';
import '../../components/tree_divider.dart';
import '../../overlays/card_detail_overlay.dart';
import 'hand_action_bar.dart';
import 'hand_card_list.dart';
import 'hand_game_controls.dart';

/// Third page of the board PageView — hand cards + game controls.
class HandMenuPanel extends StatefulWidget {
  const HandMenuPanel({
    super.key,
    required this.hand,
    required this.isMyTurn,
    required this.actionPoints,
    required this.maxActionPoints,
    this.selectedCardId,
    this.onSelectCard,
    this.onEndTurn,
    this.onConcede,
  });

  final List<GameCard> hand;
  final bool isMyTurn;
  final int actionPoints;
  final int maxActionPoints;
  final String? selectedCardId;
  final void Function(GameCard)? onSelectCard;
  final VoidCallback? onEndTurn;
  final VoidCallback? onConcede;

  @override
  State<HandMenuPanel> createState() => _HandMenuPanelState();
}

class _HandMenuPanelState extends State<HandMenuPanel> {
  GameCard? _detailCard;

  void _showCardDetail(GameCard card) {
    setState(() => _detailCard = card);
  }

  void _hideCardDetail() {
    setState(() => _detailCard = null);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            HandActionBar(
              actionPoints: widget.actionPoints,
              maxActionPoints: widget.maxActionPoints,
            ),
            const TreeDivider(),
            Expanded(
              child: HandCardList(
                hand: widget.hand,
                actionPoints: widget.actionPoints,
                isMyTurn: widget.isMyTurn,
                selectedCardId: widget.selectedCardId,
                onSelectCard: widget.onSelectCard,
                onLongPressCard: _showCardDetail,
              ),
            ),
            HandGameControls(
              isMyTurn: widget.isMyTurn,
              onEndTurn: widget.onEndTurn ?? () {},
              onConcede: widget.onConcede ?? () {},
            ),
          ],
        ),
        if (_detailCard != null)
          CardDetailOverlay(
            card: _detailCard!,
            onClose: _hideCardDetail,
          ),
      ],
    );
  }
}
