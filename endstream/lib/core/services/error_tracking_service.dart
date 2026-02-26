import '../models/error_level.dart';

export '../models/error_level.dart';

/// Abstract interface for crash reporting and error tracking.
abstract class ErrorTrackingService {
  /// Set the current user identity for error context.
  Future<void> setUser({required String id, String? displayName});

  /// Clear user identity (on sign-out).
  Future<void> clearUser();

  /// Capture a non-fatal exception with optional stack trace and context.
  Future<void> captureException(
    Object exception, {
    StackTrace? stackTrace,
    String? context,
  });

  /// Capture a message-level event (non-exception).
  Future<void> captureMessage(String message, {ErrorLevel? level});

  /// Add a breadcrumb for debugging context leading up to an error.
  Future<void> addBreadcrumb({
    required String message,
    String? category,
    Map<String, dynamic>? data,
  });
}
