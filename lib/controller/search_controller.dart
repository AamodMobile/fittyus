import 'dart:convert';

import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/model/challenge_list_model.dart';
import 'package:fittyus/model/coach_model.dart';
import 'package:fittyus/model/home_model.dart';
import 'package:fittyus/model/session_list_model.dart';
import 'package:fittyus/model/user_model.dart';
import 'package:fittyus/services/api_services.dart';

class UserSearchController extends GetxController implements GetxService {
  var categoryList = <Category>[].obs;
  var allChallengeList = <ChallengeListModel>[].obs;
  var sessionList = <SessionListModel>[].obs;
  var teacherList = <CoachList>[].obs;
  var usersList = <UserNewModel>[].obs;
  bool isLoading = false;
  bool isData = false;

  Future<void> searchApi(String search) async {
    try {
      isLoading = true;
      var result = await ApiServices.search(search);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isData = true;
        successToast(json["message"].toString());
        categoryList.value = List<Category>.from(
                json['category'].map((i) => Category.fromJson(i)))
            .toList(growable: true);
        allChallengeList.value = List<ChallengeListModel>.from(
                json['challange_list']
                    .map((i) => ChallengeListModel.fromJson(i)))
            .toList(growable: true);
        sessionList.value = List<SessionListModel>.from(
                json['session_list'].map((i) => SessionListModel.fromJson(i)))
            .toList(growable: true);
        teacherList.value = List<CoachList>.from(
                json['coach_list'].map((i) => CoachList.fromJson(i)))
            .toList(growable: true);
        usersList.value = List<UserNewModel>.from(
            json['users_list'].map((i) => UserNewModel.fromJson(i)))
            .toList(growable: true);
        isLoading = false;

      } else {
        errorToast(json["message"].toString());
        isLoading = false;
        isData = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading = false;
    }
    update();
  }
}
class UserNewModel {
  int id = 0;
  String firstName = "",
      lastName = "",
      gender = "",
      profileImage = "";

  UserNewModel(
      this.id,
      this.firstName,
      this.lastName,
      this.gender,
      this.profileImage,
      );

  UserNewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'] ?? '';
    lastName = json['last_name'] ?? '';
    gender = json['gender'] ?? '';
    profileImage = json['profile_image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['profile_image'] = profileImage;
    return data;
  }
}
