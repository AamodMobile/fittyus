class MySessionListModel {
  int? id;
  String? name;
  int? coachId;
  int? totalSeats;
  num? averageRating;
  String? shortDescription;
  String? categoryId;
  String? categoryName;
  String? sessionDate;
  String? city;
  String? zip;
  String? teacherName;
  String? timeSlot;
  String? meetingLink;
  int? timeSlotId;
  int? isExpire;

  MySessionListModel({
    this.id,
    this.name,
    this.coachId,
    this.totalSeats,
    this.averageRating,
    this.shortDescription,
    this.categoryId,
    this.categoryName,
    this.timeSlotId,
    this.isExpire,
    this.sessionDate,
    this.city,
    this.zip,
    this.teacherName,
    this.meetingLink,
    this.timeSlot,
  });

  factory MySessionListModel.fromJson(Map<String, dynamic> json) =>
      MySessionListModel(
        id: json["id"],
        name: json["name"],
        coachId: json["coach_id"],
        totalSeats: json["total_seats"],
        averageRating: json["average_rating"],
        shortDescription: json["short_description"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        timeSlotId: json["time_slot_id"],
        isExpire: json["is_expire"],
        sessionDate: json["session_date"],
        city: json["city"],
        zip: json["zip"],
        meetingLink: json["meeting_link"]??"",
        teacherName: json["teacher_name"],
        timeSlot: json["time_slot"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coach_id": coachId,
        "total_seats": totalSeats,
        "average_rating": averageRating,
        "short_description": shortDescription,
        "category_id": categoryId,
        "category_name": categoryName,
        "time_slot_id": timeSlotId,
        "is_expire": isExpire,
        "session_date": sessionDate,
        "city": city,
        "zip": zip,
        "meeting_link": meetingLink,
        "teacher_name": teacherName,
        "time_slot": timeSlot,
      };
}
