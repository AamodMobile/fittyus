// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

LikeListModel likeListModelFromJson(String str) =>
    LikeListModel.fromJson(json.decode(str));

String likeListModelToJson(LikeListModel data) => json.encode(data.toJson());

class LikeListModel {
  int? id;
  String? userId;
  String? challengePostId;
  dynamic commentId;
  String? isLike;
  String? fullName;
  String? image;

  LikeListModel({
    this.id,
    this.userId,
    this.challengePostId,
    this.commentId,
    this.isLike,
    this.fullName,
    this.image,
  });

  factory LikeListModel.fromJson(Map<String, dynamic> json) => LikeListModel(
        id: json["id"],
        userId: json["user_id"],
        challengePostId: json["challengepost_id"],
        commentId: json["comment_id"],
        isLike: json["is_like"],
        fullName: json["full_name"],
        image: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "challengepost_id": challengePostId,
        "comment_id": commentId,
        "is_like": isLike,
        "full_name": fullName,
        "profile_image": image,
      };
}
