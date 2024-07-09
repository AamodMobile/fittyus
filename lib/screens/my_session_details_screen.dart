import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/my_session_details_controller.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:fittyus/widgets/my_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class MySessionDetailsScreen extends StatefulWidget {
  final String sessionId;

  const MySessionDetailsScreen({
    super.key,
    required this.sessionId,
  });

  @override
  State<MySessionDetailsScreen> createState() => _MySessionDetailsScreenState();
}

class _MySessionDetailsScreenState extends State<MySessionDetailsScreen> {
  MySessionDetailsController controller = Get.put(MySessionDetailsController());

  @override
  void initState() {
    controller.isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<MySessionDetailsController>(),
        initState: (state) {
          Get.find<MySessionDetailsController>()
              .mySessionDetailsApi(widget.sessionId.toString());
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
                        "Session Details",
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
              body: SafeArea(child: Builder(builder: (context) {
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

                if (contextCtrl.mySessionDetails == "") {
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
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 10, width: MediaQuery.of(context).size.width),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Text(
                        contextCtrl.mySessionDetails.value.name.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: mainColor,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4,
                              spreadRadius: 1)
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            contextCtrl.mySessionDetails.value.shortDescription
                                .toString(),
                            style: TextStyle(
                              fontSize: Dimensions.font14,
                              color: mainColor,
                              fontFamily: medium,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Text(
                                  "Session Date:-",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: medium,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Text(
                                  contextCtrl.mySessionDetails.value.sessionDate
                                      .toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: medium,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Text(
                                  "TimeSlot:-",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: medium,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Text(
                                  contextCtrl.mySessionDetails.value.timeSlot
                                      .toString(),
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: medium,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                         /* Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Text(
                                  "Category:-",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: medium,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Text(
                                  contextCtrl.mySessionDetails.value.categoryName
                                      .toString(),
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: medium,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Text(
                                  "Total seat:-",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: medium,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Text(
                                  contextCtrl.mySessionDetails.value.totalSeats
                                      .toString(),
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: medium,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4,
                                spreadRadius: 1)
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Coach",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: mainColor,
                                  fontFamily: extraBold,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: Dimensions.font14),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              contextCtrl.mySessionDetails.value.teacherName
                                  .toString(),
                              style: TextStyle(
                                  color: mainColor,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: Dimensions.font16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: contextCtrl
                                      .mySessionDetails.value.averageRating!=null?double.parse(contextCtrl
                                      .mySessionDetails.value.averageRating
                                      .toString()):0,
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
                                  "${contextCtrl.mySessionDetails.value.averageRating}/5",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    color: mainColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        )),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: borderColorCont,
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Visibility(
                            visible:
                                contextCtrl.mySessionDetails.value.isExpire == 1
                                    ? false
                                    : true,
                            child: SizedBox(
                              width: 65,
                              child: MyButton(
                                onPressed: () async {
                                  Log.console("Join");
                                  try {
                                    String url =
                                        "classes_list[index]['webx_link']";
                                    if (!await launchUrl(Uri.parse(url),
                                        mode: LaunchMode.externalApplication)) {
                                      throw 'Could not launch $url';
                                    }
                                  } catch (e) {
                                    Log.console(e);
                                  }
                                },
                                color: mainColor,
                                child: const Text(
                                  'Join Now',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible:
                                contextCtrl.mySessionDetails.value.isExpire == 1
                                    ? true
                                    : false,
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
                  ],
                );
              })),
            ),
          );
        });
  }
}
