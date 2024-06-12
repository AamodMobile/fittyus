import 'dart:convert';
import 'package:fittyus/model/my_rating_list_model.dart';
import '../constants/constants.dart';
import '../services/api_services.dart';

class MyRatingListController extends GetxController implements GetxService {
  var myRatingList = <MyRatingListModel>[].obs;
  bool isLoading = true;


  Future<void> myRatingListApi() async {
    try {
      var result = await ApiServices.myRatingList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        myRatingList.value = List<MyRatingListModel>.from(
                json['data'].map((i) => MyRatingListModel.fromJson(i)))
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
