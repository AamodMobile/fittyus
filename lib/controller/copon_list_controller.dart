import 'dart:convert';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/model/coupan_list_new.dart';
import 'package:fittyus/model/coupon_model.dart';
import 'package:fittyus/services/api_services.dart';


class CouponListController extends GetxController implements GetxService {
  var couponList = <CouponModelNew>[].obs;
  var couponNewList = <CouponModel>[].obs;
  TextEditingController coupon = TextEditingController();
  bool isLoading = true;

  Future<void> getCouponListApi(String type) async {
    try {
      var result = await ApiServices.couponList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        if(type==""){
          couponList.value = List<CouponModelNew>.from(
              json['banner_coupon'].map((i) => CouponModelNew.fromJson(i))).toList(growable: true);
        }else{
          couponNewList.value = List<CouponModel>.from(
              json['coupon'].map((i) => CouponModel.fromJson(i)))
              .toList(growable: true);
        }

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
