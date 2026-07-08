import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/data/provider/firebase/firestore_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class PushNotificationService extends GetxService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();
  final FirestoreService _firestore = FirestoreService();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'bloodbeacon_alerts',
    'BloodBeacon Alerts',
    description: 'Emergency blood requests and updates',
    importance: Importance.high,
  );

  Future<void> init() async {
    try {
      await _messaging.requestPermission(alert: true, badge: true, sound: true);

      const androidInit =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosInit = DarwinInitializationSettings();
      await _local.initialize(
        settings:
            const InitializationSettings(android: androidInit, iOS: iosInit),
      );
      await _local
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessage.listen(_showLocal);
    } catch (e) {
      log('Push init skipped: $e');
    }
  }

  Future<void> registerToken(String uid) async {
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        await _firestore.updateUser(uid, {'fcmToken': token});
      }
      _messaging.onTokenRefresh.listen((t) {
        _firestore.updateUser(uid, {'fcmToken': t});
      });
    } catch (e) {
      log('Token registration skipped: $e');
    }
  }

  void _showLocal(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;
    _local.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }
}
