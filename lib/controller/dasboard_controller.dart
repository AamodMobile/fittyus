import 'dart:convert';

import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/screens/animation_video_screen.dart';
import 'package:fittyus/screens/diet_and_nutrituion.dart';
import 'package:fittyus/screens/home_screen.dart';
import 'package:fittyus/screens/training_session_screen.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:fittyus/services/api_services.dart';

import '../constants/constants.dart';

class DashboardController extends GetxController implements GetxService {
  RxInt selectedIndex = 0.obs;
  UserController user = Get.put(UserController());

  @override
  void onInit() {
    user.getProfile();
    super.onInit();
  }

  RxList pages = [const HomeScreen(), const DietAndNutritionScreen(), const AnimationVideoScreen(), const TrainingSessionScreen()].obs;

  Future<void> updateFcmTokenApi(String fcmToken) async {
    try {
      var result = await ApiServices.updateFcmToken(fcmToken);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        Log.console(json["message"].toString());
      } else {
        errorToast(json["message"].toString());
      }
    } catch (e) {
      errorToast(e.toString());
    }
    update();
  }
}
