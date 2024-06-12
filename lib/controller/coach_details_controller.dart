import 'dart:convert';
import 'package:fittyus/model/coach_details_model.dart';
import '../constants/constants.dart';
import '../services/api_services.dart';

class CoachDetailsController extends GetxController implements GetxService {
  var coachDetails = CoachDetailsModel(feedbackList: []).obs;
  var imageList = <CoachMedia>[].obs;
  var videoList = <CoachMedia>[].obs;
  bool isLoading = true;

  Future<void> getCoachDetailsApi(String coachId) async {
    try {
      imageList.clear();
      videoList.clear();
      var result = await ApiServices.coachDetails(coachId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        CoachDetailsModel model = CoachDetailsModel.fromJson(json['data']);
        coachDetails.value = model;
        for (int i = 0; i < coachDetails.value.coachMedia!.length; i++) {
          if (coachDetails.value.coachMedia?[i].fileType == "image") {
            imageList.add(coachDetails.value.coachMedia![i]);
          } else if (coachDetails.value.coachMedia?[i].fileType  == "video") {
            videoList.add(coachDetails.value.coachMedia![i]);
          }
        }
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
}
