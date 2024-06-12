import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/my_plan_list_controller.dart';
import 'package:fittyus/model/my_plan_list_model.dart';
import 'package:fittyus/screens/give_feedback_screen.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPlanScreen extends StatefulWidget {
  const MyPlanScreen({super.key});

  @override
  State<MyPlanScreen> createState() => _MyPlanScreenState();
}

class _MyPlanScreenState extends State<MyPlanScreen> {
  MyPlanListController controller = Get.put(MyPlanListController());

  @override
  void initState() {
    controller.myPlanList.clear();
    controller.isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<MyPlanListController>(),
      initState: (state) {
        Get.find<MyPlanListController>().myPlanListApi();
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
                      "My Coaches",
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
                Builder(
                  builder: (context) {
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
                    if (contextCtrl.myPlanList.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                            ),
                            Image.asset(
                              noNotificationImg,
                              height: 196,
                              width: 196,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "You have no  plan now",
                              style: TextStyle(color: subPrimaryCl, fontFamily: semiBold, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                            ),
                          ],
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: contextCtrl.myPlanList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return myPlanListTile(contextCtrl.myPlanList[index]);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  myPlanListTile(MyPlanListModel list) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1), // Background color
        borderRadius: BorderRadius.circular(4), // Border radius
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            offset: Offset(0, 0),
            blurRadius: 5,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            offset: Offset(0, 2),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 18,
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  spreadRadius: 0,
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: list.image != null && list.image != ""
                                  ? CachedNetworkImage(
                                      errorWidget: (context, url, error) => Image.asset(coachTopImg, fit: BoxFit.fill),
                                      fit: BoxFit.fill,
                                      imageUrl: ApiUrl.imageBaseUrl + list.image.toString(),
                                      placeholder: (a, b) => const Center(
                                        child: CircularProgressIndicator(
                                          color: mainColor,
                                        ),
                                      ),
                                    )
                                  : Image.asset(
                                      slideThree,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 34,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list.name.toString(),
                                  style: TextStyle(color: Colors.black, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                ),
                                Text(
                                  list.coachType.toString(),
                                  style: TextStyle(color: lightGreyTxt, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 14,
                            width: 36,
                            decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(18)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 10,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  list.averageRating.toString(),
                                  style: const TextStyle(color: whiteColor, fontSize: 8),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              ),
              list.dayCount == 0
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: 110,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Plan Expried",
                          style: TextStyle(color: Colors.red, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), // Border radius
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(210, 219, 222, 0.63),
                  Color.fromRGBO(138, 197, 216, 0),
                ],
                stops: [0, 0.93, 0], // Gradient stops
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0, 4), // Shadow position (X, Y)
                  blurRadius: 4, // Blur radius
                  spreadRadius: 0, // Spread radius
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      list.duration.toString(),
                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "₹ ${list.paidTotal} Paid",
                      style: TextStyle(color: const Color(0xFF388E2A), fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        list.dayCount == 0
                            ? Get.to(() => GiveFeedBackScreen(
                                  coach: list,
                                ))
                            : null;
                      },
                      child: Text(
                        list.dayCount == 0 ? "Give Rate" : "${list.dayCount} days Left",
                        style: TextStyle(color: const Color(0xFFFE2121), fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                      ),
                    ),
                    const SizedBox(height: 10),
                    list.dayCount == 0
                        ? RatingBar.builder(
                            initialRating: double.parse(list.averageRating.toString()),
                            minRating: 1,
                            ignoreGestures: true,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 16.0,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          )
                        : InkWell(
                            onTap: () async {
                              Log.console("Join");
                              try {
                                String url = list.meetingLink??"";
                                if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
                                  throw 'Could not launch $url';
                                }
                              } catch (e) {
                                Log.console(e);
                              }
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 24,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: pGreen),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Join Now",
                                      style: TextStyle(color: pGreen, fontFamily: medium, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}
