import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/screens/no_internet_screen.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetCheck extends GetxController {
  Rx<bool> isDeviceConnected = false.obs;
  Rx<bool> isAlertSet = false.obs;
  Rx<bool> isOnline = false.obs;
  Widget? widget;

  late StreamSubscription streamSubscription;

  void getConnected() => streamSubscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected.value =
            await InternetConnectionChecker().hasConnection;
        try {
          Log.console("Checking internet connection:${isDeviceConnected.value}");
          if (isDeviceConnected.value == false) {
            isOnline.value = false;
            Get.to(() => const NoInterNetScreen());
            Log.console("No internet connection");
          } else {
            InternetConnectionChecker().hasConnection;
            //Get.to(() => const SplashScreen());
            Log.console("Yes internet connection");
            Timer(const Duration(seconds: 2), () {
              isOnline.value = true;
              Log.console("is working");
              Log.console(isOnline.value);
            });
          }
        } catch (e) {
          Log.console("Exception internet connection:$e");
        }
      });
}
