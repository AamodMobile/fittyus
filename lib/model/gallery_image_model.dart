class GalleryImageModel {
  int? id;
  int? communityId;
  String? image;

  GalleryImageModel({
    this.id,
    this.communityId,
    this.image,
  });

  factory GalleryImageModel.fromJson(Map<String, dynamic> json) => GalleryImageModel(
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
