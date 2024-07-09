import 'dart:convert';

CheckOutModel checkOutModelFromJson(String str) =>
    CheckOutModel.fromJson(json.decode(str));

String checkOutModelToJson(CheckOutModel data) => json.encode(data.toJson());

class CheckOutModel {
  int? id;
  String? name;
  String? image;
  dynamic coachType;
  dynamic avgrating;
  PackageDetail? packageDetail;
  UserAddress? userAddress;

  CheckOutModel({
    this.id,
    this.name,
    this.image,
    this.coachType,
    this.avgrating,
    this.packageDetail,
    this.userAddress,
  });

  factory CheckOutModel.fromJson(Map<String, dynamic> json) => CheckOutModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        coachType: json["coach_type"],
        avgrating: json["avgrating"],
        packageDetail: json["packageDetail"] == null
            ? null
            : PackageDetail.fromJson(json["packageDetail"]),
        userAddress: json["userAddress"] == null
            ? null
            : UserAddress.fromJson(json["userAddress"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "coach_type": coachType,
        "avgrating": avgrating,
        "packageDetail": packageDetail?.toJson(),
        "userAddress": userAddress?.toJson(),
      };
}

class PackageDetail {
  String? options;
  String? packageDescription;
  int? month;
  int? id;
  int? categoryId;
  String? packageId;
  String? packagePrice;
  String? discountType;
  String? packageDiscount;
  dynamic totalAmount;
  dynamic originalTotalAmount;
  dynamic couponDiscount;
  String? couponCode;

  PackageDetail({
    this.options,
    this.packageDescription,
    this.month,
    this.id,
    this.categoryId,
    this.packageId,
    this.packagePrice,
    this.discountType,
    this.packageDiscount,
    this.totalAmount,
    this.originalTotalAmount,
    this.couponDiscount,
    this.couponCode,
  });

  factory PackageDetail.fromJson(Map<String, dynamic> json) => PackageDetail(
        options: json["options"],
        packageDescription: json["package_description"],
        month: json["month"],
        id: json["id"],
        categoryId: json["category_id"],
        packageId: json["package_id"],
        packagePrice: json["package_price"],
        discountType: json["discount_type"],
        packageDiscount: json["package_discount"],
        totalAmount: json["total_amount"],
        originalTotalAmount: json["original_total_amount"],
        couponDiscount: json["coupon_discount"],
        couponCode: json["coupon_code"]??"",
      );

  Map<String, dynamic> toJson() => {
        "options": options,
        "package_description": packageDescription,
        "month": month,
        "id": id,
        "category_id": categoryId,
        "package_id": packageId,
        "package_price": packagePrice,
        "discount_type": discountType,
        "package_discount": packageDiscount,
        "total_amount": totalAmount,
        "original_total_amount": originalTotalAmount,
        "coupon_discount": couponDiscount,
        "coupon_code": couponCode,
      };
}

class UserAddress {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? country;
  String? state;
  String? city;
  String? address;

  UserAddress({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.country,
    this.state,
    this.city,
    this.address,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobile: json["mobile"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        address: json["address"],

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile": mobile,
        "country": country,
        "state": state,
        "city": city,
        "address": address,
      };
}
