import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../push_service.dart';

class FcmPushService implements PushService {
  FcmPushService(this._client);
  final SupabaseClient _client;

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  StreamSubscription<String>? _tokenRefreshSubscription;
  String? _currentToken;

  String get _userId => _client.auth.currentUser!.id;

  @override
  Future<void> initialize({
    required void Function(Map<String, dynamic> data) onNotificationTapped,
  }) async {
    // Request iOS permissions
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications for foreground display
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    await _localNotifications.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          try {
            final data = jsonDecode(response.payload!) as Map<String, dynamic>;
            onNotificationTapped(data);
          } catch (_) {}
        }
      },
    );

    // Get and save FCM token
    _currentToken = await _messaging.getToken();
    if (_currentToken != null) {
      await _saveToken(_currentToken!);
    }

    // Listen for token refresh
    _tokenRefreshSubscription =
        _messaging.onTokenRefresh.listen((newToken) async {
      if (_currentToken != null) {
        await _removeToken(_currentToken!);
      }
      _currentToken = newToken;
      await _saveToken(newToken);
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      _showLocalNotification(message);
    });

    // Handle notification tap when app was in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data.isNotEmpty) {
        onNotificationTapped(message.data);
      }
    });

    // Handle notification tap that launched the app
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null && initialMessage.data.isNotEmpty) {
      onNotificationTapped(initialMessage.data);
    }
  }

  @override
  Future<void> removeTokens() async {
    if (_currentToken != null) {
      await _removeToken(_currentToken!);
      _currentToken = null;
    }
  }

  @override
  void dispose() {
    _tokenRefreshSubscription?.cancel();
  }

  Future<void> _saveToken(String token) async {
    await _client.from('device_tokens').upsert({
      'player_id': _userId,
      'token': token,
      'platform': _getPlatform(),
    });
  }

  Future<void> _removeToken(String token) async {
    await _client
        .from('device_tokens')
        .delete()
        .eq('player_id', _userId)
        .eq('token', token);
  }

  String _getPlatform() {
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    return 'unknown';
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'endstream_game',
      'Game Notifications',
      channelDescription: 'Notifications for game turns and events',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'EndStream',
      message.notification?.body,
      details,
      payload: jsonEncode(message.data),
    );
  }
}
