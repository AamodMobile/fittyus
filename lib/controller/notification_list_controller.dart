import 'dart:convert';
import 'package:fittyus/model/notification_model.dart';

import '../constants/constants.dart';
import '../services/api_services.dart';

class NotificationListController extends GetxController implements GetxService {
  var notificationList = <NotificationModel>[].obs;
  bool isLoading = true;
  var unreadNotification = "".obs;

  Future<void> getNotificationListApi() async {
    try {
      notificationList.clear();
      var result = await ApiServices.notificationList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        unreadNotification.value = json["unread_notification"].toString();
        notificationList.value = List<NotificationModel>.from(json['data'].map((i) => NotificationModel.fromJson(i))).toList(growable: true);
        isLoading = false;
      } else {
        unreadNotification.value = json["unread_notification"].toString();
        isLoading = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading = false;
    }
    update();
  }

  Future<void> getNotificationListClearApi() async {
    try {
      showProgress();
      var result = await ApiServices.notificationListClear();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        getNotificationListApi();
        closeProgress();
      } else {
        getNotificationListApi();
        unreadNotification.value = json["unread_notification"].toString();
        closeProgress();
      }
    } catch (e) {
      errorToast(e.toString());
      closeProgress();
    }
    update();
  }
}
