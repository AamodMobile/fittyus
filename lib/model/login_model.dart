// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  bool? status;
  String? msg;
  String? mobile;


  LoginResponseModel({
    this.status,
    this.mobile,
    this.msg
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"],
        mobile: json["mobile_no"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() =>
      {
        "status": status,
        "mobile_no": mobile,
        "msg": msg,
      };
}

class Society {
  int? societyId;
  String? societyName;

  Society({
    this.societyId,
    this.societyName,
  });

  factory Society.fromJson(Map<String, dynamic> json) =>
      Society(
        societyId: json["society_id"],
        societyName: json["society_name"],
      );

  Map<String, dynamic> toJson() =>
      {
        "society_id": societyId,
        "society_name": societyName,
      };
}

class User {
  int? id;
  String? societyId;
  String? name;
  String? email;
  String? mobile;
  dynamic emailVerifiedAt;
  int? status;
  String? profileImage;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.societyId,
    this.name,
    this.email,
    this.mobile,
    this.emailVerifiedAt,
    this.status,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      User(
        id: json["id"],
        societyId: json["society_id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        emailVerifiedAt: json["email_verified_at"],
        status: json["status"],
        profileImage: json["profile_image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(
            json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(
            json["updated_at"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "society_id": societyId,
        "name": name,
        "email": email,
        "mobile": mobile,
        "email_verified_at": emailVerifiedAt,
        "status": status,
        "profile_image": profileImage,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
