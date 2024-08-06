// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/challenges_controller.dart';
import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/screens/new_profile_screen.dart';
import 'package:fittyus/screens/video_play_screen.dart';
import 'package:fittyus/screens/web_view_.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:fittyus/widgets/my_button.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ChallengeDetailsScreen extends StatefulWidget {
  final String id;

  const ChallengeDetailsScreen({super.key, required this.id});

  @override
  State<ChallengeDetailsScreen> createState() => _ChallengeDetailsScreenState();
}

class _ChallengeDetailsScreenState extends State<ChallengeDetailsScreen> {
  ChallengesController controller = Get.put(ChallengesController());
  UserController user = Get.put(UserController());
  var thumbPath;

  @override
  void initState() {
    user.getProfile();

    super.initState();
  }

  Future<void> _generateThumbnail() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: controller.challengeDetails.value.video.toString(),
        thumbnailPath: tempDir.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 1000,
        maxHeight: 1000,
      );
      setState(() {
        thumbPath = thumbnailPath;
      });
    } catch (e) {
      Log.console('Error generating thumbnail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ChallengesController>(),
      initState: (state) {
        Get.find<ChallengesController>().getChallengeDetailsApi(widget.id).then((value) {
          _generateThumbnail();
        });
      },
      builder: (contextCtr) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar: PreferredSize(
              preferredSize: Size(Dimensions.height90, MediaQuery.of(context).size.width),
              child: Container(
                height: Dimensions.height45 + Dimensions.height20,
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  ],
                ),
              ),
            ),
            body: Builder(builder: (context) {
              if (contextCtr.isLoading) {
                return SizedBox(
                  height: Dimensions.screenHeight - 200,
                  width: Dimensions.screenWidth,
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: mainColor,
                  )),
                );
              }

              if (contextCtr.challengeDetails == "") {
                return SizedBox(
                  width: Dimensions.screenWidth,
                  height: Dimensions.screenHeight - 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No Details Found',
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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 231,
                      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                          borderRadius: BorderRadius.circular(18)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: contextCtr.challengeDetails.value.challengeBanner == "" && contextCtr.challengeDetails.value.challengeBanner == null
                            ? Image.asset(
                                coachTopImg,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                errorWidget: (context, url, error) => Image.asset(
                                  coachTopImg,
                                  fit: BoxFit.fill,
                                ),
                                fit: BoxFit.fill,
                                imageUrl: ApiUrl.imageBaseUrl + contextCtr.challengeDetails.value.challengeBanner.toString(),
                                placeholder: (a, b) => const Center(
                                  child: CircularProgressIndicator(
                                    color: mainColor,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Participants",
                        style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.2), width: 1)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 205,
                            width: MediaQuery.of(context).size.width,
                            child: contextCtr.challengeDetails.value.participantPost!.isEmpty
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "No Participants",
                                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: contextCtr.challengeDetails.value.participantPost?.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.to(() => NewProfileScreen(id: contextCtr.challengeDetails.value.participantPost![index].userId.toString()));
                                        },
                                        child: Container(
                                          height: 205,
                                          width: 113,
                                          margin: const EdgeInsets.symmetric(horizontal: 2),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 149,
                                                width: 113,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(9),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(9),
                                                  child: contextCtr.challengeDetails.value.participantPost![index].profileImage == "" &&
                                                          contextCtr.challengeDetails.value.participantPost![index].profileImage == null
                                                      ? Image.asset(
                                                          demoImg,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : CachedNetworkImage(
                                                          errorWidget: (context, url, error) => Image.asset(
                                                            demoImg,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          fit: BoxFit.fill,
                                                          imageUrl: contextCtr.challengeDetails.value.participantPost![index].profileImage.toString(),
                                                          placeholder: (a, b) => const Center(
                                                            child: CircularProgressIndicator(
                                                              color: mainColor,
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  text: contextCtr.challengeDetails.value.participantPost![index].userName.toString(),
                                                  style: const TextStyle(color: mainColor, fontFamily: medium, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 8),
                                                  children: [
                                                    TextSpan(
                                                        text: " \n${contextCtr.challengeDetails.value.title.toString()}",
                                                        style: const TextStyle(color: greyColorTxt, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 7)),
                                                    TextSpan(
                                                        text: "\n${contextCtr.challengeDetails.value.participantPost![index].occupation ?? ""}",
                                                        style: const TextStyle(color: dividerCl, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 6)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Video",
                        style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: contextCtr.challengeDetails.value.video == ""
                          ? Center(
                              child: Text(
                                "No Video yet",
                                style: TextStyle(color: lightGreyTxt, fontFamily: regular, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Get.to(() => VideoPlayScreen(file: contextCtr.challengeDetails.value.video.toString(), id: contextCtr.challengeDetails.value.id!.toInt()));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 175,
                                height: 115,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  border: Border.all(color: Colors.black),
                                  // Secondary color
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(255, 186, 0, 0.04),
                                      offset: Offset(0, 4),
                                      blurRadius: 20,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: thumbPath != null
                                          ? Image.file(File(thumbPath))
                                          : Image.asset(
                                              coachTopImg,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        playIc,
                                        height: 30,
                                        width: 30,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Activity Level : Highly Active",
                        style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Center(
                        child: Html(
                          data: contextCtr.challengeDetails.value.activityLevel,
                          style: {
                            "body": Style(
                              fontSize: FontSize(Dimensions.font14 - 4),
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontFamily: medium,
                              color: subPrimaryCl,
                            ),
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Disclaimer",
                        style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Please read the attach document",
                        style: TextStyle(color: greyColorTxt, fontFamily: semiBold, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Get.to(() => WebViewScreen(url: ApiUrl.imageBaseUrl + contextCtr.challengeDetails.value.challengeAttachment.toString()));
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          paperIc,
                          width: 71,
                          height: 62,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              );
            }),
            bottomSheet: controller.isLoading
                ? const SizedBox()
                : Row(
                    children: [
                      Container(
                        color: whiteColor,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Container(
                            height: 36,
                            width: 110,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(color: pGreen),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Price ₹${controller.challengeDetails.value.price.toString()}",
                                  style: TextStyle(color: pGreen, fontFamily: medium, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: MyButton(
                              color: pGreen,
                              onPressed: () {
                                if (controller.challengeDetails.value.isJoin == 1) {
                                  controller.leaveChallenge(widget.id);
                                } else {
                                  controller.challengeId = widget.id;
                                  var finalPrice = controller.challengeDetails.value.price.toString();
                                  controller.sendOrderRazor(finalPrice, user.user.value.email, user.user.value.mobile);
                                }
                              },
                              child: Text(
                                controller.challengeDetails.value.isJoin == 1 ? "Leave Group" : "Join",
                                style: TextStyle(color: whiteColor, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
