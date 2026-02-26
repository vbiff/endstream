import 'package:flutter/widgets.dart';

import 'time_tree_controller.dart';

/// Provides the [TimeTreeController] to descendants via [InheritedWidget].
///
/// Use [of] to depend on the controller (rebuilds on changes).
/// Use [maybeOf] for non-rebuilding access (e.g., ripple emission on tap).
class TimeTreeScope extends InheritedNotifier<TimeTreeController> {
  const TimeTreeScope({
    super.key,
    required TimeTreeController controller,
    required super.child,
  }) : super(notifier: controller);

  /// Obtain the controller and depend on it (will rebuild when notified).
  static TimeTreeController of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<TimeTreeScope>();
    assert(scope != null, 'No TimeTreeScope found in widget tree');
    return scope!.notifier!;
  }

  /// Obtain the controller without depending on it (no rebuilds).
  /// Returns null if no [TimeTreeScope] exists in the tree.
  static TimeTreeController? maybeOf(BuildContext context) {
    final scope = context
        .getInheritedWidgetOfExactType<TimeTreeScope>();
    return scope?.notifier;
  }
}
