// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison
import 'dart:convert';
import 'dart:io';

import 'package:fittyus/services/api_client.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:get/get_connect/connect.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices extends GetConnect {
  static var client = http.Client();

  static Future<http.Response> loginMobileApi(String mobile, String countryCode) async {
    http.Response response;
    var result = await ApiClient.postData(ApiUrl.loginWithMobileApi, headers: {}, body: {
      'mobile': mobile.trim(),
      'country_code': countryCode.trim(),
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> loginEmailApi(String mobile) async {
    http.Response response;
    var result = await ApiClient.postData(ApiUrl.loginEmailApi, headers: {}, body: {
      'email': mobile.trim(),
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> otpVerifyByMobileApi(String otp, String mobile, String countryCode) async {
    http.Response response;
    var result = await ApiClient.postData(ApiUrl.verifyOtpByMobile, headers: {}, body: {
      'otp': otp.trim(),
      'mobile': mobile.trim(),
      'country_code': countryCode.trim(),
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> otpVerifyByEmailApi(String otp, String email) async {
    http.Response response;
    var result = await ApiClient.postData(ApiUrl.verifyOtpByEmail, headers: {}, body: {
      'otp': otp,
      'email': email,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> getHomeApi() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.homeApi,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> userDetails() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.userDetails,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> coachList(String categoryId, String city) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.coachList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "category_id": categoryId,
      "city": city
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> coachDetails(String coachId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.coachDetails, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "coach_id": coachId
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> cmsList(String title) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.cmsList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "type": title
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<dynamic> editProfile(
    String firstName,
    String lastName,
    String email,
    String mobile,
    String country,
    String state,
    String city,
    String address,
    String gender,
    String occupation,
    String image,
  ) async {
    var result;
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(ApiUrl.editProfile));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      request.fields['first_name'] = firstName;
      request.fields['last_name'] = lastName;
      request.fields['email'] = email;
      request.fields['mobile'] = mobile;
      request.fields['country'] = country;
      request.fields['state'] = state;
      request.fields['city'] = city;
      request.fields['address'] = address;
      request.fields['gender'] = gender;
      request.fields['occupation'] = occupation;
      if (image.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('avatar_url', image);
        request.files.add(file);
      }
      response = await http.Response.fromStream(await request.send());
      if (response.body != null) {
        if (response.statusCode == 200) {
          result = jsonDecode(response.body);
        } else if (response.statusCode == 404) {
          result = {'status_code': 400, 'message': '404'};
        } else if (response.statusCode == 401) {
          result = jsonDecode(response.body);
        }
      } else {
        result = {'status_code': 404, 'message': 'Unable to Connect to Server!'};
      }
    } catch (e) {
      result = http.Response(jsonEncode({e.toString()}), 204, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    }
    return result;
  }

  static Future<dynamic> backOverAndProfileUpdate(
    String image,
    String profileBackCover,
  ) async {
    var result;
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(ApiUrl.editProfile));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      if (image.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('avatar_url', image);
        request.files.add(file);
      }
      if (profileBackCover.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('profile_back_cover', profileBackCover);
        request.files.add(file);
      }
      response = await http.Response.fromStream(await request.send());
      if (response.body != null) {
        if (response.statusCode == 200) {
          result = jsonDecode(response.body);
        } else if (response.statusCode == 404) {
          result = {'status_code': 400, 'message': '404'};
        } else if (response.statusCode == 401) {
          result = jsonDecode(response.body);
        }
      } else {
        result = {'status_code': 404, 'message': 'Unable to Connect to Server!'};
      }
    } catch (e) {
      result = http.Response(jsonEncode({e.toString()}), 204, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    }
    return result;
  }

  static Future<http.Response> blogList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.blogList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> blogDetailsApi(String blogId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.blogDetails, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "blog_id": blogId
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> blogCommentList(String blogId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.blogCommentList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "blog_id": blogId
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> blogLike(
    String blogId,
    String type,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.blogLike, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "blog_id": blogId,
      "is_like": type,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> addComment(String blogId, String message,String replyId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.blogAddComment, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "blog_id": blogId,
      "message": message,
      "reply_id": replyId
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }
  static Future<http.Response> deleteComment(String commentId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.blogDeleteComment, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "comment_id": commentId,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }
  static Future<http.Response> likeComment(String blogId,String commentId,String isLike) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.blogCommentLike, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "blog_id":blogId,
      "comment_id": commentId,
      "is_like":isLike
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }
  static Future<http.Response> contactDetails() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.contactDetails, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> categoryList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.categoryList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> myRatingList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.myRatingList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> coachPlansDetails(String coachId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.coachPlanDetails, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "coach_id": coachId,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> addCard(
    String coachId,
    String packageId,
    String sessionId,
    String sessionType,
    String timeSlot,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.addCard, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "class_id": coachId,
      "variation_id": packageId,
      "session_id": sessionId,
      "session_type": sessionType,
      "time_slot": timeSlot,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> notificationList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.notification, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> notificationListClear() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.getData(
      ApiUrl.notificationAllClear,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> couponList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.couponList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> addAddress(
    String firstName,
    String lastName,
    String email,
    String mobile,
    String country,
    String state,
    String city,
    String address,
    String countryCode,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.addAddress, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "mobile": mobile,
      "country": country,
      "country_code": countryCode,
      "state": state,
      "city": city,
      "address": address,
      "mobile_withcountry": countryCode + mobile,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> checkOutDetailsGet(
    String coachId,
    String packageId,
    String couponApply,
    String couponCode,
    String sessionId,
    String sessionType,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.checkOut, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "class_id": coachId,
      "variation_id": packageId,
      "coupon_apply": couponApply,
      "coupon_code": couponCode,
      "session_id": sessionId,
      "session_type": sessionType,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> updateAddress(
    String id,
    String firstName,
    String lastName,
    String email,
    String mobile,
    String country,
    String state,
    String city,
    String address,
    String countryCode,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.updateAddress, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "address_id": id,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "mobile": mobile,
      "country": country,
      "country_code": countryCode,
      "state": state,
      "city": city,
      "address": address,
      "mobile_withcountry": countryCode + mobile,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> addressListGet() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.addressListGet, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> completeBooking(
    String paymentOption,
    String paymentMethodTitle,
    String transactionId,
    String couponCode,
    String isMySelf,
    String price,
    String bookingType,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.completeBooking,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "payment_option": paymentOption,
        "payment_method_title": paymentMethodTitle,
        "transaction_id": transactionId,
        "coupon_code": couponCode,
        "is_myself": isMySelf,
        "price": price,
        "booking_type": bookingType,
      },
    );
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<dynamic> giveFeedback(
    String coachId,
    String rating,
    String comment,
    var images,
  ) async {
    var result;
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(ApiUrl.giveRating));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      request.fields['coach_id'] = coachId;
      request.fields['rating'] = rating;
      request.fields['comment'] = comment;
      if (images.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          if (images[i].toString() != "upload") {
            final File file = File(images[i].path);
            http.MultipartFile file2 = await http.MultipartFile.fromPath("image[]", file.path.toString());
            request.files.add(file2);
          }
        }
      }
      response = await http.Response.fromStream(await request.send());
      if (response.body != null) {
        if (response.statusCode == 200) {
          result = jsonDecode(response.body);
        } else if (response.statusCode == 404) {
          result = {'status_code': 400, 'message': '404'};
        } else if (response.statusCode == 401) {
          result = jsonDecode(response.body);
        }
      } else {
        result = {'status_code': 404, 'message': 'Unable to Connect to Server!'};
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<http.Response> myPlanList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.myPlanLists, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> sessionList(String date, String city) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.sessionList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "date": date,
      "city": city,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> communityList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.communityList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> communityDetailsApi(String communityId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.communityDetails, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "community_id": communityId
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> communityLike(
    String communityId,
    String type,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.communityLike, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "community_id": communityId,
      "is_like": type,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> communityAddComment(String communityId, String message, String replyId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.communityAddComment, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "community_id": communityId,
      "reply_id": replyId,
      "message": message
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> videoAnimationList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.videoAnimation, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> videoPlanList(String categoryId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.videoPlan, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "category_id": categoryId
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> buyVideo(
    String paymentOption,
    String paymentMethodTitle,
    String transactionId,
    String categoryId,
    String packageId,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.buyVideo,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "payment_option": paymentOption,
        "payment_method_title": paymentMethodTitle,
        "transaction_id": transactionId,
        "category_id": categoryId,
        "package_id": packageId,
      },
    );
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<dynamic> postChallenge(
    String description,
    String challengeId,
    var videoThumbnail,
    var video,
  ) async {
    var result;
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(ApiUrl.challengePost));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      request.fields['description'] = description;
      request.fields['challenge_id'] = challengeId;
      if (video.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('video', video);
        request.files.add(file);
      }
      if (videoThumbnail.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('video_thumbnail', videoThumbnail);
        request.files.add(file);
      }
      response = await http.Response.fromStream(await request.send());
      if (response.body != null) {
        if (response.statusCode == 200) {
          result = jsonDecode(response.body);
        } else if (response.statusCode == 404) {
          result = {'status_code': 400, 'message': '404'};
        } else if (response.statusCode == 401) {
          result = jsonDecode(response.body);
        }
      } else {
        result = {'status_code': 404, 'message': 'Unable to Connect to Server!'};
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<http.Response> allChallengeList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.allChallengeList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> challengeDetails(String challengeId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.challengeDetails, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "challengepost_id": challengeId
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> challengePostLike(String challengeId, String type) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.challengePostLike, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "challengepost_id": challengeId,
      "is_like": type
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> challengeVideo(String challengeId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.challengeVideo, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "challengepost_id": challengeId,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> challengeCommentList(String challengeId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.challengeCommentList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "challengepost_id": challengeId,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> deleteAccount() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.deleteAccountApi, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> myChallengeList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.myChallengeList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> challengeJoin(String challengeId,String transactionId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.challengeJoin, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "challenge_id": challengeId,
      "transaction_id": transactionId,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> addChallengeComment(String challengeId, String message, String replyId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.addChallengeComment, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "challengepost_id": challengeId,
      "message": message,
      "reply_id": replyId,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> mySessionList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.mySessionList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> mySessionDetails(String sessionId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.mySessionDetails, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "session_id": sessionId
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> search(String search) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.search, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "search": search,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> leaveChallengeApi(String challengeId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    var result = await ApiClient.postData(ApiUrl.leaveChallenge, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "challenge_id": challengeId,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> challengeLikeList(String challengePostId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.challengeLikeList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "challengepost_id": challengePostId
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> challengeCommentUpdate(String commentId, String message) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.challengeCommentUpdate, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "comment_id": commentId,
      "message": message
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> challengeCommentDelete(String commentId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.challengeCommentDelete, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "comment_id": commentId
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<dynamic> addCommunity(
    String title,
    String shortDescription,
    var image,
  ) async {
    var result;
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(ApiUrl.communityAdd));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      request.fields['title'] = title;
      request.fields['short_description'] = shortDescription;
      request.fields['type'] = "multipal";
      if (image.isNotEmpty) {
        for (int i = 0; i < image.length; i++) {
          if (image[i].toString() != "upload") {
            final File file = File(image[i].path);
            http.MultipartFile file2 = await http.MultipartFile.fromPath("image[]", file.path.toString());
            request.files.add(file2);
          }
        }
      }
      response = await http.Response.fromStream(await request.send());
      if (response.body != null) {
        if (response.statusCode == 200) {
          result = jsonDecode(response.body);
        } else if (response.statusCode == 404) {
          result = {'status_code': 400, 'message': '404'};
        } else if (response.statusCode == 401) {
          result = jsonDecode(response.body);
        }
      } else {
        result = {'status_code': 404, 'message': 'Unable to Connect to Server!'};
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<dynamic> addCommunityAfterBefore(
    String title,
    String shortDescription,
    String afterImg,
    String beforeImg,
  ) async {
    var result;
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(ApiUrl.communityAdd));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      request.fields['title'] = title;
      request.fields['short_description'] = shortDescription;
      request.fields['type'] = "after_before";
      if (afterImg.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('after_image', afterImg);
        request.files.add(file);
      }
      if (beforeImg.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('before_image', beforeImg);
        request.files.add(file);
      }
      response = await http.Response.fromStream(await request.send());
      if (response.body != null) {
        if (response.statusCode == 200) {
          result = jsonDecode(response.body);
        } else if (response.statusCode == 404) {
          result = {'status_code': 400, 'message': '404'};
        } else if (response.statusCode == 401) {
          result = jsonDecode(response.body);
        }
      } else {
        result = {'status_code': 404, 'message': 'Unable to Connect to Server!'};
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<dynamic> updateCommunity(
    String title,
    String shortDescription,
    var image,
    List<String> imageIds,
    String communityId,
  ) async {
    var result;
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(ApiUrl.communityUpdate));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      request.fields['title'] = title;
      request.fields['short_description'] = shortDescription;
      request.fields['community_id'] = communityId;
      request.fields['type'] = "multipal";
      if (imageIds.isNotEmpty) {
        for (int i = 0; i < imageIds.length; i++) {
          request.fields['delete_image_ids[]'] = imageIds[i];
        }
      }
      if (image != null && image.isNotEmpty) {
        for (int i = 0; i < image.length; i++) {
          if (image[i].toString() != "upload") {
            if (image[i] is String) {
            } else if (image[i] is File) {
              final File file = File(image[i].path);
              http.MultipartFile file2 = await http.MultipartFile.fromPath("image[]", file.path.toString());
              request.files.add(file2);
            }
          }
        }
      }

      response = await http.Response.fromStream(await request.send());
      if (response.body != null) {
        if (response.statusCode == 200) {
          result = jsonDecode(response.body);
        } else if (response.statusCode == 404) {
          result = {'status_code': 400, 'message': '404'};
        } else if (response.statusCode == 401) {
          result = jsonDecode(response.body);
        }
      } else {
        result = {'status_code': 404, 'message': 'Unable to Connect to Server!'};
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<dynamic> updateCommunityAfterBefore(
    String title,
    String shortDescription,
    var afterImg,
    var beforeImg,
    String communityId,
  ) async {
    var result;
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(ApiUrl.communityUpdate));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      request.fields['title'] = title;
      request.fields['short_description'] = shortDescription;
      request.fields['community_id'] = communityId;
      request.fields['type'] = "after_before";
      if (afterImg.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('after_image', afterImg);
        request.files.add(file);
      }
      if (beforeImg.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('before_image', beforeImg);
        request.files.add(file);
      }
      response = await http.Response.fromStream(await request.send());
      if (response.body != null) {
        if (response.statusCode == 200) {
          result = jsonDecode(response.body);
        } else if (response.statusCode == 404) {
          result = {'status_code': 400, 'message': '404'};
        } else if (response.statusCode == 401) {
          result = jsonDecode(response.body);
        }
      } else {
        result = {'status_code': 404, 'message': 'Unable to Connect to Server!'};
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<http.Response> communityDelete(String id) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.communityDelete, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "community_id": id
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> viewProfile(String id) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.viewProfile, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "user_id": id
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> followAndUnfollow(String id) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.followAndUnfollow, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "following_id": id
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> communityGallery(String userId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.communityGallery,
      headers: {'Authorization': 'Bearer $token'},
      body: {"user_id": userId},
    );
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> communityCommentList(String communityId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.communityCommentList, headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      "community_id": communityId,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> communityCommentDelete(String commentId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.communityCommentDelete, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "comment_id": commentId
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> communityCommentLike(String commentId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.communityCommentLike, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "comment_id": commentId
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> videoProgressUpdate(String galleryId, String watchTime) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.videoProgressUpdate, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "gallery_id": galleryId,
      "watch_time": watchTime,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }
  static Future<http.Response> updateFcmToken(String fcmToken) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.fcmTokenUpdate, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "device_key": fcmToken,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }
}
