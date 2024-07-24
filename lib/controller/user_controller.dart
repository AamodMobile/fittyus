// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/model/view_profile_model.dart';
import 'package:fittyus/screens/login_screen.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../services/api_services.dart';

class UserController extends GetxController {
  var user = UserModel(0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', "").obs;
  var viewProfileModel = ViewProfileModel().obs;
  var loginData;
  var crtData;
  var userRole;
  bool isLoading = false;
  Rx<File> image = File("").obs;
  Rx<File> backCover = File("").obs;

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  getUser() async {
    loginData = await SharedPreferences.getInstance();
    crtData = loginData.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData));
    user.value = crtUser;
    update();
  }

  void getProfile() async {
    try {
      var response = await ApiServices.userDetails();
      var result = jsonDecode(response.body);
      if (result['status'] == true) {
        UserModel userModel = UserModel.fromJson(result['data']);
        user.value = userModel;
        var pref = await SharedPreferences.getInstance();
        await pref.setString(
          'currentUser',
          jsonEncode(userModel.toJson()),
        );
      } else {
        // closeProgress();
        // errorToast(result['message']);
      }
    } catch (_) {}
    update();
  }

  void deleteAccount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      showProgress();
      var response = await ApiServices.deleteAccount();
      var result = jsonDecode(response.body);
      if (result['status'] == true) {
        closeProgress();
        errorToast(result['message'].toString());
        await preferences.clear();
        await Future.delayed(const Duration(seconds: 2)).then((value) async {
          Get.back();
          Get.offAll(() => const LoginScreen());
        });
      } else {
        closeProgress();
        errorToast(result['message']);
      }
    } catch (_) {
      closeProgress();
    }
  }

  Future<void> viewProfile(String id, bool loading) async {
    try {
      isLoading = loading;
      var result = await ApiServices.viewProfile(id);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        ViewProfileModel model = ViewProfileModel.fromJson(json['data']);
        viewProfileModel.value = model;
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

  Future<void> followAndUnfollow(String id) async {
    try {
      var result = await ApiServices.followAndUnfollow(id);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        successToast(json["message"].toString());
      } else {
        errorToast(json["message"].toString());
      }
    } catch (e) {
      errorToast(e.toString());
    }
    update();
  }

  Future<void> backOverOrEditProfile(String id) async {
    try {
      showProgress();
      var response = await ApiServices.backOverAndProfileUpdate(image != null ? image.value.path : "", backCover != null ? backCover.value.path : "");
      if (response['status'] == true) {
        closeProgress();
        getProfile();
        viewProfile(id, false);
        successToast(response['message'].toString());
      } else {
        closeProgress();
        errorToast(response['message'].toString());
      }
    } catch (e) {
      Log.console(e.toString());
      closeProgress();
      errorToast(e.toString());
    }
    update();
  }

  void pickImage(BuildContext context, String type, String id) async {
    var source = await imagePickerSheet(context);
    if (source != null) {
      // ignore: invalid_use_of_visible_for_testing_member
      var picker = ImagePicker.platform;
      // ignore: deprecated_member_use
      var file = await picker.pickImage(
        source: source,
        maxHeight: 1080,
        maxWidth: 1080,
        imageQuality: 90,
      );
      if (type == "profile") {
        image.value = File(file!.path);
        backOverOrEditProfile(id);
      } else {
        backCover.value = File(file!.path);
        backOverOrEditProfile(id);
      }
    }
  }

  Future<ImageSource?> imagePickerSheet(context) async {
    ImageSource? source = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            color: Colors.white,
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_rounded,
                          color: pGreen,
                          size: 40,
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(color: pGreen),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Icon(
                          Icons.photo_rounded,
                          color: pGreen,
                          size: 40,
                        ),
                        Text('Gallery', style: TextStyle(color: pGreen)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
    return source;
  }
}
