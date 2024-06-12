import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/challenges_controller.dart';
import 'package:fittyus/model/challenge_list_model.dart';
import 'package:fittyus/screens/challenge_details_screen.dart';
import 'package:fittyus/screens/my_challenge_screen.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:fittyus/widgets/my_button.dart';

class NewChallengeScreen extends StatefulWidget {
  const NewChallengeScreen({super.key});

  @override
  State<NewChallengeScreen> createState() => _NewChallengeScreenState();
}

class _NewChallengeScreenState extends State<NewChallengeScreen> {
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
          preferredSize:
          Size(Dimensions.height90, MediaQuery
              .of(context)
              .size
              .width),
          child: Container(
            height: Dimensions.height45 + Dimensions.height20,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(color: whiteColor, boxShadow: [
              BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 15,
                  spreadRadius: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.2))
            ]),
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
                  style: TextStyle(
                      color: mainColor,
                      fontFamily: semiBold,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: Dimensions.font16),
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
              height: 18,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: whiteColor, border: Border.all(color: grayNew)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Challenges",
                      style: TextStyle(
                          color: mainColor,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font16),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(()=>const MyChallengesScreen());
                    },
                    child: Text(
                      "My Challenges",
                      style: TextStyle(
                          color: mainColor,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
                height: Dimensions.screenHeight - 200,
                child: const AllChallengeScreen())
          ],
        ),
      ),
    );
  }
}

class AllChallengeScreen extends StatefulWidget {
  const AllChallengeScreen({super.key});

  @override
  State<AllChallengeScreen> createState() => _AllChallengeScreenState();
}

class _AllChallengeScreenState extends State<AllChallengeScreen> {
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
                        width: Dimensions.screenWidth,
                        height: Dimensions.screenHeight - 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'No  Challenge Found',
                              style: TextStyle(
                                  color: mainColor,
                                  fontSize: Dimensions.font16 + 2,
                                  fontFamily: regular,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: contextCtrl.allChallengeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return allChallengeListTile(
                              contextCtrl.allChallengeList[index]);
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color:const Color.fromRGBO(0, 0, 0, 0.2),),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list.title.toString(),
                    style: TextStyle(
                        color: mainColor,
                        fontFamily: semiBold,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: Dimensions.font16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                       "Starts  : ${list.startDate.toString()}" ,
                      style: TextStyle(
                          color: dividerCl,
                          fontFamily: medium,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font14 - 2),
                    ),
                  Text(
                    "End      : ${list.endDate.toString()}" ,
                    style: TextStyle(
                        color: dividerCl,
                        fontFamily: medium,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: Dimensions.font14 - 2),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Participants Enrolled: ${list.totalParticipants.toString()}" ,
                    style: TextStyle(
                        color: dividerCl,
                        fontFamily: medium,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: Dimensions.font14 - 2),
                  ),
                  const SizedBox(height: 9),
                  SizedBox(
                    height: 34,
                    width: 124,
                    child: MyButton(
                      color:pGreen,
                      onPressed: (){
                        Get.to(() => ChallengeDetailsScreen(id: list.id.toString()));
                      },
                      child: const Text(
                        "Expand",
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: medium
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 109,
            width: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9)
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: list.challengeBanner != null &&
                    list.challengeBanner != ""
                    ? CachedNetworkImage(
                  errorWidget: (context, url, error) =>
                      Image.asset(
                        demoImg,
                        fit: BoxFit.cover,
                      ),
                  fit: BoxFit.cover,
                  imageUrl: ApiUrl.imageBaseUrl + list.challengeBanner.toString(),
                  placeholder: (a, b) =>
                  const Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  ),
                )
                    : Image.asset(demoImg, fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }
}
