import 'dart:convert';

CoachDetailsModel coachDetailsModelFromJson(String str) => CoachDetailsModel.fromJson(json.decode(str));

String coachDetailsModelToJson(CoachDetailsModel data) => json.encode(data.toJson());

class CoachDetailsModel {
  int? id;
  String? name;
  String? aboutTeacher;
  String? image;
  String? averageRating;
  List<CoachMedia>? coachMedia;
  List<CoachCertificate>? coachCertificate;
  List<FeedbackList> feedbackList;
  num? reviewCount;
  num? rating;
  num? ratingPer1;
  num? ratingPer2;
  num? ratingPer3;
  num? ratingPer4;
  num? ratingPer5;
  dynamic postCode;
  List<TimeSlot>? timeslots;

  CoachDetailsModel({
    this.id,
    this.name,
    this.aboutTeacher,
    this.image,
    this.averageRating,
    this.coachMedia,
    this.coachCertificate,
    required this.feedbackList,
    this.reviewCount,
    this.rating,
    this.ratingPer1,
    this.ratingPer2,
    this.ratingPer3,
    this.ratingPer4,
    this.ratingPer5,
    this.postCode,
    this.timeslots,
  });

  factory CoachDetailsModel.fromJson(Map<String, dynamic> json) => CoachDetailsModel(
        id: json["coach_id"],
        name: json["name"],
        aboutTeacher: json["about_teacher"],
        image: json["image"],
        averageRating: json["average_rating"],
        reviewCount: json["reviewcount"],
        rating: json["rating"],
        ratingPer1: json["rating_per_1"],
        ratingPer2: json["rating_per_2"],
        ratingPer3: json["rating_per_3"],
        ratingPer4: json["rating_per_4"],
        ratingPer5: json["rating_per_5"],
        coachMedia: json["coach_media"] == null ? [] : List<CoachMedia>.from(json["coach_media"]!.map((x) => CoachMedia.fromJson(x))),
        coachCertificate: json["coach_certificate"] == null ? [] : List<CoachCertificate>.from(json["coach_certificate"]!.map((x) => CoachCertificate.fromJson(x))),
        feedbackList: json["feedbacklist"] == null ? [] : List<FeedbackList>.from(json["feedbacklist"]!.map((x) => FeedbackList.fromJson(x))),
        postCode: json["post_code"],
        timeslots: json["time_slots"] == null ? [] : List<TimeSlot>.from(json["time_slots"]!.map((x) => TimeSlot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "coach_id": id,
        "name": name,
        "about_teacher": aboutTeacher,
        "image": image,
        "average_rating": averageRating,
        "reviewcount": reviewCount,
        "rating": rating,
        "rating_per_1": ratingPer1,
        "rating_per_2": ratingPer2,
        "rating_per_3": ratingPer3,
        "rating_per_4": ratingPer4,
        "rating_per_5": ratingPer5,
        "coach_media": coachMedia == null ? [] : List<dynamic>.from(coachMedia!.map((x) => x.toJson())),
        "coach_certificate": coachCertificate == null ? [] : List<dynamic>.from(coachCertificate!.map((x) => x.toJson())),
        "post_code": postCode,
        "timeslots": timeslots == null ? [] : List<dynamic>.from(timeslots!.map((x) => x.toJson())),
      };
}

class CoachCertificate {
  int? id;
  int? teacherId;
  String? certificateTitle;
  String? certificateDescription;
  String? startDate;
  String? endDate;
  String? certificateImage;

  CoachCertificate({
    this.id,
    this.teacherId,
    this.certificateTitle,
    this.certificateDescription,
    this.startDate,
    this.endDate,
    this.certificateImage,
  });

  factory CoachCertificate.fromJson(Map<String, dynamic> json) => CoachCertificate(
        id: json["id"],
        teacherId: json["teacher_id"],
        certificateTitle: json["certificate_title"] ?? "Certificate",
        certificateDescription: json["certificate_description"] ?? "",
        startDate: json["start_date"] ?? "",
        endDate: json["end_date"] ?? "",
        certificateImage: json["certificate_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacher_id": teacherId,
        "certificate_title": certificateTitle,
        "certificate_description": certificateDescription,
        "start_date": startDate,
        "end_date": endDate,
        "certificate_image": certificateImage,
      };
}

class CoachMedia {
  int? id;
  int? teacherId;
  String? fileType;
  String? file;
  dynamic fileUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  CoachMedia({
    this.id,
    this.teacherId,
    this.fileType,
    this.file,
    this.fileUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory CoachMedia.fromJson(Map<String, dynamic> json) => CoachMedia(
        id: json["id"],
        teacherId: json["teacher_id"],
        fileType: json["file_type"],
        file: json["file"],
        fileUrl: json["file_url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacher_id": teacherId,
        "file_type": fileType,
        "file": file,
        "file_url": fileUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class FeedbackList {
  int? id;
  String? userId;
  String? userName;
  String? classId;
  int? coachId;
  String? className;
  dynamic suggestionId;
  dynamic suggestionTitle;
  String? feedback;
  String? rating;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  FeedbackList({
    this.id,
    this.userId,
    this.userName,
    this.classId,
    this.coachId,
    this.className,
    this.suggestionId,
    this.suggestionTitle,
    this.feedback,
    this.rating,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory FeedbackList.fromJson(Map<String, dynamic> json) => FeedbackList(
        id: json["id"],
        userId: json["user_id"],
        userName: json["user_name"],
        classId: json["class_id"],
        coachId: json["coach_id"],
        className: json["class_name"],
        suggestionId: json["suggestion_id"],
        suggestionTitle: json["suggestion_title"],
        feedback: json["feedback"],
        rating: json["rating"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_name": userName,
        "class_id": classId,
        "coach_id": coachId,
        "class_name": className,
        "suggestion_id": suggestionId,
        "suggestion_title": suggestionTitle,
        "feedback": feedback,
        "rating": rating,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class TimeSlot {
  int? id;
  int? categoryId;
  String? timeSlots;
  DateTime? createdAt;
  DateTime? updatedAt;

  TimeSlot({
    this.id,
    this.categoryId,
    this.timeSlots,
    this.createdAt,
    this.updatedAt,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
        id: json["id"],
        categoryId: json["category_id"],
        timeSlots: json["time_slots"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "time_slots": timeSlots,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
