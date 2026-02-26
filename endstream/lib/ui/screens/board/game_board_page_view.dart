import 'package:flutter/material.dart';

import '../../../core/cubits/games/game_board_bloc.dart';
import '../../../core/models/game_card.dart';
import '../../../core/models/operator_instance.dart';
import '../../../core/models/turnpoint.dart';
import '../../animations/position_resolver.dart';
import 'animated_hand_card_list.dart';
import 'animated_stream_panel.dart';
import 'hand_menu_panel.dart';

/// PageView with 3 pages: opponent stream, my stream (default), hand/menu.
class GameBoardPageView extends StatefulWidget {
  const GameBoardPageView({
    super.key,
    required this.myStream,
    required this.opponentStream,
    required this.myHand,
    required this.selection,
    required this.isMyTurn,
    required this.actionPoints,
    required this.maxActionPoints,
    required this.myPlayerId,
    required this.onSelectCard,
    required this.onSelectOperator,
    required this.onSelectTarget,
    required this.onEndTurn,
    required this.onConcede,
    this.positionResolver,
  });

  final List<Turnpoint> myStream;
  final List<Turnpoint> opponentStream;
  final List<GameCard> myHand;
  final SelectionState selection;
  final bool isMyTurn;
  final int actionPoints;
  final int maxActionPoints;
  final String myPlayerId;
  final void Function(GameCard) onSelectCard;
  final void Function(OperatorInstance) onSelectOperator;
  final void Function(StreamPosition) onSelectTarget;
  final VoidCallback onEndTurn;
  final VoidCallback onConcede;
  final PositionResolver? positionResolver;

  @override
  State<GameBoardPageView> createState() => _GameBoardPageViewState();
}

class _GameBoardPageViewState extends State<GameBoardPageView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String? _selectedOperatorId() {
    final sel = widget.selection;
    if (sel is OperatorSelectedState) {
      return sel.operator.instanceId ?? sel.operator.operatorCardId;
    }
    if (sel is TargetingState && sel.sourceOperator != null) {
      return sel.sourceOperator!.instanceId ?? sel.sourceOperator!.operatorCardId;
    }
    return null;
  }

  String? _selectedCardId() {
    final sel = widget.selection;
    if (sel is CardSelectedState) return sel.card.id;
    if (sel is TargetingState && sel.sourceCard != null) {
      return sel.sourceCard!.id;
    }
    return null;
  }

  bool _isCellValidTarget(int centuryIndex, {required bool isOpponent}) {
    final sel = widget.selection;
    if (!widget.isMyTurn) return false;

    // Card selected: valid targets are own-stream turnpoints
    if (sel is CardSelectedState && !isOpponent) return true;

    // Operator selected: adjacent cells (simplified for prototype)
    if (sel is OperatorSelectedState) {
      final pos = sel.operator.position;
      final diff = (pos.centuryIndex - centuryIndex).abs();
      // Can move to adjacent centuries in same or opposite stream
      return diff <= 1;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const ClampingScrollPhysics(),
      children: [
        AnimatedStreamPanel(
          label: 'OPPONENT STREAM',
          turnpoints: widget.opponentStream,
          isOpponent: true,
          isActivePanel: !widget.isMyTurn,
          selectedOperatorId: _selectedOperatorId(),
          selection: widget.selection,
          isMyTurn: widget.isMyTurn,
          onOperatorTap: widget.isMyTurn ? widget.onSelectOperator : null,
          onCellTap: widget.isMyTurn
              ? (index) => widget.onSelectTarget(
                    StreamPosition(stream: 1, centuryIndex: index),
                  )
              : null,
          isCellValidTarget: (index) =>
              _isCellValidTarget(index, isOpponent: true),
        ),
        AnimatedStreamPanel(
          label: 'YOUR STREAM',
          turnpoints: widget.myStream,
          isOpponent: false,
          isActivePanel: widget.isMyTurn,
          selectedOperatorId: _selectedOperatorId(),
          selection: widget.selection,
          isMyTurn: widget.isMyTurn,
          onOperatorTap: widget.isMyTurn ? widget.onSelectOperator : null,
          onCellTap: widget.isMyTurn
              ? (index) => widget.onSelectTarget(
                    StreamPosition(stream: 0, centuryIndex: index),
                  )
              : null,
          isCellValidTarget: (index) =>
              _isCellValidTarget(index, isOpponent: false),
        ),
        AnimatedHandCardList(
          isMyTurn: widget.isMyTurn,
          child: HandMenuPanel(
            hand: widget.myHand,
            isMyTurn: widget.isMyTurn,
            actionPoints: widget.actionPoints,
            maxActionPoints: widget.maxActionPoints,
            selectedCardId: _selectedCardId(),
            onSelectCard: widget.onSelectCard,
            onEndTurn: widget.onEndTurn,
            onConcede: widget.onConcede,
          ),
        ),
      ],
    );
  }
}
