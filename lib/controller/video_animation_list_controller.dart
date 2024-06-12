import 'dart:convert';

import 'package:fittyus/model/video_animation_list_model.dart';
import 'package:fittyus/model/video_plan_model.dart';
import 'package:fittyus/screens/dashboard_screenn.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../services/api_services.dart';

class VideoAnimationListController extends GetxController implements GetxService {
  var animationVideoList = <AnimationVideoListModel>[].obs;
  var plansList = <VideoPlan>[].obs;
  bool isLoading = false;
  Razorpay razorpay = Razorpay();
  String amount = "1";
  String categoryId = "";
  String packageId = "";

  @override
  void onInit() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    super.onInit();
  }

  Future<void> getVideoAnimationListApi() async {
    try {
      isLoading = true;
      var result = await ApiServices.videoAnimationList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isLoading = false;
        animationVideoList.value = List<AnimationVideoListModel>.from(json['data'].map((i) => AnimationVideoListModel.fromJson(i))).toList(growable: true);
      } else {
        isLoading = false;
        errorToast(json["message"].toString());
      }
    } catch (e) {
      isLoading = false;
      errorToast(e.toString());
    }
    update();
  }

  Future<void> getVideoPlanListApi(String id) async {
    try {
      isLoading = true;
      var result = await ApiServices.videoPlanList(id);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        plansList.value = List<VideoPlan>.from(json['data'].map((i) => VideoPlan.fromJson(i))).toList(growable: true);
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

  Future<void> videoProgressUpdateApi(String galleryId, String watchTime, bool isBack) async {
    try {
      isLoading = true;
      var result = await ApiServices.videoProgressUpdate(galleryId, watchTime);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isLoading = false;
        if (isBack) {


        } else {
          getVideoAnimationListApi();
        }
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

  Future<void> buyVideos(
    String transactionId,
    String categoryId,
    String packageId,
  ) async {
    try {
      showProgress();
      var response = await ApiServices.buyVideo("razorpay", "NetBanking", transactionId, categoryId, packageId);
      var json = jsonDecode(response.body);
      if (json['status'] == true) {
        closeProgress();
        getVideoAnimationListApi();
        Get.to(() => const DashBoardScreen(index: 2));

        successToast(json['msg'].toString());
      } else {
        closeProgress();
        errorToast(json['msg'].toString());
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
    }
    update();
  }

  sendOrderRazor(String finalPrice, String email, String mobile) async {
    showProgress();
    double price = double.parse(finalPrice);
    int finalPrices = (price * 100).toInt();
    String basicAuth = 'Basic ${base64Encode(utf8.encode("rzp_test_XkqVfTOgcoVoSZ:vusdYDLGNXolVaDKcIhjgeWj"
        //'rzp_live_ofpZ6T4Heh7MHG:xB2JVdBa40cpgYSj1eYlfL3H'
        ))}';
    setHeaders() => {
          'Authorization': basicAuth,
          'Content-type': 'application/json',
        };
    var data = {
      "amount": finalPrices,
      "currency": "INR",
      "receipt": "Receipt no. : ${DateTime.now()}",
      "payment_capture": 1,
    };

    var url = Uri.parse('https://api.razorpay.com/v1/orders');
    var response = await http.post(
      url,
      headers: setHeaders(),
      body: jsonEncode(data),
    );
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      closeProgress();
      var orderId = body['id'];
      String userEmail = email;
      String userMobile = mobile;
      openPay(orderId, finalPrices, userEmail, "91$userMobile");
    } else {
      closeProgress();
      errorToast(
        "Error Get Order Id.!!",
      );
      isLoading = false;
    }
  }

  openPay(String id, int finalPrice, String email, String mobile) {
    isLoading = false;
    closeProgress();
    var options = {
      'key': "rzp_test_XkqVfTOgcoVoSZ",
      //'rzp_live_ofpZ6T4Heh7MHG',
      'amount': finalPrice,
      'name': "Fittyus",
      'image': "http://shreekalyanamtravels.com/fittyus/public/admin/logo/1693229409.jpg",
      'order_id': id,
      'description': 'You Added $amount Amount to your Wallet',
      'timeout': 300,
      'prefill': {
        'contact': mobile,
        'email': email,
      },
      'theme': {'color': "#45B649"}
    };
    try {
      closeProgress();
      razorpay.open(options);
    } catch (e) {
      closeProgress();
      isLoading = false;
      errorToast(e.toString());
      debugPrint(e.toString());
    }
  }

  Future<void> handlePaymentSuccess(PaymentSuccessResponse response) async {
    var razorPaymentID = response.paymentId.toString();
    Log.console("??$razorPaymentID");
    await buyVideos(razorPaymentID, categoryId, packageId);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    closeProgress();
    errorToast("Payment Fail. !!");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    closeProgress();
  }

  @override
  void onClose() {
    razorpay.clear();
    super.onClose();
  }

  @override
  void onReady() {
    razorpay;
    super.onReady();
  }
}
