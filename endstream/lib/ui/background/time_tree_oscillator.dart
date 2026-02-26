import 'package:flutter/animation.dart';

/// Drives micro-oscillation for the Time Tree background.
///
/// Single [AnimationController] with a 3-second repeating period.
/// Amplitude is 0.75px normally, 0 when reduceMotion is active.
class TimeTreeOscillator {
  TimeTreeOscillator(TickerProvider vsync)
      : _controller = AnimationController(
          vsync: vsync,
          duration: const Duration(seconds: 3),
        ) {
    _controller.repeat();
  }

  final AnimationController _controller;

  static const _defaultAmplitude = 0.75;

  double _amplitude = _defaultAmplitude;

  /// Current oscillation time (0.0–1.0), drives sin() phase in the painter.
  double get time => _controller.value;

  /// Current oscillation amplitude in pixels.
  double get amplitude => _amplitude;

  /// Access the underlying animation for listener registration.
  AnimationController get animation => _controller;

  /// Toggle oscillation for reduce-motion accessibility.
  void updateReduceMotion(bool reduce) {
    if (reduce) {
      _amplitude = 0;
      _controller.stop();
    } else {
      _amplitude = _defaultAmplitude;
      if (!_controller.isAnimating) {
        _controller.repeat();
      }
    }
  }

  void dispose() {
    _controller.dispose();
  }
}
