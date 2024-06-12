import 'dart:convert';
import 'dart:io';

import 'package:fittyus/model/community_list_model.dart';
import 'package:fittyus/model/gallery_image_model.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/constants.dart';
import '../services/api_services.dart';

class CommunityController extends GetxController implements GetxService {
  var communityList = <CommunityListModel>[].obs;
  var commentList = <Comment>[].obs;
  var galleryImg = <GalleryImageModel>[].obs;
  var communityDetails = CommunityListModel(communityImages: []).obs;
  Rx<bool> isLoading = false.obs;
  var totalComment = "".obs;
  TextEditingController commentController = TextEditingController();
  TextEditingController replyComment = TextEditingController();
  List<int> indices = [];
  String? radioButtonItem;
  RxList communityImages = [].obs;
  final ImagePicker imagePicker = ImagePicker();
  List<CommunityImage> updateImages = List<CommunityImage>.empty(growable: true);
  RxBool isEditing = false.obs;
  int tabIndex = 0;
  TextEditingController tittleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  List<String> deleteImgIds = [];
  RxList newCommunityImages = [].obs;
  Rx<File> afterImage = File("").obs;
  Rx<File> beforeImage = File("").obs;

  void pickImage(BuildContext context, String type) async {
    var source = await imagePickerSheet(context);
    if (source != null) {
      // ignore: invalid_use_of_visible_for_testing_member
      var picker = ImagePicker.platform;
      // ignore: deprecated_member_use
      var file = await picker.pickImage(
        source: source,
        maxHeight: 1080,
        maxWidth: 1080,
        imageQuality: 90,
      );
      if (type == "after") {
        afterImage.value = File(file!.path);
      } else {
        beforeImage.value = File(file!.path);
      }
    }
    update();
  }

  Future<ImageSource?> imagePickerSheet(context) async {
    ImageSource? source = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            color: Colors.white,
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_rounded,
                          color: pGreen,
                          size: 40,
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(color: pGreen),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Icon(
                          Icons.photo_rounded,
                          color: pGreen,
                          size: 40,
                        ),
                        Text('Gallery', style: TextStyle(color: pGreen)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
    return source;
  }

  Future<void> remoBikeImagefromDb(int index) async {
    int currentIndex = 1;
    int imageid = 0;
    String image = "";
    if (index > 0) {
      currentIndex = index - 1;
    }
    if (updateImages.isNotEmpty) {
      imageid = updateImages[currentIndex].id!.toInt();
      image = updateImages[currentIndex].image!.toString();
    }
    if (imageid != 0) {
      deleteImgIds.add(imageid.toString());
      newCommunityImages.add(image);
    }
    if (communityImages.isNotEmpty) {
      communityImages.removeAt(index);
    }
    update();
  }

  Future<void> selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.length > 5) {
      errorToast("Max Bike Image limit is 5");
    } else {
      if (selectedImages.isNotEmpty) {
        if (selectedImages.length + communityImages.length > 6) {
          errorToast("Max Bike Image limit is 5");
        } else {
          communityImages.addAll(selectedImages);
        }
      }
    }
    update();
  }

  Future<void> removeImages(int index) async {
    if (communityImages.isNotEmpty) {
      communityImages.removeAt(index);
    }
    update();
  }

  Future<void> getCommunityListApi(bool load) async {
    try {
      isLoading.value = load;
      communityList.clear();
      indices = [];
      var result = await ApiServices.communityList();
      var json = jsonDecode(result.body);
      Log.console(json);
      if (json["status"] == true) {
        communityList.value = List<CommunityListModel>.from(json['data'].map((i) => CommunityListModel.fromJson(i))).toList(growable: true);
        indices = List.generate(communityList.length, (index) => 0);
        isLoading.value = false;
      } else {
        errorToast(json["message"].toString());
        isLoading.value = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading.value = false;
    }
    update();
  }

  Future<void> communityLike(String communityId, String type) async {
    try {
      showProgress();
      isLoading.value = true;
      var result = await ApiServices.communityLike(communityId, type);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        getCommunityListApi(true).then((value) {
          closeProgress();
        });
        communityDetailsApi(communityId, false);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        closeProgress();
        errorToast(json["message"].toString());
      }
    } catch (e) {
      isLoading.value = false;
      closeProgress();
      errorToast(e.toString());
    }
    update();
  }

  Future<void> communityDetailsApi(String communityId, bool isLoad) async {
    try {
      isLoading.value = isLoad;
      var result = await ApiServices.communityDetailsApi(communityId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        CommunityListModel model = CommunityListModel.fromJson(json['data'][0]);
        communityDetails.value = model;
        commentList.value = communityDetails.value.comments!;
        isLoading.value = false;
      } else {
        errorToast(json["message"].toString());
        isLoading.value = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading.value = false;
    }
    update();
  }

  Future<void> communityCommentList(String communityId) async {
    try {
      var result = await ApiServices.communityCommentList(communityId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        commentList.value = List<Comment>.from(json['data'].map((i) => Comment.fromJson(i))).toList(growable: true);
        isLoading.value = false;
      } else {
        errorToast(json["message"].toString());
        isLoading.value = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading.value = false;
    }
    update();
  }

  Future<void> addCommentApi(
    String communityId,
    String replyId,
    String message,
    bool isBack,
  ) async {
    try {
      var result = await ApiServices.communityAddComment(communityId, message, replyId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isBack ? Get.back() : null;
        successToast(json["msg"].toString());
        communityDetailsApi(communityId, false);
        getCommunityListApi(true);
        commentController.text = "";
      } else {
        errorToast(json["msg"].toString());
        isLoading.value = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading.value = false;
    }
    update();
  }

  Future<void> deleteComment(String commentId) async {
    try {
      var result = await ApiServices.communityCommentDelete(commentId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        Get.back();
        successToast(json["msg"].toString());
        getCommunityListApi(true);
      } else {
        errorToast(json["msg"].toString());
        isLoading.value = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading.value = false;
    }
    update();
  }

  Future<void> likeComment(String commentId) async {
    try {
      var result = await ApiServices.communityCommentLike(commentId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        successToast(json["msg"].toString());
        getCommunityListApi(true);
      } else {
        errorToast(json["msg"].toString());
        isLoading.value = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading.value = false;
    }
    update();
  }

  Future<void> addCommunity(
    String tittle,
    String shortDescription,
    var image,
    bool isBack,
  ) async {
    try {
      showProgress();
      var result = await ApiServices.addCommunity(tittle, shortDescription, image);
      if (result["status"] == true) {
        closeProgress();
        isBack ? Get.back(result: 200) : null;
        successToast(result["message"].toString());
        getCommunityListApi(true);
      } else {
        closeProgress();
        errorToast(result["message"].toString());
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
    }
    update();
  }

  Future<void> addCommunityAfterBefore(
    String tittle,
    String shortDescription,
    bool isBack,
  ) async {
    try {
      showProgress();
      var result = await ApiServices.addCommunityAfterBefore(tittle, shortDescription, afterImage.value.path, beforeImage.value.path);
      if (result["status"] == true) {
        closeProgress();
        isBack ? Get.back(result: 200) : null;
        successToast(result["message"].toString());
        getCommunityListApi(true);
      } else {
        closeProgress();
        errorToast(result["message"].toString());
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
    }
    update();
  }

  Future<void> updateCommunity(
    String title,
    String shortDescription,
    var image,
    List<String> imageIds,
    String communityId,
  ) async {
    try {
      showProgress();
      var result = await ApiServices.updateCommunity(
        title,
        shortDescription,
        image,
        imageIds,
        communityId,
      );
      if (result["status"] == true) {
        closeProgress();
        Get.back(result: 200);
        successToast(result["message"].toString());
        getCommunityListApi(true);

      } else {
        closeProgress();
        errorToast(result["message"].toString());
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
    }
    update();
  }

  Future<void> updateCommunityAfterBefore(
    String title,
    String shortDescription,
    String communityId,
  ) async {
    try {
      showProgress();
      var result = await ApiServices.updateCommunityAfterBefore(
        title,
        shortDescription,
        afterImage.value.path,
        beforeImage.value.path,
        communityId,
      );
      if (result["status"] == true) {
        closeProgress();
        Get.back(result: 200);
        successToast(result["message"].toString());
        getCommunityListApi(true);

      } else {
        closeProgress();
        errorToast(result["message"].toString());
      }
    } catch (e) {
      closeProgress();
      errorToast(e.toString());
    }
    update();
  }

  Future<void> deleteCommunity(String communityId) async {
    try {
      showProgress();
      var result = await ApiServices.communityDelete(communityId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        successToast(json["message"].toString());
        communityDetailsApi(communityId, false);
        getCommunityListApi(true);
      } else {
        errorToast(json["message"].toString());
        closeProgress();
      }
    } catch (e) {
      errorToast(e.toString());
      closeProgress();
    }
    update();
  }

  Future<void> communityGallery(String userId) async {
    try {
      galleryImg.clear();
      isLoading.value = true;
      var result = await ApiServices.communityGallery(userId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        galleryImg.value = List<GalleryImageModel>.from(json['data'].map((i) => GalleryImageModel.fromJson(i))).toList(growable: true);
        isLoading.value = false;
      } else {
        errorToast(json["message"].toString());
        isLoading.value = false;
      }
    } catch (e) {
      errorToast(e.toString());
      isLoading.value = false;
    }
    update();
  }
}
