import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/settings/settings_cubit.dart';
import '../../../core/models/client_game_state.dart';
import '../../animations/easing_curves.dart';
import '../../background/time_tree_scope.dart';
import '../../components/tree_button.dart';
import '../../components/tree_card.dart';
import '../../components/tree_divider.dart';

/// Game over overlay — shows win/loss result with staggered entrance animation,
/// distinct victory/defeat emotional tones, and ripple cascades on the Time Tree.
class GameOverView extends StatefulWidget {
  const GameOverView({
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
  State<GameOverView> createState() => _GameOverViewState();
}

class _GameOverViewState extends State<GameOverView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final bool _reduceMotion;

  // Staggered phase animations
  late final Animation<double> _backdropOpacity;
  late final Animation<double> _cardOpacity;
  late final Animation<double> _titleOpacity;
  late final Animation<double> _titleSlide;
  late final Animation<double> _subtitleOpacity;
  late final Animation<double> _statsOpacity;
  late final Animation<double> _buttonsOpacity;
  late final Animation<double> _accentPulse;
  late final Animation<double> _borderFlicker;

  // Ripple emission tracking
  final List<_RippleThreshold> _rippleThresholds = [];

  @override
  void initState() {
    super.initState();

    _reduceMotion = context.read<SettingsCubit>().state.reduceMotion;

    _controller = AnimationController(
      duration: _reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 2000),
      vsync: this,
    );

    if (widget.isWinner) {
      _initVictoryAnimations();
    } else {
      _initDefeatAnimations();
    }

    if (!_reduceMotion) {
      _initRippleThresholds();
      _controller.addListener(_checkRipples);
    }

    _controller.forward();
  }

  void _initVictoryAnimations() {
    // Phase 1: Backdrop fade (0.0–0.25)
    _backdropOpacity = Tween<double>(begin: 0, end: 0.7).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.25, curve: TreeCurves.standard),
      ),
    );

    // Phase 2: Card border opacity (0.15–0.45)
    _cardOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.45, curve: TreeCurves.standard),
      ),
    );

    // Phase 3: Title fade + slide (0.30–0.55)
    _titleOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.30, 0.55, curve: TreeCurves.standard),
      ),
    );
    _titleSlide = Tween<double>(begin: -8, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.30, 0.55, curve: TreeCurves.standard),
      ),
    );

    // Phase 4: Subtitle (0.45–0.65)
    _subtitleOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.65, curve: TreeCurves.standard),
      ),
    );

    // Phase 5: Stats (0.55–0.75)
    _statsOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 0.75, curve: TreeCurves.standard),
      ),
    );

    // Phase 6: Buttons (0.70–0.90)
    _buttonsOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.70, 0.90, curve: TreeCurves.standard),
      ),
    );

    // Phase 7: Accent pulse (0.80–1.0)
    _accentPulse = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.7), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.0), weight: 50),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.80, 1.0, curve: TreeCurves.subtle),
      ),
    );

    // Not used in victory
    _borderFlicker = _cardOpacity;
  }

  void _initDefeatAnimations() {
    // Phase 1: Backdrop fade darker (0.0–0.30)
    _backdropOpacity = Tween<double>(begin: 0, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.30, curve: TreeCurves.standard),
      ),
    );

    // Phase 2: Card border flicker (0.10–0.50)
    _borderFlicker = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.6), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.6, end: 0.2), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 0.2, end: 0.8), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 0.4), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.4, end: 1.0), weight: 20),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.10, 0.50),
      ),
    );

    // Card overall fade-in (same interval as flicker)
    _cardOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.10, 0.50, curve: TreeCurves.standard),
      ),
    );

    // Phase 3: Title fade + heavier slide (0.35–0.60)
    _titleOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.60, curve: TreeCurves.standard),
      ),
    );
    _titleSlide = Tween<double>(begin: -12, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.60, curve: TreeCurves.standard),
      ),
    );

    // Phase 4: Subtitle (0.50–0.70)
    _subtitleOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.50, 0.70, curve: TreeCurves.standard),
      ),
    );

    // Phase 5: Stats (0.60–0.80)
    _statsOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.60, 0.80, curve: TreeCurves.standard),
      ),
    );

    // Phase 6: Buttons (0.75–0.95)
    _buttonsOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 0.95, curve: TreeCurves.standard),
      ),
    );

    // Not used in defeat
    _accentPulse = ConstantTween<double>(1.0).animate(_controller);
  }

  void _initRippleThresholds() {
    if (widget.isWinner) {
      _rippleThresholds.addAll([
        _RippleThreshold(progress: 0.2, intensity: 0.6),
        _RippleThreshold(progress: 0.5, intensity: 0.4),
        _RippleThreshold(progress: 0.8, intensity: 0.2),
      ]);
    } else {
      _rippleThresholds.addAll([
        _RippleThreshold(progress: 0.15, intensity: 0.8),
        _RippleThreshold(progress: 0.45, intensity: 0.3),
      ]);
    }
  }

  void _checkRipples() {
    for (final threshold in _rippleThresholds) {
      if (!threshold.fired && _controller.value >= threshold.progress) {
        threshold.fired = true;
        _emitRipple(threshold.intensity);
      }
    }
  }

  void _emitRipple(double intensity) {
    final size = MediaQuery.sizeOf(context);
    TimeTreeScope.maybeOf(context)?.emitRipple(
      Offset(size.width / 2, size.height / 2),
      intensity,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _GameOverBackdrop(animation: _backdropOpacity),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: _GameOverCardShell(
              isWinner: widget.isWinner,
              cardOpacity: _cardOpacity,
              borderFlicker: widget.isWinner ? null : _borderFlicker,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _GameOverTitle(
                    isWinner: widget.isWinner,
                    opacity: _titleOpacity,
                    slide: _titleSlide,
                    accentPulse: widget.isWinner ? _accentPulse : null,
                  ),
                  const SizedBox(height: 8),
                  _GameOverSubtitle(
                    isWinner: widget.isWinner,
                    opacity: _subtitleOpacity,
                  ),
                  if (widget.gameState != null) ...[
                    const SizedBox(height: 16),
                    const TreeDivider(),
                    const SizedBox(height: 16),
                    FadeTransition(
                      opacity: _statsOpacity,
                      child: _PostGameStats(
                        gameState: widget.gameState!,
                        isWinner: widget.isWinner,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  _GameOverButtons(
                    opacity: _buttonsOpacity,
                    onRematch: widget.onRematch,
                    onExit: widget.onExit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RippleThreshold {
  _RippleThreshold({required this.progress, required this.intensity});

  final double progress;
  final double intensity;
  bool fired = false;
}

/// Animated full-screen backdrop that fades in.
class _GameOverBackdrop extends StatelessWidget {
  const _GameOverBackdrop({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => ColoredBox(
        color: Color.fromRGBO(0, 0, 0, animation.value),
        child: const SizedBox.expand(),
      ),
    );
  }
}

/// Animated TreeCard shell with highlight fade-in (victory) or flicker (defeat).
class _GameOverCardShell extends StatelessWidget {
  const _GameOverCardShell({
    required this.isWinner,
    required this.cardOpacity,
    required this.child,
    this.borderFlicker,
  });

  final bool isWinner;
  final Animation<double> cardOpacity;
  final Animation<double>? borderFlicker;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final highlightBase =
        isWinner ? TreeColors.activation : TreeColors.error;

    return AnimatedBuilder(
      animation: borderFlicker != null
          ? Listenable.merge([cardOpacity, borderFlicker!])
          : cardOpacity,
      builder: (context, child) {
        final borderOpacity = borderFlicker?.value ?? cardOpacity.value;
        return Opacity(
          opacity: cardOpacity.value,
          child: TreeCard(
            highlighted: true,
            highlightColor: highlightBase.withValues(alpha: borderOpacity),
            child: child!,
          ),
        );
      },
      child: child,
    );
  }
}

/// Title with fade + slide + optional accent pulse (victory only).
class _GameOverTitle extends StatelessWidget {
  const _GameOverTitle({
    required this.isWinner,
    required this.opacity,
    required this.slide,
    this.accentPulse,
  });

  final bool isWinner;
  final Animation<double> opacity;
  final Animation<double> slide;
  final Animation<double>? accentPulse;

  @override
  Widget build(BuildContext context) {
    final color = isWinner ? TreeColors.activation : TreeColors.error;

    return AnimatedBuilder(
      animation: accentPulse != null
          ? Listenable.merge([opacity, slide, accentPulse!])
          : Listenable.merge([opacity, slide]),
      builder: (context, _) {
        final pulseOpacity = accentPulse?.value ?? 1.0;
        return Transform.translate(
          offset: Offset(0, slide.value),
          child: Opacity(
            opacity: opacity.value * pulseOpacity,
            child: Text(
              isWinner ? 'VICTORY' : 'DEFEAT',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                  ),
            ),
          ),
        );
      },
    );
  }
}

/// Subtitle with fade-in.
class _GameOverSubtitle extends StatelessWidget {
  const _GameOverSubtitle({
    required this.isWinner,
    required this.opacity,
  });

  final bool isWinner;
  final Animation<double> opacity;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: Text(
        isWinner
            ? 'The timeline is restored.'
            : 'The timeline has collapsed.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: TreeColors.textSecondary,
            ),
      ),
    );
  }
}

/// Button column with fade-in.
class _GameOverButtons extends StatelessWidget {
  const _GameOverButtons({
    required this.opacity,
    required this.onExit,
    this.onRematch,
  });

  final Animation<double> opacity;
  final VoidCallback onExit;
  final VoidCallback? onRematch;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onRematch != null) ...[
            TreeButton(
              onPressed: onRematch!,
              label: 'REMATCH',
            ),
            const SizedBox(height: 12),
          ],
          TreeButton(
            onPressed: onExit,
            label: 'EXIT',
          ),
        ],
      ),
    );
  }
}

class _PostGameStats extends StatelessWidget {
  const _PostGameStats({
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
        _PostGameStatRow(
          label: 'TURNS PLAYED',
          value: '${gameState.game.currentTurn}',
        ),
        const SizedBox(height: 8),
        _PostGameStatRow(
          label: 'OPERATORS REMAINING',
          value: '$myOperators',
        ),
        const SizedBox(height: 8),
        _PostGameStatRow(
          label: 'CONTROLLER HP',
          value: '${gameState.myControllerHp} / 10',
        ),
        const SizedBox(height: 8),
        _PostGameStatRow(
          label: 'XP GAINED',
          value: isWinner ? '+50 XP' : '+20 XP',
        ),
      ],
    );
  }
}

class _PostGameStatRow extends StatelessWidget {
  const _PostGameStatRow({
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
