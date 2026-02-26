import '../models/analytics_types.dart';

export '../models/analytics_types.dart';

/// Abstract interface for game analytics tracking.
abstract class AnalyticsService {
  /// Track a game analytics event with optional properties.
  Future<void> trackEvent(
    AnalyticsEvent event, {
    Map<String, dynamic>? properties,
  });

  /// Track screen navigation for user flow analysis.
  Future<void> trackScreen(String screenName);
}
