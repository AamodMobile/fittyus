
import 'dart:convert';

OTPModel oTPModelFromJson(String str) => OTPModel.fromJson(json.decode(str));

String otpModelToJson(OTPModel data) => json.encode(data.toJson());

class OTPModel {
  bool? status;
  String? accessToken;
  String? tokenType;
  User? users;
  String? msg;

  OTPModel({
    this.status,
    this.accessToken,
    this.tokenType,
    this.users,
    this.msg,
  });

  factory OTPModel.fromJson(Map<String, dynamic> json) => OTPModel(
    status: json["status"],
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    users: json["user"] == null ? null : User.fromJson(json["user"]),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "access_token": accessToken,
    "token_type": tokenType,
    "user": users?.toJson(),
    "msg": msg,
  };
}

class User {
  int? id;
  dynamic googleId;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? username;
  String? isPayingCustomer;
  String? avatarUrl;
  String? referalCode;
  String? referCode;
  String? registerOtp;
  dynamic deviceKey;
  DateTime? emailVerifiedAt;
  String? verifyOtpStatus;
  String? address;
  String? city;
  String? state;
  String? country;
  String? profileImage;
  String? billingCompany;
  String? countryCode;
  String? mobile;
  String? mobileWithcountry;
  int? isNotification;
  dynamic notification;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic userDetail;

  User({
    this.id,
    this.googleId,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.username,
    this.isPayingCustomer,
    this.avatarUrl,
    this.referalCode,
    this.referCode,
    this.registerOtp,
    this.deviceKey,
    this.emailVerifiedAt,
    this.verifyOtpStatus,
    this.address,
    this.city,
    this.state,
    this.country,
    this.profileImage,
    this.billingCompany,
    this.countryCode,
    this.mobile,
    this.mobileWithcountry,
    this.isNotification,
    this.notification,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userDetail,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    googleId: json["google_id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    role: json["role"],
    username: json["username"],
    isPayingCustomer: json["is_paying_customer"],
    avatarUrl: json["avatar_url"],
    referalCode: json["referal_code"],
    referCode: json["refer_code"],
    registerOtp: json["register_otp"],
    deviceKey: json["device_key"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    verifyOtpStatus: json["verify_otp_status"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    profileImage: json["profile_image"],
    billingCompany: json["billing_company"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    mobileWithcountry: json["mobile_withcountry"],
    isNotification: json["is_notification"],
    notification: json["notification"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    userDetail: json["user_detail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "google_id": googleId,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "role": role,
    "username": username,
    "is_paying_customer": isPayingCustomer,
    "avatar_url": avatarUrl,
    "referal_code": referalCode,
    "refer_code": referCode,
    "register_otp": registerOtp,
    "device_key": deviceKey,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "verify_otp_status": verifyOtpStatus,
    "address": address,
    "city": city,
    "state": state,
    "country": country,
    "profile_image": profileImage,
    "billing_company": billingCompany,
    "country_code": countryCode,
    "mobile": mobile,
    "mobile_withcountry": mobileWithcountry,
    "is_notification": isNotification,
    "notification": notification,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user_detail": userDetail,
  };
}
