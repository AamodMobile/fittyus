import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fittyus/helper/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationListenerProvider {
  // final _firebaseMessaging = FirebaseMessaging.instance.getInitialMessage();

  void getMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      RemoteNotification notification = event.notification!;

      // AppleNotification apple = event.notification!.apple!;
      AndroidNotification androidNotification = event.notification!.android!;
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      if (notification != null && androidNotification != null) {
        NotificationService.showNotification(
            title: notification.title.toString(),
            body: notification.body.toString(),
            fln: flutterLocalNotificationsPlugin);

        ///Show local notification
        // sendNotification(title: notification.title!, body: notification.body);

        ///Show Alert dialog
        // showDialog(
        //     context: context,
        //     builder: (context) {
        //       return AlertDialog(
        //         title: Text(notification.title!),
        //         content: Text(notification.body!),
        //       );
        //     });
      }
    });
  }

  void getBackGroundMessage() {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );
  }
}
