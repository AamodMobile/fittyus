// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/model/otp_model.dart';
import 'package:fittyus/screens/dashboard_screenn.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:fittyus/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPController extends GetxController implements GetxService {
  var focusNode = FocusNode().obs;
  TextEditingController otp = TextEditingController();
  var userData = OTPModel().obs;
  var logindata;
  var crtData;

  @override
  void onInit() {
    // getUser();
    super.onInit();
  }

  Future<void> otpVerifyWithMobile(String mobile, String code) async {
    try {
      showProgress();
      var result = await ApiServices.otpVerifyByMobileApi(
        otp.text,
        mobile,
        code,
      );
      var json = jsonDecode(result.body);
      final apiResponse = OTPModel.fromJson(json);
      Log.console("/////${json["user"]}");
      if (json["status"] == true) {
        closeProgress();
        var pref = await SharedPreferences.getInstance();
        User? userVal = apiResponse.users;
        await pref.setString(
            'currentToken', apiResponse.accessToken.toString());
        await pref.setString(
          'currentUser',
          jsonEncode(userVal?.toJson()),
        );
        successToast(json["msg"].toString());
        await Future.delayed(const Duration(seconds: 3)).then((value) {
          Get.offAll(() => const DashBoardScreen(
                index: 0,
              ));
        });
      } else {
        closeProgress();
        errorToast(json["msg"].toString());
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
    }
  }

  Future<void> otpVerifyWithEmail(String email) async {
    try {
      showProgress();
      var result = await ApiServices.otpVerifyByEmailApi(otp.text, email);
      var json = jsonDecode(result.body);
      final apiResponse = OTPModel.fromJson(json);
      Log.console("/////$apiResponse");
      if (json["status"] == true) {
        closeProgress();
        var pref = await SharedPreferences.getInstance();
        OTPModel userVal = apiResponse;
        await pref.setString(
            'currentToken', apiResponse.accessToken.toString());
        await pref.setString(
          'currentUser',
          jsonEncode(userVal.toJson()),
        );
        successToast(json["msg"].toString());
        await Future.delayed(const Duration(seconds: 3)).then((value) {
          Get.offAll(() => const DashBoardScreen(
                index: 0,
              ));
        });
      } else {
        closeProgress();
        errorToast(json["msg"].toString());
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
    }
  }

  getUser() async {
    logindata = await SharedPreferences.getInstance();
    crtData = logindata.getString('currentUser');
    Log.console("crtData: $crtData");
    OTPModel crtUser = OTPModel.fromJson(jsonDecode(crtData));
    userData.value = crtUser;
    Log.console("User data: ${userData.value}"); // Check if the user data is updated
    update();
  }
}
