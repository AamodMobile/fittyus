import 'dart:convert';
import 'package:fittyus/controller/home_controller.dart';
import '../constants/constants.dart';
import '../model/blog_list_model.dart';
import '../services/api_services.dart';

class BlogListController extends GetxController implements GetxService {
  var blogList = <BlogList>[].obs;
  bool isLoading = true;
  var con = Get.find<HomeController>();

  Future<void> getBlogListApi() async {
    try {
      var result = await ApiServices.blogList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        blogList.value =
            List<BlogList>.from(json['data'].map((i) => BlogList.fromJson(i)))
                .toList(growable: true);
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

  Future<void> blogLike(String blogId, String type) async {
    try {
      var result = await ApiServices.blogLike(blogId, type);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        getBlogListApi();
        con.getHomeApi();
      } else {
        errorToast(json["message"].toString());
      }
    } catch (e) {
      errorToast(e.toString());
    }
    update();
  }
}
