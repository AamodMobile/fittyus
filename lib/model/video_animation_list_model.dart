class AnimationVideoListModel {
  int? id;
  String? title;
  String? image;
  num? totalVideoSeconds;
  dynamic totalMinutes;
  List<Media> media;

  AnimationVideoListModel({
    this.id,
    this.title,
    this.image,
    this.totalVideoSeconds,
    this.totalMinutes,
    required this.media,
  });

  factory AnimationVideoListModel.fromJson(Map<String, dynamic> json) => AnimationVideoListModel(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    totalVideoSeconds: json["total_video_seconds"],
    totalMinutes: json["total_video_minutes"],
    media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "total_video_seconds": totalVideoSeconds,
    "total_video_minutes": totalMinutes,
    "media": media == null ? [] : List<dynamic>.from(media.map((x) => x.toJson())),
  };
}

class Media {
  int? id;
  int? categoryId;
  String? title;
  String? subTitle;
  String? media;
  String? link;
  String? category;
  int? isLock;
  num? totalMinutes;
  num? totalSeconds;
  String? previousWatchTime;
  Media({
    this.id,
    this.categoryId,
    this.title,
    this.subTitle,
    this.media,
    this.link,
    this.category,
    this.isLock,
    this.totalMinutes,
    this.totalSeconds,
    this.previousWatchTime,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"],
    subTitle: json["sub_title"],
    media: json["media"],
    link: json["link"],
    category: json["category"],
    isLock: json["is_lock"],
    totalMinutes: json["total_minutes"],
    totalSeconds: json["total_seconds"],
    previousWatchTime: json["previous_watch_time"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "sub_title": subTitle,
    "media": media,
    "link": link,
    "category": category,
    "is_lock": isLock,
    "total_minutes": totalMinutes,
    "total_seconds": totalSeconds,
    "previous_watch_time": previousWatchTime,
  };
}
