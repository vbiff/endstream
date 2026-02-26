import 'dart:math';
import 'dart:ui';

/// A single active ripple propagating upward from an origin point.
class ActiveRipple {
  ActiveRipple({
    required this.origin,
    required this.intensity,
  })  : startTime = DateTime.now(),
        _speed = 0.3, // normalized units per second
        _decayRate = 2.5,
        _cachedElapsed = 0.0;

  /// Origin in normalized [0–1] coordinates.
  final Offset origin;

  /// Initial intensity (0.1–1.0).
  final double intensity;

  final DateTime startTime;
  final double _speed;
  final double _decayRate;

  /// Wavefront band width (normalized).
  static const _bandWidth = 0.08;

  /// Cached elapsed time — updated once per frame via [updateElapsed].
  double _cachedElapsed;

  /// Snapshot the elapsed time once per frame. Avoids calling
  /// `DateTime.now()` per-ripple-per-segment.
  void updateElapsed() {
    _cachedElapsed =
        DateTime.now().difference(startTime).inMilliseconds / 1000.0;
  }

  /// Current wavefront radius (grows with time).
  double get radius => _cachedElapsed * _speed;

  /// Current intensity (decays exponentially).
  double get currentIntensity =>
      intensity * exp(-_decayRate * _cachedElapsed);

  /// Whether this ripple has faded below visibility.
  bool get isExpired => currentIntensity < 0.01;

  /// Calculates the ripple's color influence on a segment.
  ///
  /// Only affects segments whose midpoint is above the origin and within
  /// the wavefront band. Uses squared distance to avoid sqrt.
  double influenceAt(Offset segStart, Offset segEnd) {
    final midX = (segStart.dx + segEnd.dx) / 2;
    final midY = (segStart.dy + segEnd.dy) / 2;

    // Only propagate upward (lower y = higher on screen)
    if (midY > origin.dy) return 0;

    final dx = midX - origin.dx;
    final dy = midY - origin.dy;
    final distSq = dx * dx + dy * dy;
    final r = radius;

    // Quick squared-distance rejection against the outer band edge
    final bandEnd = r + _bandWidth;
    if (distSq > bandEnd * bandEnd) return 0;

    // Need actual distance only for candidates inside outer band
    final dist = sqrt(distSq);
    final bandStart = r - _bandWidth;
    if (dist < bandStart) return 0;

    // Intensity falls off toward band edges
    final bandPosition = 1.0 - ((dist - r).abs() / _bandWidth);
    return (bandPosition * currentIntensity).clamp(0.0, 1.0);
  }
}

/// Manages active ripples — emit, propagate, decay, cleanup.
///
/// Maximum 5 concurrent ripples. Expired ones are auto-removed on tick.
class RippleEngine {
  final _ripples = <ActiveRipple>[];
  List<ActiveRipple> _cachedRipples = const [];
  bool _listDirty = false;

  static const _maxRipples = 5;

  /// Unmodifiable view of active ripples for the painter.
  /// Cached — only regenerated when the list changes.
  List<ActiveRipple> get ripples {
    if (_listDirty) {
      _cachedRipples = List.unmodifiable(_ripples);
      _listDirty = false;
    }
    return _cachedRipples;
  }

  /// Whether any ripples are active (drives repaint decisions).
  bool get hasActiveRipples => _ripples.isNotEmpty;

  /// Emit a new ripple from a screen position.
  ///
  /// [screenPosition] is in absolute screen coordinates.
  /// [screenSize] is used to normalize to [0–1] range.
  /// [intensity] should be 0.1–1.0.
  void emit(Offset screenPosition, Size screenSize, double intensity) {
    if (screenSize.isEmpty) return;

    final normalized = Offset(
      screenPosition.dx / screenSize.width,
      screenPosition.dy / screenSize.height,
    );

    final clamped = intensity.clamp(0.1, 1.0);

    // Enforce max ripple count — drop oldest if at capacity
    if (_ripples.length >= _maxRipples) {
      _ripples.removeAt(0);
    }

    _ripples.add(ActiveRipple(origin: normalized, intensity: clamped));
    _listDirty = true;
  }

  /// Snapshot elapsed time for all ripples, then remove expired ones.
  bool tick() {
    for (final ripple in _ripples) {
      ripple.updateElapsed();
    }
    final before = _ripples.length;
    _ripples.removeWhere((r) => r.isExpired);
    if (_ripples.length != before) {
      _listDirty = true;
      return true;
    }
    return false;
  }
}
