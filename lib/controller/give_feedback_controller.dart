import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/my_plan_list_controller.dart';
import 'package:fittyus/controller/my_session_list_controller.dart';
import 'package:fittyus/services/api_services.dart';
import 'package:image_picker/image_picker.dart';

class GiveFeedbackController extends GetxController implements GetxService {
  var feedbackImages = [].obs;
  final ImagePicker imagePicker = ImagePicker();
  var rating = "".obs;
  TextEditingController feedback = TextEditingController();
  final MyPlanListController _controller = Get.put(MyPlanListController());
  final MySessionListController _cont = Get.put(MySessionListController());

  Future<void> selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.length > 3) {
      errorToast("Max ScreenShot Image limit is 3");
    } else {
      if (selectedImages.isNotEmpty) {
        if (selectedImages.length + feedbackImages.length > 4) {
          errorToast("Max ScreenShot Image limit is 3");
        } else {
          feedbackImages.addAll(selectedImages);
        }
      }
    }
    update();
  }

  Future<void> giveFeedBack(String coachId) async {
    try {
      showProgress();
      var response = await ApiServices.giveFeedback(
        coachId,
        rating.value,
        feedback.text,
        feedbackImages,
      );
      if (response['status'] == true) {
        closeProgress();
        _controller.myPlanListApi();
        _cont.mySessionListApi();
        Get.back();
        successToast(response['msg'].toString());
      } else {
        closeProgress();
        errorToast(response['msg'].toString());
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
    }
  }
}
