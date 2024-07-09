import 'dart:convert';

import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/model/challenge_list_model.dart';
import 'package:fittyus/model/coach_model.dart';
import 'package:fittyus/model/home_model.dart';
import 'package:fittyus/model/session_list_model.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:fittyus/services/api_services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UserSearchController extends GetxController implements GetxService {
  var categoryList = <Category>[].obs;
  var allChallengeList = <ChallengeListModel>[].obs;
  var sessionList = <SessionListModel>[].obs;
  var teacherList = <CoachList>[].obs;
  var usersList = <UserNewModel>[].obs;
  bool isLoading = false;
  bool isData = false;
  String? currentAddress;
  Position? _currentPosition;
  var pincode = "".obs;
  var city = "".obs;
  String sss = "";
  var id = "".obs;

  UserSearchController() {
    ever(city, (_) => searchApi('',false));
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
      Log.console('Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Log.console('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Log.console('Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
      pincode.value = '${place.postalCode}';
      city.value = '${place.locality}';
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> searchApi(String search, bool isShow) async {
    try {
      isLoading = true;
      var cityget = city.value;
      if (cityget.isEmpty) {
        getCurrentPosition();
        isLoading = true;
        update();
        return;
      }
      var result = await ApiServices.search(search, cityget);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isData = true;
        successToast(json["message"].toString());
        categoryList.value = List<Category>.from(json['category'].map((i) => Category.fromJson(i))).toList(growable: true);
        allChallengeList.value = List<ChallengeListModel>.from(json['challange_list'].map((i) => ChallengeListModel.fromJson(i))).toList(growable: true);
        sessionList.value = List<SessionListModel>.from(json['session_list'].map((i) => SessionListModel.fromJson(i))).toList(growable: true);
        teacherList.value = List<CoachList>.from(json['coach_list'].map((i) => CoachList.fromJson(i))).toList(growable: true);
        usersList.value = List<UserNewModel>.from(json['users_list'].map((i) => UserNewModel.fromJson(i))).toList(growable: true);
        isLoading = false;
      } else {
        if (isShow) {
          errorToast(json["message"].toString());
        }
        isLoading = false;
        isData = false;
      }
    } catch (e) {
      if (isShow) {
        errorToast(e.toString());
      }
      isLoading = false;
    }
    update();
  }
}

class UserNewModel {
  int id = 0;
  String firstName = "", lastName = "", gender = "", profileImage = "";

  UserNewModel(this.id, this.firstName, this.lastName, this.gender, this.profileImage);

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
