import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/community_controller.dart';
import 'package:fittyus/model/view_profile_model.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:fittyus/widgets/text_filed_widget.dart';

class AddCommunityScreen extends StatefulWidget {
  final bool isEdit;
  final Community? modelEdit;

  const AddCommunityScreen({
    super.key,
    required this.isEdit,
    this.modelEdit,
  });

  @override
  State<AddCommunityScreen> createState() => _AddCommunityScreenState();
}

class _AddCommunityScreenState extends State<AddCommunityScreen> {
  final CommunityController _controller = Get.put(CommunityController());
  final _formKey = GlobalKey<FormState>();
  String? radioButtonItem;
  String imgAfter = "";
  String imgBefore = "";
  var postType;

  @override
  void initState() {
    imgAfter = "";
    imgBefore = "";
    _controller.afterImage.value = File("");
    _controller.beforeImage.value = File("");
    _controller.deleteImgIds.clear();
    _controller.updateImages.clear();
    _controller.communityImages.clear();
    _controller.newCommunityImages.clear();
    _controller.communityImages.add("upload");
    if (widget.isEdit) {
      _controller.tittleController.text = widget.modelEdit!.title ?? "";
      _controller.desController.text = widget.modelEdit!.shortDescription!;
      if (widget.modelEdit!.type.toString() == "multipal") {
        radioButtonItem = "normal";
        postType = 0;
        if (widget.modelEdit!.communityImages!.isNotEmpty) {
          for (int i = 0; i < widget.modelEdit!.communityImages!.length; i++) {
            _controller.communityImages.add(ApiUrl.imageBaseUrl + widget.modelEdit!.communityImages![i].image.toString());
            _controller.updateImages.add(widget.modelEdit!.communityImages![i]);
          }
        }
      } else {
        radioButtonItem = "after_before";
        postType = 1;
        imgAfter = ApiUrl.imageBaseUrl + widget.modelEdit!.afterImage.toString();
        imgBefore = ApiUrl.imageBaseUrl + widget.modelEdit!.beforeImg.toString();
      }
      _controller.isEditing.value = true;
    } else {
      radioButtonItem = "normal";
      postType = 0;
      _controller.tittleController.text = "";
      _controller.desController.text = "";
      _controller.isEditing.value = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: PreferredSize(
          preferredSize: Size(Dimensions.height90, MediaQuery.of(context).size.width),
          child: Container(
            height: Dimensions.height45 + Dimensions.height20,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(color: whiteColor, boxShadow: [BoxShadow(offset: Offset(0, 1), blurRadius: 15, spreadRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.2))]),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 40,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Add Community",
                  style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: Dimensions.height10),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Title",
                        style: TextStyle(color: mainColor, fontFamily: regular, fontWeight: FontWeight.w500, fontSize: Dimensions.font14, fontStyle: FontStyle.normal),
                      )),
                  SizedBox(height: Dimensions.height10 / 2),
                  SizedBox(
                    width: Dimensions.screenWidth,
                    child: MyTextFormField(
                      fillColor: whiteColor,
                      controller: _controller.tittleController,
                      hint: "enter Title",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                      readOnly: false,
                      border: mainColor,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Short Description",
                        style: TextStyle(color: mainColor, fontFamily: regular, fontWeight: FontWeight.w500, fontSize: Dimensions.font14, fontStyle: FontStyle.normal),
                      )),
                  SizedBox(height: Dimensions.height10 / 2),
                  SizedBox(
                    width: Dimensions.screenWidth,
                    child: MyTextFormField(
                      fillColor: whiteColor,
                      controller: _controller.desController,
                      hint: "enter short Description",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter short Description';
                        }
                        return null;
                      },
                      readOnly: false,
                      border: mainColor,
                    ),
                  ),
                  SizedBox(height: Dimensions.height15),
                  Visibility(
                    visible: widget.isEdit ? false : true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Select Post Type",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: semiBold,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  fillColor: MaterialStateColor.resolveWith((states) => mainColor),
                                  activeColor: mainColor,
                                  value: 0,
                                  groupValue: postType,
                                  onChanged: (val) {
                                    setState(() {
                                      postType = 0;
                                      radioButtonItem = "normal";
                                    });
                                  },
                                ),
                                const Text(
                                  "Normal Post",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: medium,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  fillColor: MaterialStateColor.resolveWith((states) => mainColor),
                                  activeColor: mainColor,
                                  value: 1,
                                  groupValue: postType,
                                  onChanged: (val) {
                                    setState(() {
                                      postType = 1;
                                      radioButtonItem = "after_before";
                                    });
                                  },
                                ),
                                const Text(
                                  "After And Before Post",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: medium,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  radioButtonItem == "normal"
                      ? Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Community Images",
                                  style: TextStyle(
                                    color: mainColor,
                                    fontFamily: regular,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimensions.font14,
                                    fontStyle: FontStyle.normal,
                                  ),
                                )),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SizedBox(
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              child: Obx(
                                () => ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: _controller.communityImages.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    if (_controller.communityImages[index] == "upload") {
                                      return GestureDetector(
                                        onTap: () {
                                          if (_controller.communityImages[index] == "upload") {
                                            _controller.selectImages().then((value) {
                                              setState(() {});
                                            });
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: mainColor,
                                            ),
                                            child: Image.asset(uploadImg, height: 100, width: 100, fit: BoxFit.cover),
                                          ),
                                        ),
                                      );
                                    } else {
                                      if (GetUtils.isURL(Uri.parse(_controller.communityImages[index].toString()).toString())) {
                                        return Stack(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(4),
                                              clipBehavior: Clip.antiAlias,
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: mainColor,
                                                border: Border.all(color: mainColor),
                                              ),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: _controller.communityImages[index],
                                                placeholder: (a, b) => const Center(
                                                  child: CircularProgressIndicator(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 5,
                                              top: 5,
                                              child: GestureDetector(
                                                onTap: () {
                                                  _controller.remoBikeImagefromDb(index).then((value) {
                                                    setState(() {});
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Stack(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(4),
                                              clipBehavior: Clip.antiAlias,
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: mainColor,
                                                border: Border.all(color: mainColor),
                                              ),
                                              child: Image.file(File(_controller.communityImages[index].path), fit: BoxFit.cover),
                                            ),
                                            Positioned(
                                              right: 5,
                                              top: 5,
                                              child: GestureDetector(
                                                onTap: () {
                                                  _controller.removeImages(index).then((value) {
                                                    setState(() {});
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "After Before Image",
                                  style: TextStyle(
                                    color: mainColor,
                                    fontFamily: regular,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimensions.font14,
                                    fontStyle: FontStyle.normal,
                                  ),
                                )),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Before Image",
                                      style: TextStyle(
                                        color: mainColor,
                                        fontFamily: regular,
                                        fontWeight: FontWeight.w500,
                                        fontSize: Dimensions.font14,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Obx(
                                      () => InkWell(
                                        onTap: () {
                                          _controller.pickImage(context, "before");
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: mainColor,
                                            ),
                                            child: _controller.beforeImage.value.path.isEmpty
                                                ? (imgBefore.isNotEmpty)
                                                    ? CachedNetworkImage(
                                                        errorWidget: (context, url, error) => Image.asset(
                                                          uploadProfileBg,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        fit: BoxFit.cover,
                                                        height: Dimensions.height90,
                                                        width: Dimensions.width90,
                                                        imageUrl: imgBefore.toString(),
                                                        placeholder: (a, b) => const Center(
                                                          child: CircularProgressIndicator(
                                                            color: pGreen,
                                                          ),
                                                        ),
                                                      )
                                                    : Image.asset(uploadImg, height: 100, width: 100, fit: BoxFit.cover)
                                                : Image.file(
                                                    _controller.beforeImage.value,
                                                    height: 100,
                                                    width: 100,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "After Image",
                                      style: TextStyle(
                                        color: mainColor,
                                        fontFamily: regular,
                                        fontWeight: FontWeight.w500,
                                        fontSize: Dimensions.font14,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Obx(
                                      () => InkWell(
                                        onTap: () {
                                          _controller.pickImage(context, "after");
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: mainColor,
                                            ),
                                            child: _controller.afterImage.value.path.isEmpty
                                                ? (imgAfter.isNotEmpty)
                                                    ? CachedNetworkImage(
                                                        errorWidget: (context, url, error) => Image.asset(
                                                          uploadProfileBg,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        fit: BoxFit.cover,
                                                        height: Dimensions.height90,
                                                        width: Dimensions.width90,
                                                        imageUrl: imgAfter.toString(),
                                                        placeholder: (a, b) => const Center(
                                                          child: CircularProgressIndicator(
                                                            color: pGreen,
                                                          ),
                                                        ),
                                                      )
                                                    : Image.asset(uploadImg, height: 100, width: 100, fit: BoxFit.cover)
                                                : Image.file(_controller.afterImage.value, height: 100, width: 100, fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                  SizedBox(
                    height: Dimensions.height30,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (_controller.isEditing.value == true) {
                          if (widget.modelEdit!.type == "multipal") {
                            _controller.communityImages.removeWhere((image) => _controller.newCommunityImages.contains(image.toString()));
                            _controller.updateCommunity(
                              _controller.tittleController.text,
                              _controller.desController.text,
                              _controller.communityImages,
                              _controller.deleteImgIds,
                              widget.modelEdit!.id.toString(),
                            );
                          } else {
                            _controller.updateCommunityAfterBefore(
                              _controller.tittleController.text,
                              _controller.desController.text,
                              widget.modelEdit!.id.toString(),
                            );
                          }
                        } else {
                          if (postType == 0) {
                            print("here");
                            _controller
                                .addCommunity(
                              _controller.tittleController.text,
                              _controller.desController.text,
                              _controller.communityImages,
                              true,
                            )
                                .then((value) {
                              _controller.communityImages.clear();
                              _controller.tittleController.text = "";
                              _controller.desController.text = "";
                            });
                          } else {
                            print("here2");
                            _controller
                                .addCommunityAfterBefore(
                              _controller.tittleController.text,
                              _controller.desController.text,
                              true,
                            )
                                .then((value) {
                              _controller.tittleController.text = "";
                              _controller.desController.text = "";
                            });
                          }
                        }
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: const Color(0xFF2C986D), borderRadius: BorderRadius.circular(5)),
                      height: 43,
                      child: Center(
                        child: Text(
                          _controller.isEditing.value == true ? "Update Post" : "Add Post",
                          style: TextStyle(color: whiteColor, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
