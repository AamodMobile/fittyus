import 'package:fittyus/services/api_logs.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPluginObject =
      FlutterLocalNotificationsPlugin();

  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('launch_background');
    var initializationSettings = InitializationSettings(
        android: androidInitialize, iOS: null, macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //payload

  static Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse? payload) {
      // if (payload != null) OpenFile.open(payload);
          Log.console("ji");
      //if (payload != null) OpenFilex.open(payload.toString());
    });
  }

  //payload for download
  static Future showNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'ekam_yoga_notification_ey_bg',
      'channel_name_ekam_yoga',
      playSound: true,
      // sound: AndroidNotificationSound(),
      importance: Importance.max,
      priority: Priority.high,
    );

    var not = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: null);
    await fln.show(0, title, body, not, payload: payload);
  }
}
