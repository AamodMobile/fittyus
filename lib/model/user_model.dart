class UserModel {
  int id = 0, isNotification = 0;
  String googleId = "",
      email = "",
      firstName = "",
      lastName = "",
      role = "",
      gender = "",
      username = "",
      isPayingCustomer = "",
      avatarUrl = "",
      referalCode = "",
      referCode = "",
      registerOtp = "",
      deviceKey = "",
      emailVerifiedAt = "",
      verifyOtpStatus = "",
      address = "",
      city = "",
      state = "",
      country = "",
      profileImage = "",
      billingCompany = "",
      countryCode = "",
      mobile = "",
      mobileWithCountry = "",
      notification = "",
      occupation = "",
      status = "";
     // userDetail = "";

  UserModel(
      this.id,
      this.isNotification,
      this.googleId,
      this.email,
      this.firstName,
      this.lastName,
      this.role,
      this.gender,
      this.username,
      this.isPayingCustomer,
      this.avatarUrl,
      this.referCode,
      this.referalCode,
      this.registerOtp,
      this.deviceKey,
      this.emailVerifiedAt,
      this.verifyOtpStatus,
      this.address,
      this.city,
      this.state,
      this.country,
      this.profileImage,
      this.billingCompany,
      this.countryCode,
      this.mobile,
      this.mobileWithCountry,
      this.notification,
      this.occupation,
      this.status,
      //this.userDetail
      );

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isNotification = json['is_notification']??0;
    googleId = json['google_id'] ?? '';
    email = json['email'] ?? '';
    firstName = json['first_name'] ?? '';
    lastName = json['last_name'] ?? '';
    role = json['role'] ?? '';
    gender = json['gender'] ?? '';
    username = json['username'] ?? '';
    isPayingCustomer = json['is_paying_customer'] ?? '';
    avatarUrl = json['avatar_url'] ?? '';
    referalCode = json['referal_code'] ?? '';
    referCode = json['refer_code'] ?? '';
    registerOtp = json['register_otp'] ?? '';
    deviceKey = json['device_key'] ?? '';
    emailVerifiedAt = json['email_verified_at'] ?? '';
    verifyOtpStatus = json['verify_otp_status'] ?? '';
    address = json['address'] ?? '';
    city = json['city'] ?? '';
    state = json['state'] ?? '';
    country = json['country'] ?? '';
    profileImage = json['profile_image'] ?? '';
    billingCompany = json['billing_company'] ?? '';
    countryCode = json['country_code'] ?? '';
    mobile = json['mobile'] ?? '';
    mobileWithCountry = json['mobile_withcountry'] ?? '';
    notification = json['notification'] ?? '';
    occupation = json['occupation'] ?? '';
    status = json['status'] ?? '';
    //userDetail = json['user_detail'] ?? '';
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['google_id'] = googleId;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['role'] = role;
    data['gender'] = gender;
    data['username'] = username;
    data['is_paying_customer'] = isPayingCustomer;
    data['avatar_url'] = avatarUrl;
    data['referal_code'] = referalCode;
    data['refer_code'] = referCode;
    data['register_otp'] = registerOtp;
    data['device_key'] = deviceKey;
    data['email_verified_at'] = emailVerifiedAt;
    data['verify_otp_status'] = verifyOtpStatus;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['profile_image'] = profileImage;
    data['billing_company'] = billingCompany;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['mobile_withcountry'] = mobileWithCountry;
    data['notification'] = notification;
    data['occupation'] = occupation;
    data['status'] = status;
   // data['user_detail'] = userDetail;
    return data;
  }
}
