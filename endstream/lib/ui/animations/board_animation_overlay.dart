import 'package:flutter/material.dart';

import 'animation_request.dart';
import 'board_animation_controller.dart';
import 'combat_line_painter.dart';
import 'move_animation_painter.dart';
import 'card_play_particle_painter.dart';
import 'position_resolver.dart';

/// Overlay widget that paints cross-widget animation effects.
///
/// Sits above [GameBoardPageView] in the Stack. Listens to
/// [BoardAnimationController] and dispatches to the correct painter
/// based on the current [AnimationRequest].
class BoardAnimationOverlay extends StatefulWidget {
  const BoardAnimationOverlay({
    super.key,
    required this.controller,
    required this.positionResolver,
  });

  final BoardAnimationController controller;
  final PositionResolver positionResolver;

  @override
  State<BoardAnimationOverlay> createState() => _BoardAnimationOverlayState();
}

class _BoardAnimationOverlayState extends State<BoardAnimationOverlay>
    with TickerProviderStateMixin {
  AnimationController? _animController;
  AnimationRequest? _activeRequest;
  CustomPainter? _cachedPainter;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(BoardAnimationOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onControllerChanged);
      widget.controller.addListener(_onControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _animController?.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    final current = widget.controller.current;
    if (current == _activeRequest) return;

    // New animation to play
    _animController?.dispose();
    _animController = null;
    _activeRequest = current;
    _cachedPainter = null;

    if (current == null) {
      setState(() {});
      return;
    }

    final duration = _durationForRequest(current);
    _animController = AnimationController(vsync: this, duration: duration);
    _animController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.controller.completeCurrentAnimation();
      }
    });

    // Resolve positions and build the painter once per animation request
    _cachedPainter = _buildPainterForRequest(current);

    _animController!.forward();
    setState(() {});
  }

  Duration _durationForRequest(AnimationRequest request) {
    return switch (request) {
      CombatAnimationRequest(:final isElimination) =>
        isElimination
            ? const Duration(milliseconds: 800)
            : const Duration(milliseconds: 600),
      MoveAnimationRequest() => const Duration(milliseconds: 550),
      CardPlayAnimationRequest() => const Duration(milliseconds: 500),
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_activeRequest == null || _animController == null || _cachedPainter == null) {
      return const SizedBox.shrink();
    }

    return CustomPaint(
      size: Size.infinite,
      painter: _cachedPainter,
    );
  }

  CustomPainter? _buildPainterForRequest(AnimationRequest request) {
    final ancestor = context.findRenderObject();

    return switch (request) {
      CombatAnimationRequest() => _buildCombatPainter(request, ancestor),
      MoveAnimationRequest() => _buildMovePainter(request, ancestor),
      CardPlayAnimationRequest() => _buildCardPlayPainter(request, ancestor),
    };
  }

  CustomPainter? _buildCombatPainter(
    CombatAnimationRequest request,
    RenderObject? ancestor,
  ) {
    final from = widget.positionResolver.resolveCell(request.attackerPosition, ancestor);
    final to = widget.positionResolver.resolveCell(request.defenderPosition, ancestor);
    if (from == null || to == null) return null;

    return CombatLinePainter(
      from: from,
      to: to,
      animation: _animController!,
      damage: request.damage,
      isElimination: request.isElimination,
    );
  }

  CustomPainter? _buildMovePainter(
    MoveAnimationRequest request,
    RenderObject? ancestor,
  ) {
    final from = widget.positionResolver.resolveCell(request.fromPosition, ancestor);
    final to = widget.positionResolver.resolveCell(request.toPosition, ancestor);
    if (from == null || to == null) return null;

    return MoveAnimationPainter(
      from: from,
      to: to,
      animation: _animController!,
    );
  }

  CustomPainter? _buildCardPlayPainter(
    CardPlayAnimationRequest request,
    RenderObject? ancestor,
  ) {
    final to = widget.positionResolver.resolveCell(request.targetPosition, ancestor);
    if (to == null) return null;

    // Source: bottom center of overlay (hand area)
    final size = (context.findRenderObject() as RenderBox?)?.size;
    final from = Offset(
      (size?.width ?? 200) / 2,
      size?.height ?? 400,
    );

    return CardPlayParticlePainter(
      from: from,
      to: to,
      animation: _animController!,
    );
  }
}
