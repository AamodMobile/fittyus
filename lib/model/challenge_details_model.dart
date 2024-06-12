class ChallengeDetailsModel {
  int? id;
  int? createdBy;
  String? title;
  String? video;
  String? description;
  String? activityLevel;
  String? challengeBanner;
  String? startDate;
  String? endDate;
  int? status;
  String? firstName;
  String? lastName;
  String? avatarUrl;
  String? price;
  List<ParticipantPost1>? participantPost;
  int? isJoin;
  String? challengeImage;
  String? challengeAttachment;
  ChallengeDetailsModel({
    this.id,
    this.createdBy,
    this.title,
    this.video,
    this.description,
    this.activityLevel,
    this.challengeBanner,
    this.startDate,
    this.endDate,
    this.status,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.price,
    this.participantPost,
    this.isJoin,
    this.challengeImage,
    this.challengeAttachment,
  });

  factory ChallengeDetailsModel.fromJson(Map<String, dynamic> json) =>
      ChallengeDetailsModel(
        id: json["id"],
        createdBy: json["created_by"],
        title: json["title"],
        video: json["video"],
        description: json["description"],
        activityLevel: json["activity_level"],
        challengeBanner: json["challenge_banner"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        status: json["status"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatarUrl: json["avatar_url"],
        price: json["price"],
        challengeImage: json["challenge_image"],
        challengeAttachment: json["challenge_attachment"],
        participantPost: json["participant_post"] == null
            ? []
            : List<ParticipantPost1>.from(json["participant_post"]!
                .map((x) => ParticipantPost1.fromJson(x))),
        isJoin: json["is_join"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "title": title,
        "video": video,
        "description": description,
        "activity_level": activityLevel,
        "challenge_banner": challengeBanner,
        "start_date": startDate,
        "end_date": endDate,
        "status": status,
        "first_name": firstName,
        "last_name": lastName,
        "avatar_url": avatarUrl,
        "price": price,
        "challenge_image": challengeImage,
        "challenge_attachment": challengeAttachment,
        "participant_post": participantPost == null
            ? []
            : List<dynamic>.from(participantPost!.map((x) => x.toJson())),
        "is_join": isJoin,
      };
}

class ParticipantPost1 {
  int? id;
  int? userId;
  int? challengeId;
  String? video;
  String? videoThumbnail;
  String? description;
  String? userName;
  String? profileImage;
  dynamic challengeTitle;
  dynamic occupation;
  ParticipantPost1({
    this.id,
    this.userId,
    this.challengeId,
    this.video,
    this.videoThumbnail,
    this.description,
    this.userName,
    this.profileImage,
    this.occupation,
    this.challengeTitle
  });

  factory ParticipantPost1.fromJson(Map<String, dynamic> json) =>
      ParticipantPost1(
        id: json["id"],
        userId: json["user_id"],
        challengeId: json["challenge_id"],
        video: json["video"],
        videoThumbnail: json["video_thumbnail"],
        description: json["description"],
        userName: json["user_name"],
        profileImage: json["profile_image"],
        occupation: json["occupation"],
        challengeTitle: json["challenge_title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "challenge_id": challengeId,
        "video": video,
        "video_thumbnail": videoThumbnail,
        "description": description,
        "user_name": userName,
        "profile_image": profileImage,
        "occupation": occupation,
        "challenge_title": challengeTitle,
      };
}
