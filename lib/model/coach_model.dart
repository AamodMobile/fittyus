import 'package:fittyus/model/coach_details_model.dart';

class CoachList {
  int? id;
  String? name;
  String? image;
  String? profileImage;
  String? averageRating;
  String? coachType;
  List<TimeSlot>? timeslots;


  CoachList({
    this.id,
    this.name,
    this.image,
    this.profileImage,
    this.averageRating,
    this.coachType,
    this.timeslots,
  });

  factory CoachList.fromJson(Map<String, dynamic> json) => CoachList(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    profileImage: json["profile_image"],
    averageRating: json["averageRating"],
    coachType: json["coach_type"],
    timeslots: json["timeslots"]==null?[]:List<TimeSlot>.from(json["timeslots"]!.map((x) => TimeSlot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "profile_image": profileImage,
    "averageRating": averageRating,
    "coach_type": coachType,
    "timeslots":timeslots == null ? [] : List<dynamic>.from(timeslots!.map((x) => x.toJson())),
  };

}