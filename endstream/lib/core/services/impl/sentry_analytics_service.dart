import 'package:sentry_flutter/sentry_flutter.dart';

import '../analytics_service.dart';

class SentryAnalyticsService implements AnalyticsService {
  const SentryAnalyticsService();

  @override
  Future<void> trackEvent(
    AnalyticsEvent event, {
    Map<String, dynamic>? properties,
  }) async {
    await Sentry.addBreadcrumb(Breadcrumb(
      message: event.name,
      category: 'analytics',
      data: properties,
      timestamp: DateTime.now(),
      level: SentryLevel.info,
    ));
  }

  @override
  Future<void> trackScreen(String screenName) async {
    await Sentry.addBreadcrumb(Breadcrumb(
      message: screenName,
      category: 'navigation',
      timestamp: DateTime.now(),
      level: SentryLevel.info,
    ));
  }
}
