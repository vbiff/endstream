import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'component_enums.dart';
import 'tree_badge.dart';
import 'tree_branch.dart';
import 'tree_card.dart';
import 'tree_node.dart';

/// Game entry in the active games list, with a pulse animation for "your turn".
class GameListItem extends StatefulWidget {
  const GameListItem({
    super.key,
    required this.gameName,
    required this.opponentName,
    required this.status,
    required this.turnNumber,
    this.onTap,
  });

  final String gameName;
  final String opponentName;
  final GameItemStatus status;
  final int turnNumber;
  final VoidCallback? onTap;

  @override
  State<GameListItem> createState() => _GameListItemState();
}

class _GameListItemState extends State<GameListItem>
    with SingleTickerProviderStateMixin {
  AnimationController? _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initPulse();
  }

  @override
  void didUpdateWidget(GameListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status != oldWidget.status) {
      _disposePulse();
      _initPulse();
    }
  }

  void _initPulse() {
    if (widget.status == GameItemStatus.yourTurn) {
      _pulseController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
      )..repeat(reverse: true);
      _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
        CurvedAnimation(parent: _pulseController!, curve: Curves.linear),
      );
    }
  }

  void _disposePulse() {
    _pulseController?.dispose();
    _pulseController = null;
  }

  @override
  void dispose() {
    _disposePulse();
    super.dispose();
  }

  Color _statusColor() {
    switch (widget.status) {
      case GameItemStatus.yourTurn:
        return TreeColors.activation;
      case GameItemStatus.waiting:
        return TreeColors.branchActive;
      case GameItemStatus.won:
        return TreeColors.highlight;
      case GameItemStatus.lost:
        return TreeColors.dormant.withValues(alpha: 0.5);
      case GameItemStatus.abandoned:
        return TreeColors.dormant;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final nodeColor = _statusColor();

    Widget nodeWidget = TreeNode(
      size: 10,
      shape: TreeNodeShape.square,
      color: nodeColor,
    );

    if (_pulseController != null) {
      nodeWidget = AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Opacity(opacity: _pulseAnimation.value, child: child);
        },
        child: nodeWidget,
      );
    }

    return TreeCard(
      onTap: widget.onTap,
      child: Row(
        children: [
          nodeWidget,
          const SizedBox(width: 8),
          TreeBranch(
            direction: TreeBranchDirection.horizontal,
            length: 16,
            color: TreeColors.branchDefault,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.gameName,
                  style: textTheme.titleMedium?.copyWith(
                    color: TreeColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.opponentName,
                  style: textTheme.labelSmall?.copyWith(
                    color: TreeColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          TreeBadge(
            text: 'T${widget.turnNumber}',
            color: nodeColor,
          ),
        ],
      ),
    );
  }
}
