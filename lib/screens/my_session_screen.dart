import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/my_session_list_controller.dart';
import 'package:fittyus/model/my_session_list_model.dart';
import 'package:fittyus/screens/give_feedback_screen.dart';
import 'package:fittyus/screens/my_session_details_screen.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:fittyus/widgets/my_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class MYSessionScreen extends StatefulWidget {
  const MYSessionScreen({super.key});

  @override
  State<MYSessionScreen> createState() => _MYSessionScreenState();
}

class _MYSessionScreenState extends State<MYSessionScreen> {
  MySessionListController controller = Get.put(MySessionListController());

  @override
  void initState() {
    controller.mySessionList.clear();
    controller.isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<MySessionListController>(),
      initState: (state) {
        Get.find<MySessionListController>().mySessionListApi();
      },
      builder: (contextCtrl) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar:  PreferredSize(
              preferredSize: Size(Dimensions.height90,MediaQuery.of(context).size.width),
              child: Container(
                height: Dimensions.height45+Dimensions.height20,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0,1),
                          blurRadius: 15,
                          spreadRadius: 0,
                          color: Color.fromRGBO(0, 0, 0, 0.2)
                      )
                    ]
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
                      "My Sessions",
                      style: TextStyle(
                          color: mainColor,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font16),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: false,
                      child: InkWell(
                          onTap: () {},
                          child:  Container(
                            height: 44,
                            width: 90,
                            margin: const EdgeInsets.only(right: 10),
                            child: MyButton(
                              onPressed: () {},
                              color: pGreen,
                              child: Center(
                                child: Text(
                                  "Clear All",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontFamily: semiBold,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14 - 2),
                                ),
                              ),
                            ),
                          )
                      ),
                    )
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
                    if (contextCtrl.mySessionList.isEmpty) {
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
                              "You have No  Session now",
                              style: TextStyle(
                                  color: subPrimaryCl,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: Dimensions.font14),
                            ),
                          ],
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: contextCtrl.mySessionList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return mySessionListTile(
                              contextCtrl.mySessionList[index]);
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

  mySessionListTile(MySessionListModel list) {
    return InkWell(
      onTap: () {
        Get.to(() => MySessionDetailsScreen(sessionId: list.id.toString()));
      },
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(3),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: mainColor, width: 1),
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: list.isExpire == 1 ? Colors.grey[300] : Colors.white,
            ),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          list.name.toString(),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: const TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Container(
                                height: 15.0,
                                width: 15.0,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/icons/ic_clock.png',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HelpScreen()));
                              },
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              list.timeSlot.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13.0,
                                color: greyColorTxt,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating:
                                double.parse(list.averageRating.toString()),
                            minRating: 1,
                            ignoreGestures: true,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              Log.console(rating);
                            },
                          ),
                          const SizedBox(width: 3),
                          Text(
                            "${list.averageRating}/5",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13.0,
                              color: mainColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      list.isExpire == 1
                          ? Container(
                              margin: const EdgeInsets.only(left: 5, top: 5),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() =>  GiveFeedBackScreen(id: list.coachId.toString(),));
                                },
                                child: const Text(
                                  'Add Review',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 10,
                            ),
                    ],
                  ),
                ),
                Visibility(
                  visible: list.isExpire == 1 ? false : true,
                  child: InkWell(
                    onTap: () async {
                      Log.console("Join");
                      try {
                        String url = list.meetingLink??"";
                        if (!await launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication)) {
                          throw 'Could not launch $url';
                        }
                      } catch (e) {
                        Log.console(e);
                      }
                    },
                    child:  Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: pGreen),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          "Join Now",
                          style: TextStyle(
                              color: pGreen,
                              fontFamily: medium,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: Dimensions.font14 - 4),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: list.isExpire == 1 ? true : false,
                  child: const SizedBox(
                    width: 65,
                    child: Text(
                      'Expired',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
