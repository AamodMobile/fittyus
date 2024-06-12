import 'package:fittyus/model/community_list_model.dart';

class ViewProfileModel {
  int? id;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? profileBackCover;
  int? followingCount;
  int? followerCount;
  int? isFollowers;
  List<FollowersList>? followersList;
  List<FollowersList>? followingList;
  List<Community>? community;

  ViewProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.profileBackCover,
    this.followingCount,
    this.followerCount,
    this.isFollowers,
    this.followersList,
    this.followingList,
    this.community,
  });

  factory ViewProfileModel.fromJson(Map<String, dynamic> json) => ViewProfileModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    profileImage: json["profile_image"],
    profileBackCover: json["profile_back_cover"],
    followingCount: json["following_count"],
    followerCount: json["follower_count"],
    isFollowers: json["is_followers"],
    followersList: json["followers_list"] == null ? [] : List<FollowersList>.from(json["followers_list"]!.map((x) => FollowersList.fromJson(x))),
    followingList: json["following_list"] == null ? [] : List<FollowersList>.from(json["following_list"]!.map((x) => FollowersList.fromJson(x))),
    community: json["community"] == null ? [] : List<Community>.from(json["community"]!.map((x) => Community.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "profile_image": profileImage,
    "profile_back_cover": profileBackCover,
    "following_count": followingCount,
    "follower_count": followerCount,
    "is_followers": isFollowers,
    "followers_list": followersList == null ? [] : List<dynamic>.from(followersList!.map((x) => x.toJson())),
    "following_list": followingList == null ? [] : List<dynamic>.from(followingList!.map((x) => x.toJson())),
    "community": community == null ? [] : List<dynamic>.from(community!.map((x) => x.toJson())),
  };
}

class Community {
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

  Community({
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

  factory Community.fromJson(Map<String, dynamic> json) => Community(
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




class FollowersList {
  String? firstName;
  String? lastName;
  String? profileImage;
  int? id;
  int? followingId;
  int? followerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  FollowersList({
    this.firstName,
    this.lastName,
    this.profileImage,
    this.id,
    this.followingId,
    this.followerId,
    this.createdAt,
    this.updatedAt,
  });

  factory FollowersList.fromJson(Map<String, dynamic> json) => FollowersList(
    firstName: json["first_name"],
    lastName: json["last_name"],
    profileImage: json["profile_image"],
    id: json["id"],
    followingId: json["following_id"],
    followerId: json["follower_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "profile_image": profileImage,
    "id": id,
    "following_id": followingId,
    "follower_id": followerId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
