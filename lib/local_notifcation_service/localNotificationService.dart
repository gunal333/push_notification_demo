import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin(); 

   static void initialize() {
    // Initialization  setting for android
    const InitializationSettings initializationSettingsAndroid = InitializationSettings(android: AndroidInitializationSettings('emperia_logo', ));
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification 
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
  }   

  static Future<void> display(RemoteMessage message) async {
    // To display the notification in device
    try {
      print(message.notification!.android!.sound);
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            message.notification!.android!.sound ?? "Channel Id",
            message.notification!.android!.sound ?? "Main Channel",
            playSound: true,
            priority: Priority.high),
      );
      await _notificationsPlugin.show(id, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: message.data['route']);
    } catch (e) {
      debugPrint(e.toString());
    }
}
}