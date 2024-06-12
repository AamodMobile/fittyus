class AddressList {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? country;
  String? state;
  String? city;
  String? mobile;
  String? address;

  AddressList({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.country,
    this.state,
    this.city,
    this.mobile,
    this.address,
  });

  factory AddressList.fromJson(Map<String, dynamic> json) => AddressList(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        mobile: json["mobile"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "country": country,
        "state": state,
        "city": city,
        "mobile": mobile,
        "address": address,
      };
}
