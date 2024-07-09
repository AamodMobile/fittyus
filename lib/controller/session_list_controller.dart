import 'dart:convert';

import 'package:fittyus/model/session_list_model.dart';
import 'package:fittyus/screens/check_out_screen.dart';
import '../constants/constants.dart';
import '../services/api_services.dart';

class SessionListController extends GetxController implements GetxService {
  var sessionList = <SessionListModel>[].obs;
  bool isLoading = false;

  Future<void> sessionListApi(String date, String city) async {
    isLoading = true;
    try {
      var result = await ApiServices.sessionList(date, city);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isLoading = false;
        sessionList.value = List<SessionListModel>.from(json['data'].map((i) => SessionListModel.fromJson(i))).toList(growable: true);
      } else {
        isLoading = false;
        errorToast(json["message"].toString());
      }
    } catch (e) {
      isLoading = false;
      errorToast(e.toString());
    }
    update();
  }

  Future<void> addToCardPlan(String coachId, String packageId, String sessionId, String sessionType, String timeSlot) async {
    try {
      showProgress();
      var result = await ApiServices.addCard(coachId, packageId, sessionId, sessionType, timeSlot);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isLoading = false;
        closeProgress();
        await Future.delayed(const Duration(seconds: 1)).then((value) {
          Get.to(
            () => CheckOutScreen(
              coachId: coachId,
              packageId: packageId,
              sessionId: sessionId,
              sessionType: sessionType,
            ),
          );
        });
      } else {
        closeProgress();
        errorToast(json["msg"].toString());
        isLoading = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading = false;
      closeProgress();
    }
    update();
  }
}
