import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import 'ripple_engine.dart';
import 'time_tree_data.dart';
import 'time_tree_generator.dart';
import 'time_tree_oscillator.dart';

/// Central controller for the Time Tree background system.
///
/// Holds the pre-computed tree structure, oscillator, and ripple engine.
/// Notifies listeners on oscillation ticks and active ripples so the
/// painter repaints only when needed.
class TimeTreeController extends ChangeNotifier {
  TimeTreeController({
    required TickerProvider vsync,
    required Size screenSize,
    double density = 0.7,
    bool reduceMotion = false,
  })  : _screenSize = screenSize,
        _density = density,
        _oscillator = TimeTreeOscillator(vsync),
        _rippleEngine = RippleEngine() {
    _structure = TimeTreeGenerator.generate(screenSize, density: density);
    _oscillator.updateReduceMotion(reduceMotion);
    _oscillator.animation.addListener(_onTick);
  }

  late TreeStructure _structure;
  final TimeTreeOscillator _oscillator;
  final RippleEngine _rippleEngine;

  Size _screenSize;
  double _density;

  /// Current pre-computed tree structure.
  TreeStructure get structure => _structure;

  /// Current oscillation time (0.0–1.0).
  double get oscillationTime => _oscillator.time;

  /// Current oscillation amplitude in pixels.
  double get oscillationAmplitude => _oscillator.amplitude;

  /// Active ripples for the painter.
  List<ActiveRipple> get ripples => _rippleEngine.ripples;

  /// Regenerate tree when density changes.
  void updateDensity(double density) {
    if (_density == density) return;
    _density = density;
    _structure = TimeTreeGenerator.generate(_screenSize, density: density);
    notifyListeners();
  }

  /// Toggle oscillation for reduce-motion accessibility.
  void updateReduceMotion(bool reduce) {
    _oscillator.updateReduceMotion(reduce);
    notifyListeners();
  }

  /// Regenerate tree when screen size changes.
  void updateScreenSize(Size size) {
    if (_screenSize == size) return;
    _screenSize = size;
    _structure = TimeTreeGenerator.generate(size, density: _density);
    notifyListeners();
  }

  /// Emit a ripple from an absolute screen position.
  void emitRipple(Offset screenPosition, double intensity) {
    _rippleEngine.emit(screenPosition, _screenSize, intensity);
    notifyListeners();
  }

  void _onTick() {
    final hadRipples = _rippleEngine.hasActiveRipples;
    _rippleEngine.tick();

    // Only repaint when there's visible animation:
    // oscillation is active OR ripples existed before/after tick.
    if (_oscillator.amplitude != 0 ||
        hadRipples ||
        _rippleEngine.hasActiveRipples) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _oscillator.animation.removeListener(_onTick);
    _oscillator.dispose();
    super.dispose();
  }
}
