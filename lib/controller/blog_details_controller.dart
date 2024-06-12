import 'dart:convert';

import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/model/blog_details_model.dart';
import 'package:fittyus/services/api_services.dart';

class BlogDetailsController extends GetxController implements GetxService {
  var blogDetails = BlogDetailsModel().obs;
  bool isLoading = true;

  Future<void> blogDetailsApi(String blogId) async {
    try {
      var result = await ApiServices.blogDetailsApi(blogId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        BlogDetailsModel model = BlogDetailsModel.fromJson(json['data']);
        blogDetails.value = model;
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
