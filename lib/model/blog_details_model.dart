

import 'dart:convert';

BlogDetailsModel blogDetailsModelFromJson(String str) => BlogDetailsModel.fromJson(json.decode(str));

String blogDetailsModelToJson(BlogDetailsModel data) => json.encode(data.toJson());

class BlogDetailsModel {
  int? id;
  dynamic categoryId;
  dynamic categoryName;
  String? title;
  String? shortDescription;
  String? slug;
  String? image;
  String? description;
  String? date;
  String? status;
  String? metaTitle;
  String? metaKeyword;
  String? metaDescription;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Comment>? comments;

  BlogDetailsModel({
    this.id,
    this.categoryId,
    this.categoryName,
    this.title,
    this.shortDescription,
    this.slug,
    this.image,
    this.description,
    this.date,
    this.status,
    this.metaTitle,
    this.metaKeyword,
    this.metaDescription,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.comments,
  });

  factory BlogDetailsModel.fromJson(Map<String, dynamic> json) => BlogDetailsModel(
    id: json["id"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    title: json["title"],
    shortDescription: json["short_description"],
    slug: json["slug"],
    image: json["image"],
    description: json["description"],
    date: json["date"],
    status: json["status"],
    metaTitle: json["meta_title"],
    metaKeyword: json["meta_keyword"],
    metaDescription: json["meta_description"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "category_name": categoryName,
    "title": title,
    "short_description": shortDescription,
    "slug": slug,
    "image": image,
    "description": description,
    "date": date,
    "status": status,
    "meta_title": metaTitle,
    "meta_keyword": metaKeyword,
    "meta_description": metaDescription,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
  };
}

class Comment {
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

  Comment({
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
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
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
  };
}
