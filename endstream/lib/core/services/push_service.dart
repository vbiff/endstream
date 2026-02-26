/// Abstract interface for push notification operations.
abstract class PushService {
  /// Initialize push notification infrastructure.
  Future<void> initialize({
    required void Function(Map<String, dynamic> data) onNotificationTapped,
  });

  /// Remove all device tokens for the current user.
  Future<void> removeTokens();

  /// Cancel subscriptions and release resources.
  void dispose();
}
