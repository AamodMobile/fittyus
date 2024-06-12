import 'package:fittyus/model/coach_model.dart';

class CoachPlansDetailsModel {
  CoachList coach;
  String? avgRating;
  List<PlanList> planList;

  CoachPlansDetailsModel(
      {required this.coach, required this.planList, this.avgRating});

  factory CoachPlansDetailsModel.fromJson(Map<String, dynamic> json) =>
      CoachPlansDetailsModel(
        coach: CoachList.fromJson(json["coach"]),
        avgRating: json["avg_rating"],
        planList: json["packages"] == null
            ? []
            : List<PlanList>.from(
                json["packages"]!.map((x) => PlanList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "coach": coach.toJson(),
        "avg_rating": avgRating,
        "packages": planList == null
            ? []
            : List<dynamic>.from(planList.map((x) => x.toJson())),
      };
}

class PlanList {
  int? id;
  String? options;
  int? month;
  String? packagePrice;
  String? packageDescription;
  String? discountType;
  String? packageDiscount;
  int? timeLeft;
  int? packageId;
  double? totalAmount;

  PlanList(
      {this.id,
      this.options,
      this.month,
      this.packageDescription,
      this.packagePrice,
      this.discountType,
      this.packageDiscount,
      this.timeLeft,
      this.totalAmount,
      this.packageId});

  factory PlanList.fromJson(Map<String, dynamic> json) => PlanList(
        id: json["id"],
        options: json["options"],
        month: json["month"],
        packageDescription: json["package_description"],
        packagePrice: json["package_price"],
        discountType: json["discount_type"],
        packageDiscount: json["package_discount"],
        packageId: json["package_id"],
        timeLeft: json["time_left"],
        totalAmount: json["total_amount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "options": options,
        "package_id": packageId,
        "month": month,
        "package_description": packageDescription,
        "package_price": packagePrice,
        "discount_type": discountType,
        "package_discount": packageDiscount,
        "time_left": timeLeft,
        "total_amount": totalAmount,
      };
}
