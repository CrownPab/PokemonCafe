import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notification {
  BuildContext context;
  late FlutterLocalNotificationsPlugin notification;

  Notification(this.context) {
    tz.initializeTimeZones();
    initNotification();
  }

  //initialize notification
  initNotification() {
    notification = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings iOSInitializationSettings =
        IOSInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);

    notification.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future<String?> selectNotification(String? payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
              title: Text("Thank you."),
              content: Text("You will be notified when your order is ready"),
            ));
  }

  Future showScheduledNotification() async {
    try {
      var android = AndroidNotificationDetails("channelId", "channelName",
          channelDescription: "Your Order is Ready!",
          priority: Priority.high,
          importance: Importance.max);
      var platformDetails = NotificationDetails(android: android);
      await notification.zonedSchedule(
          101,
          "Your Order is Ready",
          "Pick up your order at the counter!",
          tz.TZDateTime.from(DateTime.now(), tz.local)
              .add(const Duration(minutes: 5)),
          platformDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true);
    } catch (e) {
      print(e);
    }
  }
}
