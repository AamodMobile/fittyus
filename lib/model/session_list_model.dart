// To parse this JSON data, do
//
//     final sessionListModel = sessionListModelFromJson(jsonString);

import 'dart:convert';

SessionListModel sessionListModelFromJson(String str) =>
    SessionListModel.fromJson(json.decode(str));

String sessionListModelToJson(SessionListModel data) =>
    json.encode(data.toJson());

class SessionListModel {
  int? id;
  int? coachId;
  String? name;
  int? totalSeats;
  String? shortDescription;
  String? categoryId;
  String? categoryName;
  String? sessionDate;
  int? variationId;
  String? coachName;
  int? reservedSeat;
  int? remainingSeat;
  String? timeslots;
  String? city;
  String? zip;
  String? price;
  int? timeSlotId;
  int? isUser;
  String? sessionImage;

  SessionListModel(
      {this.id,
      this.coachId,
      this.name,
      this.totalSeats,
      this.shortDescription,
      this.categoryId,
      this.categoryName,
      this.sessionDate,
      this.variationId,
      this.coachName,
      this.reservedSeat,
      this.remainingSeat,
      this.timeslots,
      this.city,
      this.zip,
      this.price,
      this.timeSlotId,
      this.sessionImage,
      this.isUser});

  factory SessionListModel.fromJson(Map<String, dynamic> json) =>
      SessionListModel(
        id: json["id"],
        coachId: json["coach_id"],
        name: json["name"],
        totalSeats: json["total_seats"],
        shortDescription: json["short_description"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        sessionDate: json["session_date"],
        variationId: json["variation_id"],
        coachName: json["coach_name"],
        reservedSeat: json["reserved_seat"],
        remainingSeat: json["remaining_seat"],
        timeslots: json["timeslots"],
        city: json["city"],
        zip: json["zip"],
        price: json["price"],
        timeSlotId: json["time_slot_id"],
        isUser: json["is_user"],
        sessionImage: json["session_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "coach_id": coachId,
        "name": name,
        "total_seats": totalSeats,
        "short_description": shortDescription,
        "category_id": categoryId,
        "category_name": categoryName,
        "session_date": sessionDate,
        "variation_id": variationId,
        "coach_name": coachName,
        "reserved_seat": reservedSeat,
        "remaining_seat": remainingSeat,
        "timeslots": timeslots,
        "city": city,
        "zip": zip,
        "price": price,
        "time_slot_id": timeSlotId,
        "is_user": isUser,
        "session_image": sessionImage,
      };
}
