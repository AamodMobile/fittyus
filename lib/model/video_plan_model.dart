// To parse this JSON data, do
//
//     final videoPlan = videoPlanFromJson(jsonString);

import 'dart:convert';

VideoPlan videoPlanFromJson(String str) => VideoPlan.fromJson(json.decode(str));

String videoPlanToJson(VideoPlan data) => json.encode(data.toJson());

class VideoPlan {
  int? id;
  int? categoryId;
  String? packageName;
  String? packageId;
  String? packagePrice;
  String? packageStartDate;
  String? packageEndDate;
  String? discountType;
  String? packageDiscount;
  int? price;

  VideoPlan({
    this.id,
    this.categoryId,
    this.packageName,
    this.packageId,
    this.packagePrice,
    this.packageStartDate,
    this.packageEndDate,
    this.discountType,
    this.packageDiscount,
    this.price,
  });

  factory VideoPlan.fromJson(Map<String, dynamic> json) => VideoPlan(
        id: json["id"],
        categoryId: json["category_id"],
        packageName: json["package_name"],
        packageId: json["package_id"],
        packagePrice: json["package_price"],
        packageStartDate: json["package_start_date"],
        packageEndDate: json["package_end_date"],
        discountType: json["discount_type"],
        packageDiscount: json["package_discount"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "package_name": packageName,
        "package_id": packageId,
        "package_price": packagePrice,
        "package_start_date": packageStartDate,
        "package_end_date": packageEndDate,
        "discount_type": discountType,
        "package_discount": packageDiscount,
        "price": price,
      };
}
