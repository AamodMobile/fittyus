
import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  bool? status;
  List<Banners> banner;
  List<TeacherList> teacherList;
  List<Category> category;
  List<Blog> blog;
  String? message;

  HomeModel({
    this.status,
    required this.banner,
    required this.teacherList,
    required this.category,
    required this.blog,
    this.message,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    status: json["status"],
    banner: json["banner"] == null ? [] : List<Banners>.from(json["banner"]!.map((x) => Banners.fromJson(x))),
    teacherList: json["teacher_lists"] == null ? [] : List<TeacherList>.from(json["teacher_lists"]!.map((x) => TeacherList.fromJson(x))),
    category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
    blog: json["blog"] == null ? [] : List<Blog>.from(json["blog"]!.map((x) => Blog.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "banner": banner == null ? [] : List<dynamic>.from(banner.map((x) => x.toJson())),
    "teacher_lists": teacherList == null ? [] : List<dynamic>.from(teacherList.map((x) => x.toJson())),
    "category": category == null ? [] : List<dynamic>.from(category.map((x) => x.toJson())),
    "blog": blog == null ? [] : List<dynamic>.from(blog.map((x) => x.toJson())),
    "message": message,
  };
}

class Banners {
  int? id;
  String? banner;
  String? link;
  String? title;
  String? description;
  int? status;

  Banners({
    this.id,
    this.banner,
    this.link,
    this.status,
    this.title,
    this.description,
  });

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
    id: json["id"],
    banner: json["banner"],
    link: json["link"],
    status: json["status"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "banner": banner,
    "link": link,
    "status": status,
    "title": title,
    "description": description,
  };
}

class Category {
  int? id;
  String? title;
  String? image;

  Category({
    this.id,
    this.title,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
  };
}

class TeacherList {
  int? id;
  String? name;
  String? image;
  String? averageRating;

  TeacherList({
    this.id,
    this.name,
    this.image,
    this.averageRating,
  });

  factory TeacherList.fromJson(Map<String, dynamic> json) => TeacherList(
    id: json["coach_id"],
    name: json["name"],
    image: json["image"],
    averageRating: json["average_rating"],
  );

  Map<String, dynamic> toJson() => {
    "coach_id": id,
    "name": name,
    "image": image,
    "average_rating": averageRating,
  };

}
class Blog {
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
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isBlogLike;
  int? blogCount;
  int? commentsCount;

  Blog({
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
    this.createdAt,
    this.updatedAt,
    this.isBlogLike,
    this.blogCount,
    this.commentsCount,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "is_blog_like": isBlogLike,
    "blog_count": blogCount,
    "comments_count": commentsCount,
  };
}

