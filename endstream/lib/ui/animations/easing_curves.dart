import 'package:flutter/animation.dart';

/// EndStream motion language — restrained, angular, tense.
///
/// FORBIDDEN: Curves.bounceOut, Curves.elasticOut, SpringSimulation
abstract final class TreeCurves {
  /// Restrained ease-out for general transitions.
  static const standard = Cubic(0.25, 0.1, 0.25, 1.0);

  /// Barely perceptible for subtle shifts.
  static const subtle = Cubic(0.33, 0.0, 0.67, 1.0);

  /// Quick start, slow end for sharp interactions.
  static const sharp = Cubic(0.4, 0.0, 1.0, 1.0);

  /// Linear for wave propagation and ripple travel.
  static const linear = Curves.linear;
}

/// Standard durations for EndStream animations.
abstract final class TreeDurations {
  static const instant = Duration(milliseconds: 100);
  static const fast = Duration(milliseconds: 200);
  static const normal = Duration(milliseconds: 350);
  static const slow = Duration(milliseconds: 500);
  static const transition = Duration(milliseconds: 400);
}
