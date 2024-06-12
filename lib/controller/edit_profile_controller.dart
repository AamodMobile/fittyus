// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_services.dart';

class EditProfileController extends GetxController implements GetxService {
  Rx<File> image = File("").obs;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController occupation = TextEditingController();
  bool isLoading = true;
  var radioButtonItem = "".obs;
  var gender;
  UserController user = Get.find<UserController>();

  Future<void> editProfileApi() async {
    try {
      showProgress();
      var response = await ApiServices.editProfile(
          firstName.text.toString(),
          lastName.text.toString(),
          email.text.toString(),
          mobile.text.toString(),
          country.text.toString(),
          state.text.toString(),
          city.text.toString(),
          address.text.toString(),
          radioButtonItem.toString(),
          occupation.text.toString(),
          image != null ? image.value.path : "");
      if (response['status'] == true) {
        closeProgress();
        user.getProfile();
        Get.back();
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

  void pickImage(BuildContext context) async {
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
      image.value = File(file!.path);
    }
  }
}
