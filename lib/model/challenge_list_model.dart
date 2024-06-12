import 'dart:convert';

ChallengeListModel challengeListModelFromJson(String str) =>
    ChallengeListModel.fromJson(json.decode(str));

String challengeListModelToJson(ChallengeListModel data) =>
    json.encode(data.toJson());

class ChallengeListModel {
  int? id;
  int? createdBy;
  String? title;
  String? video;
  String? description;
  String? startDate;
  String? endDate;
  int? status;
  String? firstName;
  dynamic lastName;
  String? avatarUrl;
  String? challengeBanner;
  dynamic totalParticipants;
  List<ParticipantPost>? participantPost;

  ChallengeListModel({
    this.id,
    this.createdBy,
    this.title,
    this.video,
    this.description,
    this.startDate,
    this.endDate,
    this.status,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.totalParticipants,
    this.participantPost,
    this.challengeBanner,
  });

  factory ChallengeListModel.fromJson(Map<String, dynamic> json) =>
      ChallengeListModel(
        id: json["id"],
        createdBy: json["created_by"],
        title: json["title"],
        video: json["video"],
        description: json["description"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        status: json["status"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatarUrl: json["avatar_url"],
        challengeBanner: json["challenge_banner"],
        totalParticipants: json["total_participants"],
        participantPost: json["participant_post"] == null
            ? []
            : List<ParticipantPost>.from(json["participant_post"]!.map((x) => ParticipantPost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "title": title,
        "video": video,
        "description": description,
        "start_date": startDate,
        "end_date": endDate,
        "status": status,
        "first_name": firstName,
        "last_name": lastName,
        "avatar_url": avatarUrl,
        "challenge_banner": challengeBanner,
        "total_participants": totalParticipants,
        "participant_post": participantPost == null
            ? []
            : List<dynamic>.from(participantPost!.map((x) => x.toJson())),
      };
}

class ParticipantPost {
  int? id;
  int? challengePostId;
  int? participantId;
  String? video;
  String? firstName;
  String? lastName;
  String? avatarUrl;
  String? videoThumbnail;

  ParticipantPost(
      {this.id,
      this.challengePostId,
      this.participantId,
      this.video,
      this.firstName,
      this.lastName,
      this.avatarUrl,
      this.videoThumbnail});

  factory ParticipantPost.fromJson(Map<String, dynamic> json) =>
      ParticipantPost(
        id: json["id"],
        challengePostId: json["challenge_post_id"],
        participantId: json["participant_id"],
        video: json["video"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatarUrl: json["avatar_url"],
        videoThumbnail: json["video_thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "challenge_post_id": challengePostId,
        "participant_id": participantId,
        "video": video,
        "first_name": firstName,
        "last_name": lastName,
        "avatar_url": avatarUrl,
        "video_thumbnail": videoThumbnail,
      };
}
