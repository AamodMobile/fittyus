class BlogList {
  int? id;
  dynamic categoryId;
  dynamic categoryName;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? countryCode;
  String? mobile;
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
  int? isBlogLike;
  int? blogCount;
  int? commentsCount;

  BlogList({
    this.id,
    this.categoryId,
    this.categoryName,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.countryCode,
    this.mobile,
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
    this.isBlogLike,
    this.blogCount,
    this.commentsCount,
  });

  factory BlogList.fromJson(Map<String, dynamic> json) => BlogList(
    id: json["id"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    profileImage: json["profile_image"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
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
    isBlogLike: json["is_blog_like"],
    blogCount: json["blog_count"],
    commentsCount: json["comments_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "category_name": categoryName,
    "first_name": firstName,
    "last_name": lastName,
    "profile_image": profileImage,
    "country_code": countryCode,
    "mobile": mobile,
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
    "is_blog_like": isBlogLike,
    "blog_count": blogCount,
    "comments_count": commentsCount,
  };
}