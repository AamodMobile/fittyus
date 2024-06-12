import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/model/video_animation_list_model.dart';
import 'package:fittyus/widgets/runvideo.dart';

import '../controller/video_animation_list_controller.dart';

class VideoDetailsScreen extends StatefulWidget {
  final Media file;

  const VideoDetailsScreen({super.key, required this.file});

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  VideoAnimationListController controller = Get.put(VideoAnimationListController());
  int selectedCategoryIndex = -1;
  UserController user = Get.find<UserController>();

  @override
  void initState() {
    controller.plansList.clear();
    super.initState();
  }

  @override
  void dispose() {
    controller.razorpay.clear();
    super.dispose();
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
            decoration: const BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 15,
                  spreadRadius: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                ),
              ],
            ),
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
                const SizedBox(
                  width: 12,
                ),
                Text(
                  widget.file.title.toString(),
                  style: TextStyle(
                    color: mainColor,
                    fontFamily: semiBold,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: Dimensions.font16,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  if (widget.file.isLock == 1) {
                    bottomSheetWidget(
                      widget.file.media.toString(),
                      widget.file.title.toString(),
                      widget.file.categoryId.toString(),
                    );
                  } else {
                    Get.to(
                      () => PlayYoutubeVideo(
                        id: widget.file.id.toString(),
                        url: widget.file.link.toString(),
                        title: widget.file.title.toString(),
                        lastTime: widget.file.previousWatchTime.toString(),
                      ),
                    );
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0,
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: widget.file.media != null && widget.file.media != ""
                            ? CachedNetworkImage(
                                errorWidget: (context, url, error) => Image.asset(
                                  coachTopImg,
                                  fit: BoxFit.cover,
                                ),
                                fit: BoxFit.cover,
                                imageUrl: widget.file.media.toString(),
                                placeholder: (a, b) => const Center(
                                  child: CircularProgressIndicator(
                                    color: mainColor,
                                  ),
                                ),
                              )
                            : Image.asset(coachTopImg, fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      alignment: Alignment.center,
                      child: Image.asset(
                        playIc,
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(0.25),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Text(
                  widget.file.title.toString(),
                  style: TextStyle(
                    color: mainColor,
                    fontFamily: semiBold,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: Dimensions.font16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Description",
                  style: TextStyle(
                    fontSize: Dimensions.font14,
                    color: mainColor,
                    fontFamily: semiBold,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Text(
                  widget.file.subTitle.toString(),
                  style: TextStyle(
                    fontSize: Dimensions.font14,
                    color: mainColor,
                    fontFamily: medium,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  bottomSheetWidget(String image, String name, String id) {
    selectedCategoryIndex = -1;
    Get.bottomSheet(
      GetBuilder(
        init: Get.find<VideoAnimationListController>(),
        initState: (state) {
          Get.find<VideoAnimationListController>().getVideoPlanListApi(id);
        },
        builder: (contextCtrl) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SafeArea(
                child: Wrap(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: image.isEmpty
                                      ? Image.asset(
                                          coachTopImg,
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          errorWidget: (context, url, error) => Image.asset(
                                            coachTopImg,
                                            fit: BoxFit.cover,
                                          ),
                                          fit: BoxFit.cover,
                                          imageUrl: image.toString(),
                                          placeholder: (a, b) => const Center(
                                            child: CircularProgressIndicator(
                                              color: mainColor,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.amount = "0";
                                  controller.packageId = "";
                                  controller.amount = "";
                                  Get.back();
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    height: 24,
                                    width: 24,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            name.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: mainColor,
                              fontSize: Dimensions.font14,
                              fontFamily: regular,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Subscription",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: Dimensions.font14,
                              fontFamily: regular,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Builder(
                            builder: (context) {
                              if (contextCtrl.isLoading) {
                                return SizedBox(
                                  height: Dimensions.screenHeight - 500,
                                  width: Dimensions.screenWidth,
                                  child: const Center(
                                      child: CircularProgressIndicator(
                                    color: mainColor,
                                  )),
                                );
                              }
                              if (contextCtrl.plansList.isEmpty) {
                                return SizedBox(
                                  width: Dimensions.screenWidth,
                                  height: Dimensions.screenHeight - 500,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'No Plans',
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: Dimensions.font16,
                                          fontFamily: regular,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return SizedBox(
                                height: Dimensions.screenHeight - 500,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: contextCtrl.plansList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (selectedCategoryIndex == index) {
                                            controller.amount = "0";
                                            controller.packageId = "";
                                            controller.amount = "";
                                            _onCategorySelected(index);
                                          } else {
                                            controller.amount = contextCtrl.plansList[index].price.toString();
                                            controller.packageId = contextCtrl.plansList[index].packageId.toString();
                                            controller.categoryId = contextCtrl.plansList[index].categoryId.toString();
                                            _onCategorySelected(index);
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        margin: const EdgeInsets.symmetric(horizontal: 50),
                                        height: 50,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(
                                            width: 2,
                                            color: selectedCategoryIndex == index ? const Color(0xFFedb524) : Colors.black,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${contextCtrl.plansList[index].packagePrice}.0" == contextCtrl.plansList[index].packagePrice.toString()
                                                      ? ""
                                                      : "₹${contextCtrl.plansList[index].packagePrice}",
                                                  style: TextStyle(
                                                      decoration: TextDecoration.lineThrough,
                                                      color: lightGreyTxt,
                                                      fontFamily: regular,
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: Dimensions.font14 - 4),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  "₹ ${contextCtrl.plansList[index].packagePrice}",
                                                  style: TextStyle(
                                                    color: mainColor,
                                                    fontFamily: semiBold,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: Dimensions.font14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            contextCtrl.plansList[index].packageDiscount != null && contextCtrl.plansList[index].packageDiscount != ""
                                                ? Container(
                                                    height: 24,
                                                    width: 74,
                                                    decoration: BoxDecoration(
                                                      color: const Color.fromRGBO(244, 244, 244, 1),
                                                      borderRadius: BorderRadius.circular(3),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        contextCtrl.plansList[index].discountType == "Price"
                                                            ? "Save ₹${contextCtrl.plansList[index].packageDiscount}"
                                                            : "Save ${contextCtrl.plansList[index].packageDiscount}%",
                                                        style: TextStyle(
                                                          color: greenColorTxt,
                                                          fontStyle: FontStyle.normal,
                                                          fontFamily: medium,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: Dimensions.font14 - 4,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(
                                                    height: 24,
                                                  ),
                                            const Spacer(),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Unlock All Features",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: mainColor,
                              fontSize: Dimensions.font14,
                              fontFamily: regular,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              if (selectedCategoryIndex == -1) {
                                errorToast("Please select Plan");
                              } else {
                                controller.sendOrderRazor(
                                  controller.amount,
                                  user.user.value.email,
                                  user.user.value.mobile,
                                );
                              }
                            },
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 40),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "CONTINUE",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: Dimensions.font14,
                                      fontFamily: regular,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: Dimensions.iconSize20,
                                    color: mainColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      barrierColor: Colors.transparent,
      isDismissible: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      enableDrag: false,
      isScrollControlled: true,
    );
  }

  _onCategorySelected(int index) {
    if (selectedCategoryIndex == index) {
      selectedCategoryIndex = -1;
    } else {
      selectedCategoryIndex = index;
    }
    setState(() {});
  }
}
