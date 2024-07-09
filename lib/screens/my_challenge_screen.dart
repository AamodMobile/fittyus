import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/challenges_controller.dart';
import 'package:fittyus/model/my_challenge_model.dart';
import 'package:fittyus/screens/add_challenge_post.dart';
import 'package:fittyus/screens/new_profile_screen.dart';
import 'package:fittyus/screens/play_reels_screen.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:fittyus/widgets/my_button.dart';

class MyChallengesScreen extends StatefulWidget {
  const MyChallengesScreen({super.key});

  @override
  State<MyChallengesScreen> createState() => _MyChallengesScreenState();
}

class _MyChallengesScreenState extends State<MyChallengesScreen> {
  ChallengesController cont = Get.put(ChallengesController());

  @override
  void initState() {
    cont.myChallengeList.clear();
    cont.isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<ChallengesController>(),
        initState: (state) {
          Get.find<ChallengesController>().myChallengeListApi();
        },
        builder: (contextCtrl) {
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
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "My Challenges",
                        style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 17),
                    Builder(builder: (context) {
                      if (contextCtrl.isLoading) {
                        return SizedBox(
                          height: Dimensions.screenHeight - 200,
                          width: Dimensions.screenWidth,
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: mainColor,
                          )),
                        );
                      }

                      if (contextCtrl.allChallengeList.isEmpty) {
                        return  SizedBox(
                          height: Dimensions.screenHeight - 200,
                          width: Dimensions.screenWidth,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: mainColor,
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.2), width: 1)),
                            child: Column(
                              children: [
                                Text(
                                  "Challengers",
                                  style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                                ),
                                const SizedBox(height: 2),
                                SizedBox(
                                  height: 151,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: contextCtrl.relatedParticipant.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(() => NewProfileScreen(id: contextCtrl.relatedParticipant[index].userId.toString()));
                                          },
                                          child: Container(
                                            height: 151,
                                            width: 78,
                                            margin: const EdgeInsets.symmetric(horizontal: 0.5),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 101,
                                                  width: 78,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(9),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(9),
                                                    child: contextCtrl.relatedParticipant[index].profileImage != "" && contextCtrl.relatedParticipant[index].profileImage != null
                                                        ? CachedNetworkImage(
                                                            errorWidget: (context, url, error) => Image.asset(
                                                              demoImg,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            fit: BoxFit.cover,
                                                            imageUrl: contextCtrl.relatedParticipant[index].profileImage.toString(),
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
                                                const SizedBox(height: 5),
                                                Text(
                                                  contextCtrl.relatedParticipant[index].userName.toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(color: mainColor, fontFamily: medium, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 8),
                                                ),
                                                Text(
                                                  contextCtrl.relatedParticipant[index].challengeTitle.toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(color: greyColorTxt, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 7),
                                                ),
                                                Text("\n${contextCtrl.relatedParticipant[index].occupation ?? ""}",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(color: dividerCl, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 6)),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: contextCtrl.myChallengeList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return myChallengeListModel(contextCtrl.myChallengeList[index]);
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          );
        });
  }

  myChallengeListModel(MyChallenge list) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color.fromRGBO(0, 0, 0, 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  list.title.toString(),
                  style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                ),
                const SizedBox(height: 5),
                Text(
                  "Starts  : ${list.startDate.toString()}",
                  style: TextStyle(color: dividerCl, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                ),
                Text(
                  "End      : ${list.endDate.toString()}",
                  style: TextStyle(color: dividerCl, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                ),
                const SizedBox(height: 2),
                Text(
                  "Participants Enrolled: ${list.totalParticipant.toString()}",
                  style: TextStyle(color: dividerCl, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: InkWell(
              onTap: () {
                Get.to(() => AddChallengePostScreen(id: list.challengePostId.toString()));
              },
              child: Row(
                children: [
                  Image.asset(
                    videoIc,
                    width: 28,
                    height: 25,
                  ),
                  const SizedBox(width: 2),
                  SizedBox(
                    height: 15,
                    width: 62,
                    child: MyButton(
                      color: mainColor,
                      onPressed: () {
                        Get.to(() => AddChallengePostScreen(id: list.challengePostId.toString()));
                      },
                      child: const Text(
                        "Add Video",
                        style: TextStyle(color: whiteColor, fontFamily: regular, fontWeight: FontWeight.w500, fontSize: 8, fontStyle: FontStyle.normal),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 9),
          list.paticipantPost!.isEmpty
              ? Align(
                  alignment: Alignment.center,
                  child: Text(
                    "No  Video",
                    style: TextStyle(color: mainColor, fontFamily: medium, fontWeight: FontWeight.w500, fontSize: 14, fontStyle: FontStyle.normal),
                  ),
                )
              : SizedBox(
                  height: 71,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ListView.builder(
                        itemCount: list.paticipantPost!.length,
                        reverse: false,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Get.to(() => PlayReelsScreen(id: list.paticipantPost![index].id!));
                            },
                            child: Container(
                              height: 71,
                              width: 90,
                              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(1, 1),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: list.paticipantPost![index].videoThumbnail != null && list.paticipantPost![index].videoThumbnail != ""
                                    ? CachedNetworkImage(
                                        errorWidget: (context, url, error) => Image.asset(
                                          demoImg,
                                          fit: BoxFit.cover,
                                        ),
                                        fit: BoxFit.cover,
                                        imageUrl: ApiUrl.imageBaseUrl + list.paticipantPost![index].videoThumbnail.toString(),
                                        placeholder: (a, b) => const Center(
                                          child: CircularProgressIndicator(
                                            color: mainColor,
                                          ),
                                        ),
                                      )
                                    : Image.asset(demoImg, fit: BoxFit.cover),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
