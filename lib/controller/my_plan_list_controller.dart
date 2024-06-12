import 'dart:convert';
import 'package:fittyus/model/my_plan_list_model.dart';
import '../constants/constants.dart';
import '../services/api_services.dart';

class MyPlanListController extends GetxController implements GetxService {
  var myPlanList = <MyPlanListModel>[].obs;
  bool isLoading = true;

  Future<void> myPlanListApi() async {
    try {
      var result = await ApiServices.myPlanList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        myPlanList.value = List<MyPlanListModel>.from(
                json['data'].map((i) => MyPlanListModel.fromJson(i)))
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
