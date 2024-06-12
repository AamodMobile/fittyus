class MyChallenge {
  int? id;
  int? challengePostId;
  int? participantId;
  String? title;
  String? startDate;
  String? endDate;
  int? totalParticipant;
  List<PaticipantPost>? paticipantPost;

  MyChallenge({
    this.id,
    this.challengePostId,
    this.participantId,
    this.title,
    this.startDate,
    this.endDate,
    this.totalParticipant,
    this.paticipantPost,
  });

  factory MyChallenge.fromJson(Map<String, dynamic> json) => MyChallenge(
        id: json["id"],
        challengePostId: json["challenge_post_id"],
        participantId: json["participant_id"],
        title: json["title"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        totalParticipant: json["total_participant"],
        paticipantPost: json["paticipant_post"] == null
            ? []
            : List<PaticipantPost>.from(json["paticipant_post"]!
                .map((x) => PaticipantPost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "challenge_post_id": challengePostId,
        "participant_id": participantId,
        "title": title,
        "start_date": startDate,
        "end_date": endDate,
        "total_participant": totalParticipant,
        "paticipant_post": paticipantPost == null
            ? []
            : List<dynamic>.from(paticipantPost!.map((x) => x.toJson())),
      };
}

class PaticipantPost {
  int? id;
  int? userId;
  int? challengeId;
  String? video;
  String? videoThumbnail;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userName;

  PaticipantPost({
    this.id,
    this.userId,
    this.challengeId,
    this.video,
    this.videoThumbnail,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.userName,
  });

  factory PaticipantPost.fromJson(Map<String, dynamic> json) => PaticipantPost(
        id: json["id"],
        userId: json["user_id"],
        challengeId: json["challenge_id"],
        video: json["video"],
        videoThumbnail: json["video_thumbnail"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userName: json["user_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "challenge_id": challengeId,
        "video": video,
        "video_thumbnail": videoThumbnail,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_name": userName,
      };
}
