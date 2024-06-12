import 'dart:convert';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/model/coach_model.dart';
import 'package:fittyus/model/plan_details_model.dart';
import 'package:fittyus/screens/check_out_screen.dart';
import 'package:fittyus/services/api_services.dart';

class CoachPlansDetailsController extends GetxController
    implements GetxService {
  var plansList = <PlanList>[].obs;
  var coachDetails = CoachPlansDetailsModel(planList: [], coach: CoachList()).obs;
  var coach = CoachList().obs;
  bool isLoading = true;

  Future<void> getCoachPlanDetailsListApi(String coachId) async {
    try {
      plansList.clear();
      var result = await ApiServices.coachPlansDetails(coachId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        CoachPlansDetailsModel model = CoachPlansDetailsModel.fromJson(json['coachList']);
        coachDetails.value = model;
        plansList.value = coachDetails.value.planList;
        coach.value = coachDetails.value.coach;
        isLoading = false;
      } else {
        errorToast(json["message"].toString());
        isLoading = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading = false;
    }
    update();
  }

  Future<void> addToCardPlan(String coachId, String packageId,String sessionId,String sessionType,String timeslot) async {
    try {
      showProgress();
      var result = await ApiServices.addCard(coachId, packageId,sessionId,sessionType,timeslot);
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
