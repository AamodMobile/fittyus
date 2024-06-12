import 'dart:convert';

import 'package:fittyus/model/my_session_details_model.dart';

import '../constants/constants.dart';
import '../services/api_services.dart';

class MySessionDetailsController extends GetxController implements GetxService {
  var mySessionDetails = MySessionDetails().obs;
  bool isLoading = true;

  Future<void> mySessionDetailsApi(String sessionId) async {
    try {
      var result = await ApiServices.mySessionDetails(sessionId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        MySessionDetails model = MySessionDetails.fromJson(json['data']);
        mySessionDetails.value = model;
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
