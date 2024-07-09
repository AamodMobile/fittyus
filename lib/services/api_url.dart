class ApiUrl {
  /// Base Url
  static const String baseUrl = "https://www.fittyus.com/fittyus/api/auth/";
  static const String imageBaseUrl = "https://www.fittyus.com/fittyus/public/";

  /// auth
  static const String loginWithMobileApi = "${baseUrl}login";
  static const String loginEmailApi = "${baseUrl}send-email";
  static const String verifyOtpByMobile = "${baseUrl}verify-otp";
  static const String verifyOtpByEmail = "${baseUrl}verify-mail-otp";
  static const String userDetails = "${baseUrl}user/userdetail";
  static const String editProfile = "${baseUrl}user/update-profile";
  static const String viewProfile = "${baseUrl}user/view-profile";


  /// follow and unfollow
  static const String followAndUnfollow = "${baseUrl}user/follow-user";

  /// home
  static const String homeApi = "${baseUrl}user/home";

  ///coach
  static const String coachList = "${baseUrl}user/coach-list";
  static const String coachDetails = "${baseUrl}user/coach-detail";
  static const String coachPlanDetails = "${baseUrl}user/package-list";

  ///blog
  static const String blogList = "${baseUrl}user/blog-lists";
  static const String blogDetails = "${baseUrl}user/blog-detail";
  static const String blogLike = "${baseUrl}user/blog-likes";
  static const String blogCommentList = "${baseUrl}user/comment-list";
  static const String blogAddComment = "${baseUrl}user/add_comment";
  static const String blogDeleteComment = "${baseUrl}user/comment-delete";
  static const String blogCommentLike = "${baseUrl}user/blog-like";

  ///cms
  static const String cmsList = "${baseUrl}user/cms";
  static const String contactDetails = "${baseUrl}user/contact";

  ///notifications
  static const String notification = "${baseUrl}user/notification";
  static const String notificationAllClear = "${baseUrl}user/notification-clear";

  ///categoryList
  static const String categoryList = "${baseUrl}user/category-list";

  ///booking
  static const String addCard = "${baseUrl}user/add-to-cart";
  static const String checkOut = "${baseUrl}user/check-out";
  static const String completeBooking = "${baseUrl}user/book-now";

  ///address
  static const String addAddress = "${baseUrl}user/add-address";
  static const String updateAddress = "${baseUrl}user/update-address";
  static const String addressListGet = "${baseUrl}user/address-list";

  ///rating
  static const String giveRating = "${baseUrl}user/rating";
  static const String myRatingList = "${baseUrl}user/my-rating";

  ///myPlans
  static const String myPlanLists = "${baseUrl}user/my-plan-lists";

  ///couponList
  static const String couponList = "${baseUrl}user/coupon-lists";

  /// sessions
  static const String sessionList = "${baseUrl}user/session-list";

  /// video
  static const String videoAnimation = "${baseUrl}user/gallery";
  static const String videoPlan = "${baseUrl}user/category-package";
  static const String buyVideo = "${baseUrl}user/buy-video";
  static const String videoProgressUpdate = "${baseUrl}user/gallery-video-progress";

  /// Challenge
  static const String challengePost = "${baseUrl}user/challenge-upload_video";
  static const String allChallengeList = "${baseUrl}user/challenge-post-list";
  static const String challengeDetails = "${baseUrl}user/challenge-post-details";
  static const String challengeJoin = "${baseUrl}user/join-challenge";
  static const String challengeVideo = "${baseUrl}user/participant-video";
  static const String challengePostLike = "${baseUrl}user/challenge-likes";
  static const String challengeCommentList = "${baseUrl}user/challenge-comment-list";
  static const String myChallengeList   = "${baseUrl}user/mychallenge-list";
  static const String addChallengeComment   = "${baseUrl}user/add-challenge-comment";
  static const String leaveChallenge   = "${baseUrl}user/leave-challenge";
  static const String challengeLikeList   = "${baseUrl}user/challenge-like-list";
  static const String challengeCommentUpdate   = "${baseUrl}user/update-comment";
  static const String challengeCommentDelete   = "${baseUrl}user/comments-delete";

  /// mySession
  static const String mySessionList   = "${baseUrl}user/user-booked-session-list";
  static const String mySessionDetails   = "${baseUrl}user/session-details";

  /// deleteAc
  static const String deleteAccountApi = "${baseUrl}user/deactivate-user";

  /// search
  static const String search = "${baseUrl}user/search";

  ///community
  static const String communityList = "${baseUrl}user/community-list";
  static const String communityDetails = "${baseUrl}user/community-detail";
  static const String communityLike = "${baseUrl}user/community-likes";
  static const String communityAddComment = "${baseUrl}user/add_community_comment";
  static const String communityAdd="${baseUrl}user/community-add";
  static const String communityDelete="${baseUrl}user/community-delete";
  static const String communityGallery="${baseUrl}user/community-gallery";
  static const String communityUpdate="${baseUrl}user/community-update";
  static const String communityCommentList="${baseUrl}user/community-comment-list";
  static const String communityCommentDelete="${baseUrl}user/community-comment-delete";
  static const String communityCommentLike="${baseUrl}user/community-comment-like";

  /// Update FCM Token
  static const String fcmTokenUpdate = "${baseUrl}user/device_key_update";
}


