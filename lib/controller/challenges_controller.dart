// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/model/challenge_details_model.dart';
import 'package:fittyus/model/challenge_list_model.dart';
import 'package:fittyus/model/like_model.dart';
import 'package:fittyus/model/my_challenge_model.dart';
import 'package:fittyus/model/video_model.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:fittyus/services/api_services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../model/comment_model.dart';
import 'package:http/http.dart' as http;

class ChallengesController extends GetxController implements GetxService {
  var allChallengeList = <ChallengeListModel>[].obs;
  var myChallengeList = <MyChallenge>[].obs;
  bool isLoading = true;
  var challengeDetails = ChallengeDetailsModel().obs;
  var relatedParticipant = <ParticipantPost1>[].obs;
  RxList<CommentModel> commentList = RxList<CommentModel>();
  var likeList = <LikeListModel>[].obs;
  var videoModel = VideoModel().obs;
  var commentCount = 0;
  var challengeId = "";
  TextEditingController addPostDes = TextEditingController();
  Razorpay razorpay = Razorpay();

  @override
  void onInit() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    super.onInit();
  }

  Future<void> getAllChallengeListApi() async {
    try {
      var result = await ApiServices.allChallengeList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        allChallengeList.value = List<ChallengeListModel>.from(json['data'].map((i) => ChallengeListModel.fromJson(i))).toList(growable: true);
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

  Future<void> getChallengeDetailsApi(String challengeId) async {
    try {
      isLoading = true;
      var result = await ApiServices.challengeDetails(challengeId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        ChallengeDetailsModel model = ChallengeDetailsModel.fromJson(json['data']);
        challengeDetails.value = model;
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

  Future<void> getChallengeVideoApi(String postId) async {
    try {
      isLoading = true;
      var result = await ApiServices.challengeVideo(postId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        VideoModel model = VideoModel.fromJson(json['data']);
        videoModel.value = model;
        challengeCommentList(postId);
        challengeLikeList(postId);
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

  Future<void> challengePostLike(String postId, String type) async {
    try {
      isLoading = true;
      var result = await ApiServices.challengePostLike(postId, type);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        getAllChallengeListApi();
        challengeLikeList(postId);
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

  Future<void> challengeCommentUpdate(String commentId, String message) async {
    try {
      isLoading = true;
      var result = await ApiServices.challengeCommentUpdate(commentId, message);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        successToast(json["message"].toString());
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

  Future<void> challengeCommentDelete(String commentId) async {
    try {
      isLoading = true;
      var result = await ApiServices.challengeCommentDelete(commentId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        Get.back();
        successToast(json["msg"].toString());
        isLoading = false;
      } else {
        errorToast(json["msg"].toString());
        isLoading = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading = false;
    }
    update();
  }

  Future<void> challengeCommentList(String postId) async {
    try {
      isLoading = true;
      var result = await ApiServices.challengeCommentList(postId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        commentCount = json["comment_count"];
        commentList.value = List<CommentModel>.from(json['data'].map((i) => CommentModel.fromJson(i))).toList(growable: true);
        update();
        isLoading = false;
      } else {
        isLoading = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading = false;
    }
    update();
  }

  Future<void> challengeLikeList(String postId) async {
    try {
      isLoading = true;
      var result = await ApiServices.challengeLikeList(postId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        likeList.value = List<LikeListModel>.from(json['data'].map((i) => LikeListModel.fromJson(i))).toList(growable: true);
        isLoading = false;
      } else {
        isLoading = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading = false;
    }
    update();
  }

  Future<void> myChallengeListApi() async {
    try {
      var result = await ApiServices.myChallengeList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        myChallengeList.value = List<MyChallenge>.from(json['data'].map((i) => MyChallenge.fromJson(i))).toList(growable: true);
        relatedParticipant.value = List<ParticipantPost1>.from(json['related_participant'].map((i) => ParticipantPost1.fromJson(i))).toList(growable: true);
        isLoading = false;
      } else {
        isLoading = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading = false;
    }
    update();
  }

  Future<void> challengeJoinApi(String challengeId, String transactionId) async {
    try {
      showProgress();
      var result = await ApiServices.challengeJoin(challengeId, transactionId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        Get.back();
        successToast(json["message"].toString());

      } else {
        closeProgress();
        errorToast(json["message"].toString());
        isLoading = false;
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
      isLoading = false;
    }
    update();
  }

  Future<void> addChallengeComment(String challengeId, String msg, String replyId) async {
    try {
      var result = await ApiServices.addChallengeComment(challengeId, msg, replyId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
      } else {
        closeProgress();
        errorToast(json["message"].toString());
        isLoading = false;
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
      isLoading = false;
    }
    update();
  }

  Future<void> postChallenge(var challengeId, var videoThumbnail, var video) async {
    try {
      showProgress();
      var response = await ApiServices.postChallenge(addPostDes.text, challengeId, videoThumbnail, video);
      if (response['status'] == true) {
        closeProgress();
        myChallengeListApi();
        getAllChallengeListApi();
        Get.back();
        successToast(response["msg"]);
      } else {
        closeProgress();
        errorToast(response["msg"]);
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
    }
  }

  Future<void> leaveChallenge(String challengeId) async {
    try {
      isLoading = true;
      var result = await ApiServices.leaveChallengeApi(challengeId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        Get.back();
        myChallengeListApi();
        getAllChallengeListApi();
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
      openPay(
        orderId,
        finalPrices,
        userEmail,
        "91$userMobile",
      );
    } else {
      closeProgress();
      errorToast("Error Get Order Id.!!");
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
      'description': 'You Added $finalPrice Amount to your Wallet',
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
      Log.console(e.toString());
    }
  }

  Future<void> handlePaymentSuccess(PaymentSuccessResponse response) async {
    var razorPaymentID = response.paymentId.toString();
    await challengeJoinApi(challengeId, razorPaymentID);
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
