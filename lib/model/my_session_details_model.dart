// To parse this JSON data, do
//
//     final mySessionDetails = mySessionDetailsFromJson(jsonString);

import 'dart:convert';

MySessionDetails mySessionDetailsFromJson(String str) => MySessionDetails.fromJson(json.decode(str));

String mySessionDetailsToJson(MySessionDetails data) => json.encode(data.toJson());

class MySessionDetails {
  int? id;
  int? coachId;
  String? name;
  int? totalSeats;
  String? shortDescription;
  String? categoryId;
  String? categoryName;
  DateTime? sessionDate;
  int? timeSlotId;
  String? sessionImage;
  String? price;
  String? city;
  String? zip;
  String? teacherName;
  num? averageRating;
  int? isExpire;
  String? timeSlot;

  MySessionDetails({
    this.id,
    this.coachId,
    this.name,
    this.totalSeats,
    this.shortDescription,
    this.categoryId,
    this.categoryName,
    this.sessionDate,
    this.timeSlotId,
    this.sessionImage,
    this.price,
    this.city,
    this.zip,
    this.teacherName,
    this.averageRating,
    this.isExpire,
    this.timeSlot,
  });

  factory MySessionDetails.fromJson(Map<String, dynamic> json) => MySessionDetails(
    id: json["id"],
    coachId: json["coach_id"],
    name: json["name"],
    totalSeats: json["total_seats"],
    shortDescription: json["short_description"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    sessionDate: json["session_date"] == null ? null : DateTime.parse(json["session_date"]),
    timeSlotId: json["time_slot_id"],
    sessionImage: json["session_image"],
    price: json["price"],
    city: json["city"],
    zip: json["zip"],
    teacherName: json["teacher_name"],
    averageRating: json["average_rating"]??0,
    isExpire: json["is_expire"],
    timeSlot: json["time_slot"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "coach_id": coachId,
    "name": name,
    "total_seats": totalSeats,
    "short_description": shortDescription,
    "category_id": categoryId,
    "category_name": categoryName,
    "session_date": "${sessionDate!.year.toString().padLeft(4, '0')}-${sessionDate!.month.toString().padLeft(2, '0')}-${sessionDate!.day.toString().padLeft(2, '0')}",
    "time_slot_id": timeSlotId,
    "session_image": sessionImage,
    "price": price,
    "city": city,
    "zip": zip,
    "teacher_name": teacherName,
    "average_rating": averageRating,
    "is_expire": isExpire,
    "time_slot": timeSlot,
  };
}
