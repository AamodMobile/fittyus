import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/community_controller.dart';
import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/model/view_profile_model.dart';
import 'package:fittyus/screens/add_community_screen.dart';
import 'package:fittyus/screens/gallery_screen.dart';
import 'package:fittyus/screens/new_profile_screen.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:fittyus/widgets/text_filed_widget.dart';
import 'package:intl/intl.dart';

import 'community_details_screen.dart';

class DietAndNutritionScreen extends StatefulWidget {
  const DietAndNutritionScreen({super.key});

  @override
  State<DietAndNutritionScreen> createState() => _DietAndNutritionScreenState();
}

class _DietAndNutritionScreenState extends State<DietAndNutritionScreen> {
  UserController userController = Get.put(UserController());
  CommunityController controller = Get.put(CommunityController());
  CarouselController carouselController = CarouselController();
  late List<int> indices;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<UserController>(),
        initState: (state) {
          indices = [];
          Get.find<UserController>().viewProfile(userController.user.value.id.toString(), true).then((value) {
            controller.isLoading.value = true;
            indices = List.generate(userController.viewProfileModel.value.community!.length, (index) => 0);
            controller.isLoading.value = false;
          });
        },
        builder: (cont) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: whiteColor,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, spreadRadius: 1)],
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: mainColor,
                            fontFamily: semiBold,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: Dimensions.font16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Builder(builder: (context) {
                    if (cont.isLoading) {
                      return SizedBox(
                        height: Dimensions.screenHeight - 200,
                        width: Dimensions.screenWidth,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: mainColor,
                          ),
                        ),
                      );
                    }
                    if (cont.viewProfileModel == "") {
                      return SizedBox(
                        width: Dimensions.screenWidth,
                        height: Dimensions.screenHeight - 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'No Profile Data',
                              style: TextStyle(
                                color: mainColor,
                                fontSize: Dimensions.font16 + 2,
                                fontFamily: regular,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Expanded(
                      child: SizedBox(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  SizedBox(
                                    height: 255,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 209,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                            color: const Color.fromRGBO(0, 0, 0, 0.2),
                                          )),
                                          child: userController.viewProfileModel.value.profileBackCover != null && userController.viewProfileModel.value.profileBackCover != ""
                                              ? CachedNetworkImage(
                                                  errorWidget: (context, url, error) => Image.asset(
                                                    coachTopImg,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  fit: BoxFit.fill,
                                                  imageUrl: userController.viewProfileModel.value.profileBackCover.toString(),
                                                  placeholder: (a, b) => const Center(
                                                    child: CircularProgressIndicator(
                                                      color: mainColor,
                                                    ),
                                                  ),
                                                )
                                              : Image.asset(
                                                  coachTopImg,
                                                  fit: BoxFit.fill,
                                                ),
                                        ),
                                        userController.viewProfileModel.value.id == userController.user.value.id
                                            ? Positioned(
                                                right: 20,
                                                bottom: 60,
                                                child: InkWell(
                                                  onTap: () {
                                                    userController.pickImage(context, "cover", userController.user.value.id.toString());
                                                  },
                                                  child: Container(
                                                    height: 24,
                                                    width: 29,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFFE0DCDC),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    child: Center(
                                                      child: Image.asset(
                                                        cameraBlackIc,
                                                        height: 16,
                                                        width: 19,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      left: 11,
                                      bottom: -5,
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      height: 73,
                                                      width: 72,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: whiteColor,
                                                        border: Border.all(
                                                          color: const Color.fromRGBO(0, 0, 0, 0.2),
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(35),
                                                          child: userController.viewProfileModel.value.profileImage != null && userController.viewProfileModel.value.profileImage != ""
                                                              ? CachedNetworkImage(
                                                                  errorWidget: (context, url, error) => Image.asset(
                                                                    defaultUser,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                  fit: BoxFit.cover,
                                                                  imageUrl: userController.viewProfileModel.value.profileImage.toString(),
                                                                  placeholder: (a, b) => const Center(
                                                                    child: CircularProgressIndicator(
                                                                      color: mainColor,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Image.asset(
                                                                  coachTopImg,
                                                                  fit: BoxFit.cover,
                                                                )),
                                                    ),
                                                    userController.viewProfileModel.value.id == userController.user.value.id
                                                        ? Positioned(
                                                            right: 2,
                                                            bottom: 2,
                                                            child: InkWell(
                                                              onTap: () {
                                                                userController.pickImage(context, "profile", userController.user.value.id.toString());
                                                              },
                                                              child: Container(
                                                                height: 22,
                                                                width: 22,
                                                                decoration: BoxDecoration(
                                                                  color: const Color(0xFFE0DCDC),
                                                                  borderRadius: BorderRadius.circular(15),
                                                                ),
                                                                child: Center(
                                                                  child: Image.asset(
                                                                    cameraBlackIc,
                                                                    height: 10,
                                                                    width: 13,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 20),
                                                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                      Text(
                                                        cont.viewProfileModel.value.firstName.toString(),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                          color: mainColor,
                                                          fontFamily: semiBold,
                                                          fontWeight: FontWeight.w700,
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: Dimensions.font14,
                                                        ),
                                                      ),
                                                    ]),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "Followers",
                                                          style: TextStyle(
                                                              color: lightGreyTxt, fontFamily: semiBold, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                                                        ),
                                                        const SizedBox(width: 11),
                                                        Text(
                                                          cont.viewProfileModel.value.followerCount.toString(),
                                                          style: TextStyle(
                                                              color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Following",
                                                          style: TextStyle(
                                                              color: lightGreyTxt, fontFamily: semiBold, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                                                        ),
                                                        const SizedBox(width: 11),
                                                        Text(
                                                          cont.viewProfileModel.value.followingCount.toString(),
                                                          style: TextStyle(
                                                              color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(() => GalleryScreen(id: userController.user.value.id.toString()));
                                                  },
                                                  child: SizedBox(
                                                    child: Image.asset(
                                                      openGallery,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 14),
                                                userController.viewProfileModel.value.id == userController.user.value.id
                                                    ? const SizedBox()
                                                    : InkWell(
                                                        onTap: () {
                                                          cont
                                                              .followAndUnfollow(userController.user.value.id.toString())
                                                              .then((value) => cont.viewProfile(userController.user.value.id.toString(), false));
                                                        },
                                                        child: Container(
                                                          height: 32,
                                                          width: 90,
                                                          margin: const EdgeInsets.only(top: 50),
                                                          decoration: BoxDecoration(
                                                            color: whiteColor,
                                                            border: Border.all(color: pGreen),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              userController.viewProfileModel.value.isFollowers == 0 ? "Follow" : "Unfollow",
                                                              style:
                                                                  TextStyle(color: pGreen, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                const SizedBox(width: 20)
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                              const SizedBox(height: 10),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.2), width: 1),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Followers",
                                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      height: 80,
                                      width: MediaQuery.of(context).size.width,
                                      child: cont.viewProfileModel.value.followersList!.isEmpty
                                          ? Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Have not Follower",
                                                style: TextStyle(color: pGreen, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount: cont.viewProfileModel.value.followersList!.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (BuildContext context, int index) {
                                                return InkWell(
                                                  onTap: () async {
                                                    var result = await Get.to(() => NewProfileScreen(id: cont.viewProfileModel.value.followersList![index].followingId.toString()));
                                                    if (result != null) {
                                                      indices = [];
                                                      cont.viewProfile(userController.user.value.id.toString(), true).then((value) {
                                                        controller.isLoading.value = true;
                                                        indices = List.generate(userController.viewProfileModel.value.community!.length, (index) => 0);
                                                        controller.isLoading.value = false;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 80,
                                                    width: 66,
                                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 60,
                                                          width: 60,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(9),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(10),
                                                            child: cont.viewProfileModel.value.followersList![index].profileImage != ""
                                                                ? CachedNetworkImage(
                                                                    errorWidget: (context, url, error) => Image.asset(
                                                                      defaultUser,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                    fit: BoxFit.cover,
                                                                    height: 60,
                                                                    width: 60,
                                                                    imageUrl: cont.viewProfileModel.value.followersList![index].profileImage.toString(),
                                                                    placeholder: (a, b) => const Center(
                                                                      child: CircularProgressIndicator(
                                                                        color: mainColor,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Image.asset(
                                                                    demoImg,
                                                                    height: 60,
                                                                    width: 60,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 2),
                                                        Text(
                                                          cont.viewProfileModel.value.followersList![index].firstName.toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            color: mainColor,
                                                            fontFamily: medium,
                                                            fontWeight: FontWeight.w700,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: Dimensions.font14 - 6,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                              cont.viewProfileModel.value.id.toString() == userController.user.value.id.toString()
                                  ? InkWell(
                                      onTap: () async {
                                        var response = await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const AddCommunityScreen(isEdit: false)),
                                        );
                                        if (response != null) {
                                          indices = [];
                                          Get.find<UserController>().viewProfile(userController.user.value.id.toString(), true).then((value) {
                                            controller.isLoading.value = true;
                                            indices = List.generate(userController.viewProfileModel.value.community!.length, (index) => 0);
                                            controller.isLoading.value = false;
                                          });
                                        } else {}
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(color: const Color(0xFF2C986D), borderRadius: BorderRadius.circular(5)),
                                        height: 43,
                                        child: Center(
                                          child: Text(
                                            "Add Post",
                                            style: TextStyle(color: whiteColor, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              cont.viewProfileModel.value.community!.isEmpty
                                  ? SizedBox(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Text(
                                          "No Post Yet",
                                          style: TextStyle(color: mainColor, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                        ),
                                      ),
                                    )
                                  : MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: cont.viewProfileModel.value.community!.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return myCommunityListTile(cont.viewProfileModel.value.community![index], index);
                                        },
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        });
  }

  myCommunityListTile(Community list, int listIndex) {
    var dateOk = list.comments!.isNotEmpty ? dateSetOk(list.comments![0].createdAt.toString()) : "";
    return InkWell(
      onTap: () {
        Get.to(() => CommunityDetails(communityId: list.id.toString()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.006, horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01, vertical: MediaQuery.of(context).size.height * 0.01),
        decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: borderColorCont)),
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
                        list.userId.toString() == userController.user.value.id.toString()
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
                                : const SizedBox(),
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
                                : const SizedBox(),
                          ],
                        ),
                        list.userId.toString() == userController.user.value.id.toString()
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
                Expanded(
                  child: InkWell(
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                ),
                Visibility(
                  visible: false,
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
                Visibility(
                  visible: false,
                  child: Container(
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
                                  onTap: () {
                                    controller.likeComment(list.comments![0].id.toString()).then((value) {});
                                  },
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
}
