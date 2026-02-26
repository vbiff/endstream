import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/models/client_game_state.dart';
import '../../animations/defeat_cascade_painter.dart';
import '../../animations/easing_curves.dart';
import '../../animations/victory_cascade_painter.dart';
import '../../components/tree_button.dart';
import '../../components/tree_card.dart';
import '../../components/tree_divider.dart';

/// Animated game over overlay — backdrop fade, cascade effect, card scale-in,
/// staggered stats, and button reveal.
class AnimatedGameOverView extends StatefulWidget {
  const AnimatedGameOverView({
    super.key,
    required this.isWinner,
    required this.onExit,
    this.gameState,
    this.onRematch,
  });

  final bool isWinner;
  final VoidCallback onExit;
  final ClientGameState? gameState;
  final VoidCallback? onRematch;

  @override
  State<AnimatedGameOverView> createState() => _AnimatedGameOverViewState();
}

class _AnimatedGameOverViewState extends State<AnimatedGameOverView>
    with TickerProviderStateMixin {
  late final AnimationController _backdropController;
  late final AnimationController _cascadeController;
  late final AnimationController _contentController;

  late final Animation<double> _backdropOpacity;
  late final Animation<double> _cascadeProgress;
  late final Animation<double> _cardScale;
  late final Animation<double> _cardOpacity;
  late final Animation<double> _statsOpacity;
  late final Animation<double> _buttonOpacity;

  @override
  void initState() {
    super.initState();

    // Phase 1: backdrop + cascade (0–1200ms)
    _backdropController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _backdropOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _backdropController, curve: TreeCurves.standard),
    );

    _cascadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _cascadeProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cascadeController, curve: TreeCurves.standard),
    );

    // Phase 2: content reveal (card → stats → buttons)
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _cardScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.0, 0.4, curve: TreeCurves.standard),
      ),
    );
    _cardOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.0, 0.3, curve: TreeCurves.standard),
      ),
    );
    _statsOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.3, 0.7, curve: TreeCurves.standard),
      ),
    );
    _buttonOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.6, 1.0, curve: TreeCurves.standard),
      ),
    );

    _startSequence();
  }

  Future<void> _startSequence() async {
    // Backdrop fades in
    _backdropController.forward();
    // Cascade starts immediately
    _cascadeController.forward();
    // Content appears after brief delay
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (mounted) {
      _contentController.forward();
    }
  }

  @override
  void dispose() {
    _backdropController.dispose();
    _cascadeController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _backdropController,
        _cascadeController,
        _contentController,
      ]),
      builder: (context, _) {
        return Stack(
          children: [
            // Backdrop
            Opacity(
              opacity: _backdropOpacity.value * 0.7,
              child: const ColoredBox(
                color: Color(0xFF000000),
                child: SizedBox.expand(),
              ),
            ),
            // Cascade effect
            CustomPaint(
              size: Size.infinite,
              painter: widget.isWinner
                  ? VictoryCascadePainter(progress: _cascadeProgress.value)
                  : DefeatCascadePainter(progress: _cascadeProgress.value),
            ),
            // Content card
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Transform.scale(
                  scale: _cardScale.value,
                  child: Opacity(
                    opacity: _cardOpacity.value,
                    child: TreeCard(
                      highlighted: true,
                      highlightColor: widget.isWinner
                          ? TreeColors.activation
                          : TreeColors.error,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _AnimatedGameOverTitle(isWinner: widget.isWinner),
                          const SizedBox(height: 8),
                          _AnimatedGameOverSubtitle(
                              isWinner: widget.isWinner),
                          if (widget.gameState != null) ...[
                            const SizedBox(height: 16),
                            const TreeDivider(),
                            const SizedBox(height: 16),
                            Opacity(
                              opacity: _statsOpacity.value,
                              child: _AnimatedPostGameStats(
                                gameState: widget.gameState!,
                                isWinner: widget.isWinner,
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          Opacity(
                            opacity: _buttonOpacity.value,
                            child: Column(
                              children: [
                                if (widget.onRematch != null) ...[
                                  TreeButton(
                                    onPressed: widget.onRematch!,
                                    label: 'REMATCH',
                                  ),
                                  const SizedBox(height: 12),
                                ],
                                TreeButton(
                                  onPressed: widget.onExit,
                                  label: 'EXIT',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AnimatedGameOverTitle extends StatelessWidget {
  const _AnimatedGameOverTitle({required this.isWinner});

  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    return Text(
      isWinner ? 'VICTORY' : 'DEFEAT',
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: isWinner ? TreeColors.activation : TreeColors.error,
          ),
    );
  }
}

class _AnimatedGameOverSubtitle extends StatelessWidget {
  const _AnimatedGameOverSubtitle({required this.isWinner});

  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    return Text(
      isWinner
          ? 'The timeline is restored.'
          : 'The timeline has collapsed.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: TreeColors.textSecondary,
          ),
    );
  }
}

class _AnimatedPostGameStats extends StatelessWidget {
  const _AnimatedPostGameStats({
    required this.gameState,
    required this.isWinner,
  });

  final ClientGameState gameState;
  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    final myOperators = gameState.myStream
        .expand((tp) => tp.operators)
        .where((op) => op.ownerId == gameState.myPlayerId)
        .length;

    return Column(
      children: [
        _AnimatedPostGameStatRow(
          label: 'TURNS PLAYED',
          value: '${gameState.game.currentTurn}',
        ),
        const SizedBox(height: 8),
        _AnimatedPostGameStatRow(
          label: 'OPERATORS REMAINING',
          value: '$myOperators',
        ),
        const SizedBox(height: 8),
        _AnimatedPostGameStatRow(
          label: 'CONTROLLER HP',
          value: '${gameState.myControllerHp} / 10',
        ),
        const SizedBox(height: 8),
        _AnimatedPostGameStatRow(
          label: 'XP GAINED',
          value: isWinner ? '+50 XP' : '+20 XP',
        ),
      ],
    );
  }
}

class _AnimatedPostGameStatRow extends StatelessWidget {
  const _AnimatedPostGameStatRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: TreeColors.textSecondary,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: TreeColors.textPrimary,
              ),
        ),
      ],
    );
  }
}
