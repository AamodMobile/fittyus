import 'dart:convert';
import 'package:fittyus/model/home_model.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../constants/constants.dart';
import '../services/api_services.dart';

class CategoryListController extends GetxController implements GetxService {
  var categoryList = <Category>[].obs;
  bool isLoading = true;
  String? currentAddress;
  Position? _currentPosition;
  String? lat;
  String? long;
  var pincode = "".obs;
  var city = "".obs;
  String sss = "";
  var id = "".obs;
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
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress =
      '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
      pincode.value = '${place.postalCode}';
      city.value = '${place.locality}';
    }).catchError((e) {
      debugPrint(e);
    });
  }
  Future<void> getCategoryListApi() async {
    try {
      var result = await ApiServices.categoryList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        //successToast(json["message"].toString());
        categoryList.value = List<Category>.from(json['data'].map((i) => Category.fromJson(i))).toList(growable: true);
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
