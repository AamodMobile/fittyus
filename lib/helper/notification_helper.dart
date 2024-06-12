import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize notification
  initializeNotification() async {
    _configureLocalTimeZone();
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("launch_background");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /// Set right date and time for notifications
  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
   // final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    //tz.setLocalLocation(tz.getLocation(timeZone));
  }

  /// Scheduled Notification
  scheduledNotification(
      {required int hour,
      required int minutes,
      required int id,
      String? message}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      message,
      'Stay hydrated and stay healthy',
      _convertTime(hour, minutes),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'ekam_yoga_notification_ey_bg',
          'channel_name_ekam_yoga',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'It could be anything you pass',
    );
    log("notification helper");
  }

  /// Request IOS permissions
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // void scheduleNotifications(
  //     DateTime startDate, DateTime endDate, List<String?> timeList) {
  //   for (final time in timeList) {
  //     for (var date = startDate;
  //         date.isBefore(endDate);
  //         date = date.add(Duration(days: 1))) {
  //       final notificationTime =
  //           DateTime(date.year, date.month, date.day, time.hour, time.minute);

  //       if (notificationTime.isAfter(DateTime.now())) {
  //         flutterLocalNotificationsPlugin.zonedSchedule(
  //           0, // notification ID
  //           'Notification Title', // notification title
  //           'Notification Body', // notification body
  //           tz.TZDateTime.from(
  //               notificationTime, tz.local), // notification date and time
  //           const NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               'ekam_yoga_notification_ey_bg',
  //               'channel_name_ekam_yoga',
  //               importance: Importance.max,
  //               priority: Priority.high,
  //             ),
  //           ),
  //           androidAllowWhileIdle: true,
  //           uiLocalNotificationDateInterpretation:
  //               UILocalNotificationDateInterpretation.absoluteTime,
  //         );
  //       }
  //     }
  //   }
  // }

  cancelAll() async => await flutterLocalNotificationsPlugin.cancelAll();
  cancel(id) async => await flutterLocalNotificationsPlugin.cancel(id);
}
