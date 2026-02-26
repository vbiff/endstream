import 'package:flutter/widgets.dart';

import '../../core/models/operator_instance.dart';

/// Maps [StreamPosition] and card IDs to screen coordinates.
///
/// Widgets register [GlobalKey]s during build. The overlay queries
/// positions relative to its own coordinate space to paint cross-widget effects.
class PositionResolver {
  final Map<String, GlobalKey> _cellKeys = {};
  final Map<String, GlobalKey> _handCardKeys = {};

  /// Key for a turnpoint cell at the given position.
  GlobalKey keyForCell(StreamPosition pos) {
    final id = '${pos.stream}:${pos.centuryIndex}';
    return _cellKeys.putIfAbsent(id, GlobalKey.new);
  }

  /// Key for a hand card by card ID.
  GlobalKey keyForHandCard(String cardId) {
    return _handCardKeys.putIfAbsent(cardId, GlobalKey.new);
  }

  /// Resolve the center screen offset of a turnpoint cell,
  /// relative to the given [ancestor] render object.
  Offset? resolveCell(StreamPosition pos, RenderObject? ancestor) {
    final key = _cellKeys['${pos.stream}:${pos.centuryIndex}'];
    return _resolveKey(key, ancestor);
  }

  /// Resolve the center screen offset of a hand card,
  /// relative to the given [ancestor] render object.
  Offset? resolveHandCard(String cardId, RenderObject? ancestor) {
    final key = _handCardKeys[cardId];
    return _resolveKey(key, ancestor);
  }

  Offset? _resolveKey(GlobalKey? key, RenderObject? ancestor) {
    if (key == null) return null;
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return null;
    final center = renderBox.size.center(Offset.zero);
    if (ancestor != null) {
      return renderBox.localToGlobal(center, ancestor: ancestor);
    }
    return renderBox.localToGlobal(center);
  }

  /// Remove all registered keys. Call when the board is disposed.
  void clear() {
    _cellKeys.clear();
    _handCardKeys.clear();
  }
}
