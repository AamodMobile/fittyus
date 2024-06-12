// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'package:fittyus/model/home_model.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../constants/constants.dart';
import '../services/api_services.dart';

class HomeController extends GetxController implements GetxService {
  var bannerList = <Banners>[].obs;
  var teacherList = <TeacherList>[].obs;
  late StreamSubscription<ServiceStatus> streamSubscription;
  var services;
  List<bool> blogListIsLiked = [];
  var categoryList = <Category>[].obs;
  var blogList = <Blog>[].obs;
  bool isLoading = true;
  bool noData = false;
  String? currentAddress;
  Position? _currentPosition;
  String? lat;
  String? long;
  var pincode = "".obs;
  var city = "".obs;
  String sss = "";
  var id = "".obs;
  int selectedIndex = 0;

  void indexUpdate(int index) {
    selectedIndex = index;
    update();
  }

  Future<void> getHomeApi() async {
    try {
      var result = await ApiServices.getHomeApi();
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

  Future<bool> getCheckInStatus() async {
    try {
      final position = await LocationStatus().determinePosition();
      if (position.latitude != 0.0 && position.longitude != 0.0) {
        getCurrentPosition();
        return true;
      } else {
        Future.error('Location is not detected. Please check if location is enabled and try again.');
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await getCheckInStatus();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint("$e");
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
      pincode.value = '${place.postalCode}';
      city.value = '${place.locality}';
    }).catchError((e) {
      debugPrint(e);
    });
  }
}

class LocationStatus {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Please enable your location, it seems to be turned off.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions. Please give permission and try again.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
  }
}
