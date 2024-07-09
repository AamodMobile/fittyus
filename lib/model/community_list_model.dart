class CommunityListModel {
  int? id;
  dynamic title;
  String? shortDescription;
  String? date;
  String? status;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic afterImage;
  dynamic beforeImg;
  String? type;
  int? userId;
  String? firstName;
  String? lastName;
  String? profileImage;
  dynamic countryCode;
  String? mobile;
  List<Comment>? comments;
  int? isLike;
  int? communityCount;
  int? commentsCount;
  List<CommunityImage>? communityImages;

  CommunityListModel({
    this.id,
    this.title,
    this.shortDescription,
    this.date,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.afterImage,
    this.beforeImg,
    this.type,
    this.userId,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.countryCode,
    this.mobile,
    this.comments,
    this.isLike,
    this.communityCount,
    this.commentsCount,
    this.communityImages,
  });

  factory CommunityListModel.fromJson(Map<String, dynamic> json) => CommunityListModel(
    id: json["id"],
    title: json["title"],
    shortDescription: json["short_description"],
    date: json["date"],
    status: json["status"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    afterImage: json["after_image"],
    beforeImg: json["before_image"],
    type: json["type"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    profileImage: json["profile_image"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
    isLike: json["is_like"],
    communityCount: json["community_count"],
    commentsCount: json["comments_count"],
    communityImages: json["community_images"] == null ? [] : List<CommunityImage>.from(json["community_images"]!.map((x) => CommunityImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "short_description": shortDescription,
    "date": date,
    "status": status,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "after_image": afterImage,
    "before_image": beforeImg,
    "type": type,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "profile_image": profileImage,
    "country_code": countryCode,
    "mobile": mobile,
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
    "is_like": isLike,
    "community_count": communityCount,
    "comments_count": commentsCount,
    "community_images": communityImages == null ? [] : List<dynamic>.from(communityImages!.map((x) => x.toJson())),
  };
}


class Comment {
  String? userImage;
  int? id;
  String? userId;
  String? communityId;
  int? parentId;
  int? like;
  int? dislike;
  String? message;
  DateTime? createdAt;
  dynamic userName;
  List<Reply>? replies;

  Comment({
    this.userImage,
    this.id,
    this.userId,
    this.communityId,
    this.parentId,
    this.like,
    this.dislike,
    this.message,
    this.createdAt,
    this.userName,
    this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    userImage: json["user_image"]??"",
    id: json["id"],
    userId: json["user_id"],
    communityId: json["community_id"],
    parentId: json["parent_id"],
    like: json["like"],
    dislike: json["dislike"],
    message: json["message"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    userName: json["user_name"],
    replies: json["replies"] == null ? [] : List<Reply>.from(json["replies"]!.map((x) => Reply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_image": userImage,
    "id": id,
    "user_id": userId,
    "community_id": communityId,
    "parent_id": parentId,
    "like": like,
    "dislike": dislike,
    "message": message,
    "created_at": createdAt?.toIso8601String(),
    "user_name": userName,
    "replies": replies == null ? [] : List<dynamic>.from(replies!.map((x) => x.toJson())),
  };
}

class Reply {
  int? id;
  String? userId;
  String? communityId;
  int? parentId;
  String? message;
  DateTime? createdAt;
  String? username;
  String? image;

  Reply({
    this.id,
    this.userId,
    this.communityId,
    this.parentId,
    this.message,
    this.createdAt,
    this.username,
    this.image,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    id: json["id"],
    userId: json["user_id"],
    communityId: json["community_id"],
    parentId: json["parent_id"],
    message: json["message"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    username: json["username"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "community_id": communityId,
    "parent_id": parentId,
    "message": message,
    "created_at": createdAt?.toIso8601String(),
    "username": username,
    "image": image,
  };
}

class CommunityImage {
  int? id;
  int? communityId;
  String? image;
  CommunityImage({
    this.id,
    this.communityId,
    this.image,
  });

  factory CommunityImage.fromJson(Map<String, dynamic> json) => CommunityImage(
    id: json["id"],
    communityId: json["community_id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "community_id": communityId,
    "image": image,
  };
}
