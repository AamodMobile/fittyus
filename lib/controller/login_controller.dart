import 'dart:convert';
import 'package:fittyus/screens/otp_screen.dart';
import '../constants/constants.dart';
import '../model/login_model.dart';
import '../services/api_services.dart';

class LoginController extends GetxController implements GetxService {
  var emailFocusNode = FocusNode().obs;
  var mobileFocusNode = FocusNode().obs;
  var selectedCode = "+91".obs;
  var isLoginUsingPhoneNumber = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> loginWithMobile() async {
    try {
      showProgress();
      var result = await ApiServices.loginMobileApi(
        mobile.text,
        selectedCode.value,
      );
      var json = jsonDecode(result.body);
      final apiResponse = LoginResponseModel.fromJson(json);
      if (apiResponse.status == true) {
        closeProgress();
        successToast(apiResponse.msg.toString());
        await Future.delayed(const Duration(seconds: 2)).then(
          (value) {
            Get.to(
              () => OTPScreen(
                phone: mobile.text,
                countryCode: selectedCode.value,
                email: "",
              ),
            );
          },
        );
      } else {
        closeProgress();
        errorToast(apiResponse.msg.toString());
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
    }
  }

  Future<void> loginWithEmail() async {
    try {
      showProgress();
      var result = await ApiServices.loginEmailApi(email.text);
      var json = jsonDecode(result.body);
      final apiResponse = LoginResponseModel.fromJson(json);
      if (apiResponse.status == true) {
        closeProgress();
        successToast(apiResponse.msg.toString());
        await Future.delayed(const Duration(seconds: 2)).then((value) {
          Get.to(
            () => OTPScreen(
              email: email.text,
              phone: "",
              countryCode: "",
            ),
          );
        });
      } else {
        closeProgress();
        errorToast(apiResponse.msg.toString());
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
    }
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }
}
