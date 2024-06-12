import 'dart:convert';

import 'package:fittyus/model/coach_model.dart';
import '../constants/constants.dart';
import '../services/api_services.dart';

class CoachListController extends GetxController implements GetxService {
  var teacherList = <CoachList>[].obs;
  bool isLoading = true;

  Future<void> getCoachListApi(String categoryId,String city) async {
    try {
      var result = await ApiServices.coachList(categoryId,city);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
       // successToast(json["message"].toString());
        teacherList.value =
            List<CoachList>.from(json['data'].map((i) => CoachList.fromJson(i)))
                .toList(growable: true);
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
