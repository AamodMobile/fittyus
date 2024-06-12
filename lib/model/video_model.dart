// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

VideoModel videoModelFromJson(String str) => VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  int? id;
  int? challengePostId;
  int? participantId;
  String? video;
  String? firstName;
  String? lastName;
  String? avatarUrl;
  int? isLike;
  int? challengeLike;
  int? challengeCommentsCount;
  int? commentsCount;
  List<dynamic>? comments;

  VideoModel({
    this.id,
    this.challengePostId,
    this.participantId,
    this.video,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.isLike,
    this.challengeLike,
    this.challengeCommentsCount,
    this.commentsCount,
    this.comments,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    id: json["id"],
    challengePostId: json["challenge_id"],
    participantId: json["participant_id"],
    video: json["video"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatarUrl: json["avatar_url"],
    isLike: json["is_like"],
    challengeLike: json["challenge_like"],
    challengeCommentsCount: json["challenge_comments_count"],
    commentsCount: json["comments_count"],
    comments: json["comments"] == null ? [] : List<dynamic>.from(json["comments"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "challenge_id": challengePostId,
    "participant_id": participantId,
    "video": video,
    "first_name": firstName,
    "last_name": lastName,
    "avatar_url": avatarUrl,
    "is_like": isLike,
    "challenge_like": challengeLike,
    "challenge_comments_count": challengeCommentsCount,
    "comments_count": commentsCount,
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
  };
}
