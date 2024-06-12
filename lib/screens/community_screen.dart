import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/community_controller.dart';
import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/model/community_list_model.dart';
import 'package:fittyus/screens/community_details_screen.dart';
import 'package:fittyus/screens/new_profile_screen.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:fittyus/widgets/text_filed_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  CarouselController carouselController = CarouselController();
  CommunityController controller = Get.put(CommunityController());
  UserController user = Get.put(UserController());
  String? image;
  TextEditingController shortDes = TextEditingController();
  XFile xFile = XFile("");

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CommunityController>(),
      initState: (state) {
        Get.find<CommunityController>().getCommunityListApi(true);
      },
      builder: (contextCtr) {
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
                      "Community",
                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                contextCtr.communityList.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: user.user.value.profileImage != ""
                                    ? CachedNetworkImage(
                                        errorWidget: (context, url, error) => Image.asset(
                                          defaultUser,
                                          fit: BoxFit.cover,
                                        ),
                                        fit: BoxFit.cover,
                                        imageUrl: user.user.value.avatarUrl.toString(),
                                        placeholder: (a, b) => const Center(
                                          child: CircularProgressIndicator(
                                            color: mainColor,
                                          ),
                                        ),
                                      )
                                    : Image.asset(
                                        defaultUser,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                                child: SizedBox(
                              height: 25,
                              child: MyTextFormField(
                                fillColor: grayNew,
                                controller: shortDes,
                                textInputAction: TextInputAction.done,
                                hint: "What have you been Up To ?",
                                obscureText: false,
                                readOnly: false,
                                onFiledSubmit: (v) {
                                  if (image != null) {
                                    controller.communityImages.add(xFile);
                                    controller.addCommunity("", shortDes.text, controller.communityImages, false).then((value) {
                                      shortDes.text = "";
                                      image = "";
                                    });
                                  } else {
                                    errorToast("chose a image");
                                  }
                                },
                                border: Colors.transparent,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      child: SizedBox(
                                        width: 60,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                pickImage(context, "camera");
                                              },
                                              child: Image.asset(
                                                cameraIc,
                                                height: 17,
                                                width: 24,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                pickImage(context, "gallery");
                                              },
                                              child: Image.asset(
                                                galleryIc,
                                                height: 22,
                                                width: 27,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                      )
                    : const SizedBox(),
                Builder(builder: (context) {
                  if (contextCtr.isLoading.value) {
                    return SizedBox(
                      height: Dimensions.screenHeight - 200,
                      width: Dimensions.screenWidth,
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: mainColor,
                      )),
                    );
                  }
                  if (contextCtr.communityList.isEmpty) {
                    return SizedBox(
                      width: Dimensions.screenWidth,
                      height: Dimensions.screenHeight - 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'No Community Post',
                            style: TextStyle(color: mainColor, fontSize: Dimensions.font16 + 2, fontFamily: regular, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: contextCtr.communityList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return myCommunityListTile(contextCtr.communityList[index], index);
                      },
                    ),
                  );
                })
              ],
            ),
          ),
        );
      },
    );
  }

  myCommunityListTile(CommunityListModel list, int listIndex) {
    var dateOk = list.comments!.isNotEmpty ? dateSetOk(list.comments![0].createdAt.toString()) : "";
    return InkWell(
      onTap: () {
        Get.to(() => CommunityDetails(communityId: list.id.toString()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.006),
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01, vertical: MediaQuery.of(context).size.height * 0.01),
        decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(2)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => NewProfileScreen(id: list.userId.toString()));
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: list.profileImage != null && list.profileImage != ""
                                ? CachedNetworkImage(
                                    errorWidget: (context, url, error) => Image.asset(
                                      defaultUser,
                                      fit: BoxFit.cover,
                                    ),
                                    fit: BoxFit.cover,
                                    imageUrl: list.profileImage.toString(),
                                    placeholder: (a, b) => const Center(
                                      child: CircularProgressIndicator(
                                        color: mainColor,
                                      ),
                                    ),
                                  )
                                : Image.asset(
                                    defaultUser,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              list.firstName.toString(),
                              style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                            ),
                            Text(
                              list.date.toString(),
                              style: TextStyle(color: mainColor, fontFamily: regular, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Icon(
                      Icons.more_horiz,
                      size: Dimensions.iconSize24,
                      color: dividerCl,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      list.shortDescription.toString(),
                      maxLines: 2,
                      style: TextStyle(
                        color: lightGreyTxt,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: regular,
                        fontSize: Dimensions.font14 - 4,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            list.type == "multipal"
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Stack(
                      children: [
                        CarouselSlider(
                          carouselController: carouselController,
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.400,
                            enlargeCenterPage: true,
                            viewportFraction: 1.0,
                            pauseAutoPlayOnTouch: true,
                            enableInfiniteScroll: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                controller.indices[listIndex] = index;
                              });
                            },
                          ),
                          items: List.generate(
                            list.communityImages!.length,
                            (ind) => InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.470,
                                width: Get.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: list.communityImages!.isNotEmpty
                                      ? CachedNetworkImage(
                                          errorWidget: (context, url, error) => Image.asset(
                                            demoImgTraining,
                                            fit: BoxFit.cover,
                                          ),
                                          fit: BoxFit.contain,
                                          imageUrl: ApiUrl.imageBaseUrl + list.communityImages![ind].image.toString(),
                                          placeholder: (a, b) => const Center(
                                            child: CircularProgressIndicator(
                                              color: mainColor,
                                            ),
                                          ),
                                        )
                                      : Image.asset(
                                          demoImg,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            width: 40,
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(16, 17, 16, 0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${controller.indices[listIndex] + 1}/${list.communityImages!.length}",
                                  style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: Dimensions.font14 - 4, fontFamily: regular, color: whiteColor),
                                )
                              ],
                            ),
                          ),
                        ),
                        list.userId.toString() == user.user.value.id.toString()
                            ? Positioned(
                                right: 10,
                                bottom: 10,
                                child: InkWell(
                                  onTap: () {
                                    controller.deleteCommunity(list.id.toString());
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(16, 17, 16, 0.3),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.delete,
                                          color: whiteColor,
                                          size: 18,
                                        ),
                                      )),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            list.beforeImg != "" && list.beforeImg != null
                                ? Expanded(
                                    child: list.beforeImg != "" && list.beforeImg != null
                                        ? CachedNetworkImage(
                                            errorWidget: (context, url, error) => Image.asset(demoImg, height: MediaQuery.of(context).size.height * 0.400, fit: BoxFit.cover),
                                            fit: BoxFit.fill,
                                            height: MediaQuery.of(context).size.height * 0.400,
                                            imageUrl: ApiUrl.imageBaseUrl + list.beforeImg.toString(),
                                            placeholder: (a, b) => const Center(
                                              child: CircularProgressIndicator(
                                                color: mainColor,
                                              ),
                                            ),
                                          )
                                        : Image.asset(demoImg, height: MediaQuery.of(context).size.height * 0.400, fit: BoxFit.cover))
                                : SizedBox(),
                            list.afterImage != "" && list.afterImage != null
                                ? Expanded(
                                    child: list.afterImage != "" && list.afterImage != null
                                        ? CachedNetworkImage(
                                            errorWidget: (context, url, error) => Image.asset(demoImg, height: MediaQuery.of(context).size.height * 0.400, fit: BoxFit.cover),
                                            fit: BoxFit.fill,
                                            height: MediaQuery.of(context).size.height * 0.400,
                                            imageUrl: ApiUrl.imageBaseUrl + list.afterImage.toString(),
                                            placeholder: (a, b) => const Center(
                                              child: CircularProgressIndicator(
                                                color: mainColor,
                                              ),
                                            ),
                                          )
                                        : Image.asset(demoImg, height: MediaQuery.of(context).size.height * 0.400, fit: BoxFit.cover))
                                : SizedBox(),
                          ],
                        ),
                        list.userId.toString() == user.user.value.id.toString()
                            ? Positioned(
                                right: 10,
                                bottom: 10,
                                child: InkWell(
                                  onTap: () {
                                    controller.deleteCommunity(list.id.toString());
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(16, 17, 16, 0.3),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.delete,
                                          color: whiteColor,
                                          size: 18,
                                        ),
                                      )),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    controller.communityLike(list.id.toString(), list.isLike.toString() == "0" ? "1" : "0").then((value) {
                      controller.isLoading.value = true;
                      controller.getCommunityListApi(true);
                      controller.isLoading.value = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        list.isLike.toString() == "0"
                            ? Image.asset(
                                heartIc,
                                height: 16,
                                width: 16,
                              )
                            : Image.asset(
                                heartPinkIc,
                                height: 16,
                                width: 16,
                              ),
                        const SizedBox(width: 4),
                        Text(
                          "like ${list.communityCount}",
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: mainColor,
                            fontFamily: regular,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: Dimensions.font14 - 4,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        commentNewIc,
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Comment",
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: mainColor,
                          fontFamily: regular,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font14 - 4,
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          shareNewIc,
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Share",
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: mainColor,
                            fontFamily: regular,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: Dimensions.font14 - 4,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "200 Views",
                    maxLines: 2,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: mainColor,
                      fontFamily: regular,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: Dimensions.font14 - 4,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            list.comments!.isNotEmpty
                ? SizedBox(
                    height: 80,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: list.comments![0].userImage != null && list.comments![0].userImage != ""
                                      ? CachedNetworkImage(
                                          errorWidget: (context, url, error) => Image.asset(
                                            defaultUser,
                                            fit: BoxFit.cover,
                                          ),
                                          fit: BoxFit.cover,
                                          imageUrl: list.comments![0].userImage.toString(),
                                          placeholder: (a, b) => const Center(
                                            child: CircularProgressIndicator(
                                              color: mainColor,
                                            ),
                                          ),
                                        )
                                      : Image.asset(
                                          defaultUser,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(color: grayNew),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            list.comments![0].userName.toString().toString(),
                                            style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                          ),
                                          Text(
                                            dateOk,
                                            style: TextStyle(
                                              color: lightGreyTxt,
                                              fontFamily: regular,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: Dimensions.font14 - 4,
                                            ),
                                          )
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          list.comments![0].message.toString(),
                                          maxLines: 2,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: lightGreyTxt,
                                            fontFamily: regular,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: Dimensions.font14 - 4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: [
                                        list.comments![0].like.toString() == "0"
                                            ? Image.asset(
                                                heartIc,
                                                height: 16,
                                                width: 16,
                                              )
                                            : Image.asset(
                                                heartPinkIc,
                                                height: 16,
                                                width: 16,
                                              ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "like",
                                          maxLines: 2,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: mainColor,
                                            fontFamily: regular,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: Dimensions.font14 - 4,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Reply",
                                  maxLines: 2,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: mainColor,
                                    fontFamily: regular,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: Dimensions.font14 - 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    child: Text(
                      "No Comments",
                      style: TextStyle(
                        color: mainColor,
                        fontFamily: regular,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: Dimensions.font14 - 4,
                      ),
                    ),
                  ),
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: const MyTextFormField(
                      hint: 'Comment Here...',
                      obscureText: false,
                      readOnly: false,
                      border: dividerCl,
                      fillColor: whiteColor,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: ImageIcon(
                          AssetImage(
                            sendBlueIc,
                          ),
                          color: Color(0xFF1B3BA9),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  dateSetOk(String s) {
    DateTime timestamp = DateTime.parse(s);
    String formattedDate = DateFormat('d MMM yyyy h:mm a').format(timestamp);
    return formattedDate;
  }

  void pickImage(BuildContext context, String type) async {
    var source = type == "gallery" ? ImageSource.gallery : ImageSource.camera;
    var picker = ImagePicker();
    var file = await picker.pickImage(
      source: source,
      maxHeight: 1080,
      maxWidth: 1080,
      imageQuality: 90,
    );

    setState(() {
      if (file != null) {
        xFile = XFile(file.path);
        image = xFile.path;
        if (shortDes.text.isNotEmpty) {
          controller.communityImages.add(xFile);
          controller.addCommunity("", shortDes.text, controller.communityImages, false).then((value) {
            shortDes.text = "";
            image = "";
          });
        } else {
          errorToast("Add description");
        }
      }
    });
  }
}
