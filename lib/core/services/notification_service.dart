import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medico24/core/api/services/notification_api_service.dart';

/// Background message handler - must be a top-level function
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling background message: ${message.messageId}');
  debugPrint('Message data: ${message.data}');
  debugPrint('Message notification: ${message.notification?.title}');
}

/// Service for managing push notifications
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  final NotificationApiService _apiService = NotificationApiService();

  String? _fcmToken;
  bool _isInitialized = false;

  /// Get the current FCM token
  String? get fcmToken => _fcmToken;

  /// Initialize Firebase Cloud Messaging
  Future<void> initialize() async {
    if (_isInitialized) {
      debugPrint('NotificationService already initialized');
      return;
    }

    try {
      // Request notification permissions
      await _requestPermissions();

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Get FCM token
      await _getFCMToken();

      // Set up foreground message handler
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Set up background message handler
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // Handle notification taps when app is in background/terminated
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

      // Check if app was opened from a notification
      final initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        _handleMessageOpenedApp(initialMessage);
      }

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen(_handleTokenRefresh);

      _isInitialized = true;
      debugPrint('NotificationService initialized successfully');
    } catch (e) {
      debugPrint('Error initializing NotificationService: $e');
    }
  }

  /// Request notification permissions
  Future<void> _requestPermissions() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint(
      'Notification permission status: ${settings.authorizationStatus}',
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted notification permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional notification permission');
    } else {
      debugPrint('User declined notification permission');
    }
  }

  /// Initialize local notifications for foreground display
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@drawable/ic_notification',
    );

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _handleNotificationTap,
    );

    // Create Android notification channel matching AndroidManifest
    if (Platform.isAndroid) {
      const channel = AndroidNotificationChannel(
        'medico24_notifications', // id matching AndroidManifest
        'Medico24 Notifications', // name
        description: 'Appointment and health notifications from Medico24',
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);
    }
  }

  /// Get FCM token and register with backend
  Future<void> _getFCMToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      debugPrint('FCM Token: $_fcmToken');

      if (_fcmToken != null) {
        await registerTokenWithBackend(_fcmToken!);
      }
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
    }
  }

  /// Register FCM token with backend
  Future<void> registerTokenWithBackend(String token) async {
    try {
      final platform = Platform.isAndroid
          ? 'android'
          : Platform.isIOS
          ? 'ios'
          : 'web';

      await _apiService.registerToken(token, platform);
      debugPrint('FCM token registered with backend');
    } catch (e) {
      debugPrint('Error registering FCM token with backend: $e');
    }
  }

  /// Handle token refresh
  Future<void> _handleTokenRefresh(String newToken) async {
    debugPrint('FCM token refreshed: $newToken');
    _fcmToken = newToken;
    await registerTokenWithBackend(newToken);
  }

  /// Handle foreground messages (show notification)
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('Foreground message received: ${message.messageId}');
    debugPrint('Message data: ${message.data}');

    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null) {
      await _showLocalNotification(
        title: notification.title ?? 'Notification',
        body: notification.body ?? '',
        payload: message.data.toString(),
      );
    }
  }

  /// Show local notification
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'medico24_notifications', // matching AndroidManifest and channel
      'Medico24 Notifications',
      channelDescription: 'Appointment and health notifications from Medico24',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@drawable/ic_notification', // Use custom notification icon
      color: Color(0xFF00BCD4), // Teal color matching colors.xml
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload,
    );
  }

  /// Handle notification tap (from local notification)
  void _handleNotificationTap(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    _navigateFromNotification(response.payload);
  }

  /// Handle message opened app (from FCM)
  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('Message opened app: ${message.messageId}');
    debugPrint('Message data: ${message.data}');
    _navigateFromData(message.data);
  }

  /// Navigate based on notification payload
  void _navigateFromNotification(String? payload) {
    if (payload == null) return;

    try {
      // Parse payload and navigate
      // Example: {"screen": "/appointments/123"}
      debugPrint('Navigating from payload: $payload');
      // TODO: Implement navigation based on payload
    } catch (e) {
      debugPrint('Error parsing notification payload: $e');
    }
  }

  /// Navigate based on FCM data
  void _navigateFromData(Map<String, dynamic> data) {
    final screen = data['screen'] as String?;
    final appointmentId = data['appointment_id'] as String?;
    final type = data['type'] as String?;

    debugPrint('Navigating from FCM data - Type: $type, Screen: $screen');

    if (screen != null) {
      // Use navigation service or router to navigate
      // For example: AppRouter.router.push(screen);
      // TODO: Implement navigation with your router
      debugPrint('Should navigate to: $screen');
    } else if (appointmentId != null) {
      // Navigate to specific appointment
      final route = '/appointments/$appointmentId';
      debugPrint('Should navigate to: $route');
      // AppRouter.router.push(route);
    }
  }

  /// Deactivate FCM token (on logout)
  Future<void> deactivateToken() async {
    if (_fcmToken != null) {
      try {
        final platform = Platform.isAndroid
            ? 'android'
            : Platform.isIOS
            ? 'ios'
            : 'web';

        await _apiService.deactivateToken(_fcmToken!, platform);
        debugPrint('FCM token deactivated');
      } catch (e) {
        debugPrint('Error deactivating FCM token: $e');
      }
    }
  }

  /// Deactivate all tokens for current user
  Future<void> deactivateAllTokens() async {
    try {
      await _apiService.deactivateAllTokens();
      debugPrint('All FCM tokens deactivated');
    } catch (e) {
      debugPrint('Error deactivating all tokens: $e');
    }
  }

  /// Delete FCM token (complete cleanup)
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      _fcmToken = null;
      debugPrint('FCM token deleted');
    } catch (e) {
      debugPrint('Error deleting FCM token: $e');
    }
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint('Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('Error subscribing to topic: $e');
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      debugPrint('Unsubscribed from topic: $topic');
    } catch (e) {
      debugPrint('Error unsubscribing from topic: $e');
    }
  }
}
