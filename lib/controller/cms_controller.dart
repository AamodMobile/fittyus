import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../services/api_services.dart';

class CmsController extends GetxController implements GetxService {
  String content = '';
  bool isLoading = true;
  String mobile = "";
  String email = "";

  Future fetchPage(String slug) async {
    try {
      var result = await ApiServices.cmsList(slug);
      var json = jsonDecode(result.body);
      if (json['status'] == true) {
        content = json["data"];
        isLoading = false;
      } else {
        content = 'error';
        isLoading = false;
      }
    } catch (e) {
      content = '';
      isLoading = false;
    }
    update();
  }

  Future fetchContactDetails() async {
    try {
      var result = await ApiServices.contactDetails();
      var json = jsonDecode(result.body);
      if (json['status'] == true) {
        email = json["data"][0]["email"].toString();
        mobile = json["data"][0]["mobile"].toString();
      } else {
        email = "";
        mobile = "";
      }
    } catch (e) {
      log(e.toString());
    }
    update();
  }
}
