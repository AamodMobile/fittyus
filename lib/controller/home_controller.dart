import 'dart:async';
import 'dart:convert';

import 'package:fittyus/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fittyus/model/home_model.dart';
import 'package:fittyus/services/api_services.dart';
import 'package:fittyus/services/api_logs.dart';

class HomeController extends GetxController implements GetxService {
  var bannerList = <Banners>[].obs;
  var teacherList = <TeacherList>[].obs;
  var categoryList = <Category>[].obs;
  var blogList = <Blog>[].obs;
  late StreamSubscription<ServiceStatus> streamSubscription;
  var services;
  List<bool> blogListIsLiked = [];
  bool isLoading = true;
  bool noData = false;
  String? currentAddress;
  Position? _currentPosition;
  var pincode = "".obs;
  var city = "".obs;
  String sss = "";
  var id = "".obs;
  int selectedIndex = 0;

  HomeController() {
    ever(city, (_) => getHomeApi());
  }

  void indexUpdate(int index) {
    selectedIndex = index;
    update();
  }

  Future<void> getHomeApi() async {
    try {
      isLoading = true;
      var cityget = city.value;
      if (cityget.isEmpty) {
        getCurrentPosition();
        isLoading = true;
        update();
        return;
      }
      var result = await ApiServices.getHomeApi(cityget);
      var json = jsonDecode(result.body);
      final apiResponse = HomeModel.fromJson(json);
      if (apiResponse.status == true) {
        bannerList.value = apiResponse.banner;
        teacherList.value = apiResponse.teacherList;
        categoryList.value = apiResponse.category;
        blogList.value = apiResponse.blog;
        isLoading = false;
      } else {
        errorToast(apiResponse.message.toString());
        isLoading = false;
        noData = true;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading = false;
      noData = true;
    }
    update();
  }

  Future<void> blogLike(String blogId, String type) async {
    try {
      var result = await ApiServices.blogLike(blogId, type);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        getHomeApi();
      } else {
        errorToast(json["message"].toString());
      }
    } catch (e) {
      Log.console(e.toString());
    }
  }

  Future<void> getCheckInStatus() async {
    try {
      final position = await LocationStatus().determinePosition();
      if (position.latitude != 0.0 && position.longitude != 0.0) {
        await getCurrentPosition();
      } else {
        errorToast('Location is not detected. Please check if location is enabled and try again.');
      }
    } catch (e) {
      errorToast(e.toString());
    }
  }

  Future<void> getCurrentPosition() async {
    try {
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
        _currentPosition = position;
        _getAddressFromLatLng(_currentPosition!);
      }).catchError((e) {
        debugPrint("$e");
      });
    } catch (e) {
      errorToast(e.toString());
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      await placemarkFromCoordinates(position.latitude, position.longitude).then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        currentAddress = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
        pincode.value = '${place.postalCode}';
        city.value = '${place.locality}';
        update();
      }).catchError((e) {
        debugPrint(e);
      });
    } catch (e) {
      errorToast(e.toString());
    }
  }
}

class LocationStatus {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Please enable your location, it seems to be turned off.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions. Please give permission and try again.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
  }
}

