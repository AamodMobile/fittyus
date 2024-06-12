import 'dart:convert';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/model/address_list_model.dart';
import 'package:fittyus/model/check_out_model.dart';
import 'package:fittyus/screens/thank_you_screen.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:fittyus/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

class CheckOutController extends GetxController implements GetxService {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  Razorpay razorpay = Razorpay();
  var addressList = <AddressList>[].obs;
  var countryCode = "+91";
  bool isLoading = true;
  var checkOutData = CheckOutModel().obs;
  var coachId = "";
  var packageId = "";
  var sessionId = "";
  var sessionType = "";
  String amount = "1";
  String couponCode = "";
  String bookingType = "";

  //String mid = "DIY12386817555501617";
  String mid = "wqVUVd20044541741729";
  bool isStaging = false;
  bool restrictAppInvoke = true;
  var paytmTxnID = "";
  var paytmID = "";
  String orderId = "", txnToken = "";
  String result = "";
  String callbackUrl = "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=";
  bool enableAssist = true;

/* Test Merchant ID
  wqVUVd20044541741729
  Test Merchant Key
  Kl9RQZ&XFdyujk5Q
  Merchant ID
  ZfftvK28353754563174
  Merchant Key
  RJBfSEtHcHJYrJEJ*/

  @override
  void onInit() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    super.onInit();
  }

  Future<void> checkOutDetails(String couponApply, String couponCode) async {
    try {
      var result = await ApiServices.checkOutDetailsGet(
        coachId,
        packageId,
        couponApply,
        couponCode,
        sessionId,
        sessionType,
      );
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        CheckOutModel model = CheckOutModel.fromJson(json['data']);
        checkOutData.value = model;
        isLoading = false;
      } else {
        errorToast(json["message"].toString());
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      closeProgress();
      errorToast(e.toString());
    }
    update();
  }

  Future<void> saveAddress() async {
    try {
      showProgress();
      var response = await ApiServices.addAddress(
          firstName.text.toString(),
          lastName.text.toString(),
          email.text.toString(),
          mobile.text.toString(),
          country.text.toString(),
          state.text.toString(),
          city.text.toString(),
          address.text.toString(),
          countryCode);
      var json = jsonDecode(response.body);
      if (json['status'] == true) {
        closeProgress();
        addressListGet();
        Get.back();
        successToast(json['message'].toString());
      } else {
        closeProgress();
        errorToast(json['message'].toString());
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
    }
    update();
  }

  Future<void> updateAddress(String id) async {
    try {
      showProgress();
      var response = await ApiServices.updateAddress(
          id,
          firstName.text.toString(),
          lastName.text.toString(),
          email.text.toString(),
          mobile.text.toString(),
          country.text.toString(),
          state.text.toString(),
          city.text.toString(),
          address.text.toString(),
          countryCode);
      var json = jsonDecode(response.body);
      if (json['status'] == true) {
        closeProgress();
        addressListGet();
        Get.back();
        successToast(json['message'].toString());
      } else {
        closeProgress();
        errorToast(json['message'].toString());
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
    }
    update();
  }

  Future<void> addressListGet() async {
    try {
      var result = await ApiServices.addressListGet();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        addressList.value = List<AddressList>.from(
                json['data'].map((i) => AddressList.fromJson(i)))
            .toList(growable: true);
        isLoading = false;
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  Future<void> completeBooking(String transactionId, String couponCode,
      String bookingType, String type) async {
    try {
      showProgress();
      var response = await ApiServices.completeBooking(
          type,
          "NetBanking",
          transactionId,
          couponCode == "" ? "" : couponCode,
          "1",
          amount,
          bookingType);
      var json = jsonDecode(response.body);
      if (json['status'] == true) {
        closeProgress();
        Get.off(() => const ThankYouScreen());
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
    String basicAuth =
        'Basic ${base64Encode(utf8.encode("rzp_test_XkqVfTOgcoVoSZ:vusdYDLGNXolVaDKcIhjgeWj"
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
      'image':
          "http://shreekalyanamtravels.com/fittyus/public/admin/logo/1693229409.jpg",
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
      Log.console(e.toString());
    }
  }

  Future<void> handlePaymentSuccess(PaymentSuccessResponse response) async {
    var razorPaymentID = response.paymentId.toString();
    await completeBooking(razorPaymentID, couponCode, bookingType, "razorpay");
  }

  void handlePaymentError(PaymentFailureResponse response) {
    closeProgress();
    errorToast("Payment Fail. !!");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    closeProgress();
  }



  Future<void> initOpenPaytm() async {
    try {
      await showProgress();
      const uuid = Uuid();
      final oid = uuid.v1();
      final url =
          "https://securegw.paytm.in/theia/api/v1/initiateTransaction?mid=$mid&orderId=$oid";
      final response = await http.post(
        Uri.parse(url),
        body: {},
      );

      if (response.statusCode == 200) {
        closeProgress();
        final resBody = json.decode(response.body);
        final responseBody = resBody['body'];
        final resultInfo = responseBody['resultInfo'];
         Log.console(resultInfo);
        if (resultInfo != null) {
          final resultStatus = resultInfo['resultStatus'];
          final resultMsg = resultInfo['resultMsg'];
          if (resultStatus == "S" && resultMsg == "Success") {
            final resultCode = resultInfo['resultCode'];
            if (resultCode == "0000") {
              final txnToken = responseBody['txnToken'];
              allInOneSdk(txnToken, oid);
            }
          }
        }
      }
    } catch (e) {
      closeProgress();
      errorToast("Error: $e");
      Log.console("Error: $e");
    }
  }

  void allInOneSdk(String txnToken, String orderId) async {
    String result = "";
    try {
      await showProgress();
      final response = AllInOneSdk.startTransaction(
          mid,
          orderId,
          amount,
          txnToken,
          "https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=$orderId",
          isStaging,
          restrictAppInvoke);

      response.then((value) async {
        if (value != null) {
          if (value['STATUS'] == "TXN_SUCCESS") {
            paytmTxnID = value['TXNID'];
            await _handlePaymentSuccessForPaytm();
          } else {
            errorToast("Payment failed");
          }
        }
        result = value.toString();
      }).catchError((onError) {
        if (onError is PlatformException) {
          result = onError.message ?? " \n  ${onError.details}";
          errorToast(result);
        } else {
          result = onError.toString();
          errorToast(result);
           Log.console(result);
        }
      });
    } catch (err) {
       Log.console(err.toString());
      errorToast(err.toString());
    } finally {
      closeProgress();
    }
  }

  Future<void> _handlePaymentSuccessForPaytm() async {
    showProgress();
    completeBooking(paytmTxnID, couponCode, bookingType, "paytm");
  }

  Future<void> startTransaction() async {
    txnToken = "jjjjj";
    const uuid = Uuid();
    orderId = uuid.v1();
    showProgress();
    if (txnToken.isEmpty) {
      closeProgress();
      return;
    }
    var sendMap = <String, dynamic>{
      "mid": mid,
      "orderId": orderId,
      "amount": amount,
      "txnToken": txnToken,
      "callbackUrl": callbackUrl + orderId,
      "isStaging": isStaging,
      "restrictAppInvoke": restrictAppInvoke,
      "enableAssist": enableAssist
    };
     Log.console(sendMap);
    try {
      var response = AllInOneSdk.startTransaction(mid, orderId, amount,
          txnToken, callbackUrl, isStaging, restrictAppInvoke, enableAssist);
      response.then((value) {
        closeProgress();
         Log.console(value);
        result = value.toString();
         Log.console("1$result");
      }).catchError((onError) {
        closeProgress();
        if (onError is PlatformException) {
          result = "${onError.message} \n  ${onError.details}";
           Log.console("2$result");
        } else {
          result = onError.toString();
           Log.console("3$result");
        }
      });
    } catch (err) {
      closeProgress();
      result = err.toString();
       Log.console("4$result");
    }
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
