import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/dasboard_controller.dart';
import 'package:fittyus/helper/notification_helper.dart';
import 'package:fittyus/helper/notification_listener_sevices.dart';
import 'package:fittyus/helper/notification_service.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DashBoardScreen extends StatefulWidget {
  final int index;
  const DashBoardScreen({super.key, required this.index});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DashboardController controller = Get.put(DashboardController());
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    updateFcm();
    NotificationListenerProvider().getMessage();
    NotificationListenerProvider().getBackGroundMessage();
    NotificationService.initialize(flutterLocalNotificationsPlugin);
    NotificationHelper().initializeNotification();
    controller.selectedIndex.value = widget.index;
    FirebaseMessaging.instance.getInitialMessage().then((message) {
        Log.console('FirebaseMessaging.instance.getInitialMessage');
        if (message != null) {
          Log.console('New Notification');
        }
      },
    );

    FirebaseMessaging.onMessage.listen((message) {
        Log.console('FirebaseMessaging.onMessage.listen');
        if (message.notification != null) {
          Log.console(message.notification!.title);
          Log.console(message.notification!.body);
          Log.console("message.data11 ${message.data}");
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
        Log.console("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          Log.console(message.notification!.title);
          Log.console(message.notification!.body);
          Log.console("message.data22 ${message.data['_id']}");
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [Obx(() => Expanded(child: controller.pages[controller.selectedIndex.value]))],
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, spreadRadius: 1)],
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => InkWell(
                onTap: () {
                  controller.selectedIndex.value = 0;
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      const AssetImage(homeIc),
                      size: 24,
                      color: controller.selectedIndex.value == 0 ? mainColor : lightGreyTxt,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        color: controller.selectedIndex.value == 0 ? mainColor : lightGreyTxt,
                        fontSize: Dimensions.font14 - 2,
                        fontFamily: semiBold,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(() => InkWell(
                onTap: () {
                  controller.selectedIndex.value = 1;
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      const AssetImage(accountIc),
                      size: 24,
                      color: controller.selectedIndex.value == 1 ? mainColor : lightGreyTxt,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                        color: controller.selectedIndex.value == 1 ? mainColor : lightGreyTxt,
                        fontSize: Dimensions.font14 - 2,
                        fontFamily: semiBold,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(() => InkWell(
                onTap: () {
                  controller.selectedIndex.value = 2;
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      const AssetImage(categoryIc),
                      size: 24,
                      color: controller.selectedIndex.value == 2 ? mainColor : lightGreyTxt,
                    ),
                    Text(
                      "Explore Video",
                      style: TextStyle(
                        color: controller.selectedIndex.value == 2 ? mainColor : lightGreyTxt,
                        fontSize: Dimensions.font14 - 2,
                        fontFamily: semiBold,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(() => InkWell(
                onTap: () {
                  controller.selectedIndex.value = 3;
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 24,
                      color: controller.selectedIndex.value == 3 ? mainColor : lightGreyTxt,
                    ),
                    Text(
                      "Session",
                      style: TextStyle(
                        color: controller.selectedIndex.value == 3 ? mainColor : lightGreyTxt,
                        fontSize: Dimensions.font14 - 2,
                        fontFamily: semiBold,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateFcm() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((token) async {
        if (token != null) {
          var fcmToken = token.toString();
          Log.console("fcm=$fcmToken");
          controller.updateFcmTokenApi(fcmToken);
        }
      },
    );
  }
}
