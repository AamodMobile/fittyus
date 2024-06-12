class MyRatingListModel {
  int? id;
  String? rating;
  String? feedback;
  String? feedbackImages;
  String? status;
  String? name;
  String? teacherImage;
  String? coachType;

  MyRatingListModel({
    this.id,
    this.rating,
    this.feedback,
    this.feedbackImages,
    this.status,
    this.name,
    this.teacherImage,
    this.coachType,
  });

  factory MyRatingListModel.fromJson(Map<String, dynamic> json) =>
      MyRatingListModel(
        id: json["id"],
        rating: json["rating"],
        feedback: json["feedback"],
        feedbackImages: json["feedback_images"],
        status: json["status"],
        name: json["name"],
        teacherImage: json["teacher_image"],
        coachType: json["coach_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
        "feedback": feedback,
        "feedback_images": feedbackImages,
        "status": status,
        "name": name,
        "teacher_image": teacherImage,
        "coach_type": coachType,
      };
}
