class CouponModel {
  int? id;
  String? title;
  String? description;
  String? coupon;
  String? save;
  String? couponImage;
  String? beginDate;
  String? endDate;
  String? couponType;

  CouponModel({
    this.id,
    this.title,
    this.description,
    this.save,
    this.coupon,
    this.couponImage,
    this.beginDate,
    this.endDate,
    this.couponType,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        id: json["id"],
        title: json["coupon_name"],
        description: json["description"],
        save: json["coupon_discount"],
        coupon: json["coupon_code"],
        couponImage: json["coupon_image"],
        beginDate: json["begin_date"],
        endDate: json["end_date"],
        couponType: json["coupon_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "coupon_name": title,
        "description": description,
        "coupon_discount": save,
        "coupon_code": coupon,
        "coupon_image": couponImage,
        "begin_date": beginDate,
        "end_date": endDate,
        "coupon_type": couponType,
      };
}
