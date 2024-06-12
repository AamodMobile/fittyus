class CouponModelNew {
  int? id;
  String? couponName;
  String? userId;
  int? allUser;
  dynamic courseId;
  String? couponDiscount;
  String? couponCode;
  DateTime? beginDate;
  DateTime? endDate;
  String? description;
  int? cartValue;
  String? couponType;
  int? couponUses;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? type;
  String? image;
  String? banner;
  String? link;
  String? title;

  CouponModelNew(
      {this.id,
      this.couponName,
      this.userId,
      this.allUser,
      this.courseId,
      this.couponDiscount,
      this.couponCode,
      this.beginDate,
      this.endDate,
      this.description,
      this.cartValue,
      this.couponType,
      this.couponUses,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.type,
      this.image,
      this.title,
      this.banner,
      this.link});

  factory CouponModelNew.fromJson(Map<String, dynamic> json) => CouponModelNew(
        id: json["id"],
        couponName: json["coupon_name"],
        userId: json["user_id"],
        allUser: json["all_user"],
        courseId: json["course_id"],
        couponDiscount: json["coupon_discount"],
        couponCode: json["coupon_code"],
        beginDate: json["begin_date"] == null ? null : DateTime.parse(json["begin_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        description: json["description"],
        cartValue: json["cart_value"],
        couponType: json["coupon_type"],
        couponUses: json["coupon_uses"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        type: json["type"],
        image: json["image"],
        banner: json["banner"],
        link: json["link"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "coupon_name": couponName,
        "user_id": userId,
        "all_user": allUser,
        "course_id": courseId,
        "coupon_discount": couponDiscount,
        "coupon_code": couponCode,
        "begin_date": "${beginDate!.year.toString().padLeft(4, '0')}-${beginDate!.month.toString().padLeft(2, '0')}-${beginDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "description": description,
        "cart_value": cartValue,
        "coupon_type": couponType,
        "coupon_uses": couponUses,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "type": type,
        "image": image,
        "banner": banner,
        "title": title,
        "link": link,
      };
}
