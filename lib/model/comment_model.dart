// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  int? id;
  String? userId;
  String? blogId;
  int? parentId;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? like;
  int? dislike;
  int? likecounts;
  int? dislikecounts;
  String? username;
  String? image;
  List<Reply>? replies;


  CommentModel({
    this.id,
    this.userId,
    this.blogId,
    this.parentId,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.like,
    this.dislike,
    this.likecounts,
    this.dislikecounts,
    this.username,
    this.image,
    this.replies,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json["id"],
    userId: json["user_id"],
    blogId: json["blog_id"],
    parentId: json["parent_id"],
    message: json["message"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    like: json["like"],
    dislike: json["dislike"],
    likecounts: json["likecounts"],
    dislikecounts: json["dislikecounts"],
    username: json["username"],
    image: json["image"],
    replies: json["replies"] == null ? [] : List<Reply>.from(json["replies"]!.map((x) => Reply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "blog_id": blogId,
    "parent_id": parentId,
    "message": message,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "like": like,
    "dislike": dislike,
    "likecounts": likecounts,
    "dislikecounts": dislikecounts,
    "username": username,
    "image": image,
    "replies": replies == null ? [] : List<dynamic>.from(replies!.map((x) => x.toJson())),
  };
}

class Reply {
  int? id;
  String? userId;
  String? blogId;
  int? parentId;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? username;
  String? image;

  Reply({
    this.id,
    this.userId,
    this.blogId,
    this.parentId,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.image,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    id: json["id"],
    userId: json["user_id"],
    blogId: json["blog_id"],
    parentId: json["parent_id"],
    message: json["message"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    username: json["username"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "blog_id": blogId,
    "parent_id": parentId,
    "message": message,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "username": username,
    "image": image,
  };
}
