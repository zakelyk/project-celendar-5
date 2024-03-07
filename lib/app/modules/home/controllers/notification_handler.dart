import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Message received in background: ${message.notification?.title}');
}
class FirebaseMessagingHandler {
  final _androidChannel = const AndroidNotificationChannel("channel_notification", "High Importance Notification", description: "Used Fot Notification", importance: Importance.defaultImportance,);
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();
  Future<void> initPushNotification() async {
//allow user to give permission for notification
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
//get token messaging
    _firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
    });
//handler terminated message
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("terminatedNotification : ${message!.notification?.title}");
    });
//handler onbackground message
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      if(notification == null)return;
      _localNotification.show(notification.hashCode, notification.title, notification.body, NotificationDetails(android: AndroidNotificationDetails(_androidChannel.id,_androidChannel.name, channelDescription: _androidChannel.description, icon: '@drawable?ic_launcher')),payload: jsonEncode(event.toMap()));
      print("Message rechaived while app is in foreground: ${event.notification?.title}");
    });

  }
  Future initLocalNotification()async{
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: ios);
    await _localNotification.initialize(settings);
  }
}