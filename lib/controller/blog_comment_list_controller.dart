import 'dart:convert';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/model/comment_model.dart';
import 'package:fittyus/services/api_services.dart';

class BlogCommentListController extends GetxController implements GetxService {
  var commentList = <CommentModel>[].obs;
  bool isLoading = true;
  var totalComment = "".obs;
  TextEditingController commentController = TextEditingController();
  TextEditingController replyComment = TextEditingController();

  Future<void> getBlogCommentListApi(String blogId) async {
    try {
      var result = await ApiServices.blogCommentList(blogId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        totalComment.value = json["comment_count"].toString();
        commentList.value = List<CommentModel>.from(json['data'].map((i) => CommentModel.fromJson(i))).toList(growable: true);
        isLoading = false;
      } else {
        errorToast(json["msg"].toString());
        isLoading = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading = false;
    }
    update();
  }

  Future<void> addCommentApi(String blogId, String message,String commentId,bool isBack) async {
    try {
      var result = await ApiServices.addComment(blogId, message,commentId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isBack?Get.back():null;
        successToast(json["msg"].toString());
        getBlogCommentListApi(blogId);
        commentController.text = "";
      } else {
        errorToast(json["msg"].toString());
        isLoading = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading = false;
    }
  }
  Future<void> deleteCommentApi(String commentId) async {
    try {
      var result = await ApiServices.deleteComment(commentId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        Get.back();
        successToast(json["msg"].toString());
      } else {
        errorToast(json["msg"].toString());
        isLoading = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading = false;
    }
  }
  Future<void> likeCommentApi(String blogId,String commentId,String isLike) async {
    try {
      var result = await ApiServices.likeComment(blogId,commentId,isLike);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        successToast(json["msg"].toString());
      } else {
        errorToast(json["msg"].toString());
        isLoading = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading = false;
    }
  }
}
