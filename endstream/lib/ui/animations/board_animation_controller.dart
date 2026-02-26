import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'animation_request.dart';

/// Central controller for sequencing board animations.
///
/// Maintains a FIFO queue of [AnimationRequest]s. The overlay widget listens
/// to this controller and plays the current animation, calling
/// [completeCurrentAnimation] when done.
class BoardAnimationController extends ChangeNotifier {
  final Queue<AnimationRequest> _queue = Queue<AnimationRequest>();
  VoidCallback? _onAllComplete;

  /// The animation currently playing (head of queue), or null if idle.
  AnimationRequest? get current => _queue.isNotEmpty ? _queue.first : null;

  /// Whether there are animations pending or playing.
  bool get isAnimating => _queue.isNotEmpty;

  /// Enqueue one or more animation requests.
  ///
  /// If [onAllComplete] is provided, it will be called when the entire
  /// batch finishes (queue empties).
  void enqueue(
    List<AnimationRequest> requests, {
    VoidCallback? onAllComplete,
  }) {
    if (requests.isEmpty) return;
    _onAllComplete = onAllComplete;
    _queue.addAll(requests);
    notifyListeners();
  }

  /// Called by the overlay when the current animation finishes.
  void completeCurrentAnimation() {
    if (_queue.isEmpty) return;
    _queue.removeFirst();
    if (_queue.isEmpty) {
      _onAllComplete?.call();
      _onAllComplete = null;
    }
    notifyListeners();
  }

  /// Discard all queued animations.
  void clear() {
    _queue.clear();
    _onAllComplete = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _queue.clear();
    _onAllComplete = null;
    super.dispose();
  }
}
