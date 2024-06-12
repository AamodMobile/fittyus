import 'dart:convert';

import 'package:fittyus/model/my_session_list_model.dart';

import '../constants/constants.dart';
import '../services/api_services.dart';

class MySessionListController extends GetxController implements GetxService {
  var mySessionList = <MySessionListModel>[].obs;
  bool isLoading = true;

  Future<void> mySessionListApi() async {
    try {
      var result = await ApiServices.mySessionList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        mySessionList.value = List<MySessionListModel>.from(
                json['data']["category"].map((i) => MySessionListModel.fromJson(i)))
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
