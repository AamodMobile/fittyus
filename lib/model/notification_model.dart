class NotificationModel {
  int? id;
  String? title;
  String? description;
  String? image;
  String? date;

  NotificationModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.image,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date,
        "image": image,
      };
}
