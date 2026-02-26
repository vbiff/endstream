import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../error_tracking_service.dart';

class SentryErrorTrackingService implements ErrorTrackingService {
  const SentryErrorTrackingService();

  @override
  Future<void> setUser({required String id, String? displayName}) async {
    await Sentry.configureScope((scope) {
      scope.setUser(SentryUser(id: id, username: displayName));
    });
  }

  @override
  Future<void> clearUser() async {
    await Sentry.configureScope((scope) {
      scope.setUser(null);
    });
  }

  @override
  Future<void> captureException(
    Object exception, {
    StackTrace? stackTrace,
    String? context,
  }) async {
    log(
      'Error captured: $exception',
      name: 'ErrorTracking',
      error: exception,
      stackTrace: stackTrace,
    );

    if (kDebugMode) return;

    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      withScope: context != null
          ? (scope) => scope.setTag('context', context)
          : null,
    );
  }

  @override
  Future<void> captureMessage(String message, {ErrorLevel? level}) async {
    log('Message: $message', name: 'ErrorTracking');

    if (kDebugMode) return;

    await Sentry.captureMessage(message, level: _toSentryLevel(level));
  }

  @override
  Future<void> addBreadcrumb({
    required String message,
    String? category,
    Map<String, dynamic>? data,
  }) async {
    await Sentry.addBreadcrumb(Breadcrumb(
      message: message,
      category: category,
      data: data,
      timestamp: DateTime.now(),
    ));
  }

  SentryLevel? _toSentryLevel(ErrorLevel? level) {
    if (level == null) return null;
    switch (level) {
      case ErrorLevel.debug:
        return SentryLevel.debug;
      case ErrorLevel.info:
        return SentryLevel.info;
      case ErrorLevel.warning:
        return SentryLevel.warning;
      case ErrorLevel.error:
        return SentryLevel.error;
      case ErrorLevel.fatal:
        return SentryLevel.fatal;
    }
  }
}
