import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/challenges_controller.dart';
import 'package:fittyus/model/challenge_list_model.dart';
import 'package:fittyus/screens/challenge_details_screen.dart';
import 'package:fittyus/screens/my_challenge_screen.dart';
import 'package:fittyus/screens/play_reels_screen.dart';
import 'package:fittyus/services/api_url.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  ChallengesController cont = Get.put(ChallengesController());

  @override
  void initState() {
    cont.allChallengeList.clear();
    cont.myChallengeList.clear();
    cont.isLoading = true;
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
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Challenges",
                  style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: 50,
              child: TabBar(
                controller: _tabController,
                indicatorColor: mainColor,
                unselectedLabelColor: Colors.grey,
                labelColor: mainColor,
                labelStyle: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                tabs: const [
                  Tab(
                    text: "Challenges",
                  ),
                  Tab(text: "My Challenges")
                ],
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: const [
                  ExploreScreen(),
                  MyChallengesScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ChallengesController cont = Get.put(ChallengesController());

  @override
  void initState() {
    cont.allChallengeList.clear();
    cont.isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<ChallengesController>(),
        initState: (state) {
          Get.find<ChallengesController>().getAllChallengeListApi();
        },
        builder: (contextCtrl) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: whiteColor,
              body: Column(
                children: [
                  Builder(builder: (context) {
                    if (contextCtrl.isLoading) {
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

                    if (contextCtrl.allChallengeList.isEmpty) {
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
                    return Expanded(
                      child: ListView.builder(
                        itemCount: contextCtrl.allChallengeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return allChallengeListTile(contextCtrl.allChallengeList[index]);
                        },
                      ),
                    );
                  })
                ],
              ),
            ),
          );
        });
  }

  allChallengeListTile(ChallengeListModel list) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: dividerCl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => ChallengeDetailsScreen(id: list.id.toString()));
                },
                child: Row(
                  children: [
                    Text(
                      list.title.toString(),
                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.play_arrow_sharp,
                      size: Dimensions.iconSize16,
                      color: mainColor,
                    )
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: Dimensions.iconSize20,
                color: mainColor,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: list.startDate.toString(),
              style: TextStyle(color: dividerCl, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
              children: [
                const TextSpan(text: " to"),
                TextSpan(text: list.endDate.toString()),
                const TextSpan(text: " | "),
                TextSpan(text: list.totalParticipants.toString()),
                const TextSpan(text: " Participants"),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          list.participantPost!.isEmpty || list.participantPost == null
              ? Center(
                  child: SizedBox(
                    child: Text(
                      'No  Post ',
                      style: TextStyle(color: mainColor, fontSize: Dimensions.font16 + 2, fontFamily: regular, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              : SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: list.participantPost?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => PlayReelsScreen(id: list.participantPost![index].id!.toInt()));
                        },
                        child: Container(
                          height: 150,
                          width: 95,
                          margin: const EdgeInsets.all(5),
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
                            child: list.participantPost![index].videoThumbnail != null && list.participantPost![index].videoThumbnail != ""
                                ? CachedNetworkImage(
                                    errorWidget: (context, url, error) => Image.asset(
                                      demoImg,
                                      fit: BoxFit.cover,
                                    ),
                                    fit: BoxFit.cover,
                                    imageUrl: ApiUrl.imageBaseUrl + list.participantPost![index].videoThumbnail.toString(),
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
                      );
                    },
                  ),
                ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Registration Closed",
              style: TextStyle(color: greyColorTxt, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
            ),
          )
        ],
      ),
    );
  }
}
