class MyPlanListModel {
  int? id;
  String? name;
  String? image;
  String? coachType;
  String? averageRating;
  int? orderId;
  int? paidTotal;
  String? duration;
  String? meetingLink;
  int? dayCount;

  MyPlanListModel({
    this.id,
    this.name,
    this.image,
    this.coachType,
    this.averageRating,
    this.orderId,
    this.paidTotal,
    this.duration,
    this.meetingLink,
    this.dayCount,
  });

  factory MyPlanListModel.fromJson(Map<String, dynamic> json) =>
      MyPlanListModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        coachType: json["coach_type"],
        averageRating: json["average_rating"],
        orderId: json["order_id"],
        paidTotal: json["paid_total"],
        duration: json["duration"],
        meetingLink: json["meeting_link"]??"",
        dayCount: json["daycount"],

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "coach_type": coachType,
        "average_rating": averageRating,
        "order_id": orderId,
        "paid_total":paidTotal,
        "duration": duration,
        "meeting_link": meetingLink,
        "daycount": dayCount,
      };
}
