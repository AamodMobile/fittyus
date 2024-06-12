import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/coach_details_controller.dart';
import 'package:fittyus/controller/session_list_controller.dart';
import 'package:fittyus/model/session_list_model.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:flutter_html/flutter_html.dart';

class TrainingSessionDetailsScreen extends StatefulWidget {
  final SessionListModel list;

  const TrainingSessionDetailsScreen({super.key, required this.list});

  @override
  State<TrainingSessionDetailsScreen> createState() =>
      _TrainingSessionDetailsScreenState();
}

class _TrainingSessionDetailsScreenState
    extends State<TrainingSessionDetailsScreen> {
  SessionListController controller = Get.put(SessionListController());
  CoachDetailsController cont = Get.put(CoachDetailsController());

  @override
  void initState() {
    controller.isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<CoachDetailsController>(),
        initState: (state) {
          Get.find<CoachDetailsController>()
              .getCoachDetailsApi(widget.list.coachId.toString());
        },
        builder: (contextCtrl) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: whiteColor,
              appBar: PreferredSize(
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
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
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

                      if (contextCtrl.coachDetails == "") {
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
                              widget.list.name.toString(),
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
                                  widget.list.shortDescription.toString(),
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
                                        widget.list.sessionDate.toString(),
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
                                        widget.list.timeslots.toString(),
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
                                        widget.list.categoryName.toString(),
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
                                        widget.list.totalSeats.toString(),
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
                                  SizedBox(
                                    height: 150,
                                    width: Get.width,
                                    child: ClipRRect(
                                      child: contextCtrl.coachDetails.value.image !=
                                                  null &&
                                              contextCtrl.coachDetails.value.image != ""
                                          ? Image.network(
                                              ApiUrl.imageBaseUrl +
                                                  contextCtrl.coachDetails.value.image
                                                      .toString(),
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              coachTopImg,
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 18.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          contextCtrl.coachDetails.value.name
                                              .toString(),
                                          style: TextStyle(
                                              color: mainColor,
                                              fontFamily: semiBold,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              fontSize: Dimensions.font16),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(right: 10),
                                          height: 20,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius: BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: Dimensions.iconSize14 - 2,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                contextCtrl
                                                    .coachDetails.value.averageRating
                                                    .toString(),
                                                style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: Dimensions.font14 - 4,
                                                  fontFamily: medium,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 18.0),
                                    child: Text(
                                      "About ",
                                      style: TextStyle(
                                          color: lightGreyTxt,
                                          fontFamily: medium,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: Dimensions.font14),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 18.0),
                                    child: contextCtrl
                                                .coachDetails.value.aboutTeacher !=
                                            null
                                        ? Html(
                                            data: contextCtrl
                                                .coachDetails.value.aboutTeacher,
                                            style: {
                                              "body": Style(
                                                  fontSize: FontSize(Dimensions.font14 - 4),
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: medium,
                                                  color: subPrimaryCl,
                                                  maxLines: 3),
                                            },
                                          )
                                        : const SizedBox(),
                                  ),
                                ],
                              )),

                        ],
                      );
                    }),
                    const SizedBox(height: 100)
                  ],
                ),
              ),
              bottomSheet:contextCtrl.coachDetails == ""?SizedBox():
               Container(
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: borderColorCont,
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Only ${widget.list.remainingSeat.toString()} Left",
                      style: TextStyle(
                          color: subPrimaryCl,
                          fontFamily: regular,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font14 - 4),
                    ),
                    InkWell(
                      onTap: () {
                        if (widget.list.remainingSeat == 0) {
                          errorToast("This session is booked");
                        } else {
                          if (widget.list.isUser == 1) {
                            errorToast("All Ready Booked");
                          } else {
                            controller.addToCardPlan(
                                widget.list.coachId.toString(),
                                widget.list.id.toString(),
                                widget.list.id.toString(),
                                "single",
                                widget.list.timeslots.toString()
                            );
                          }
                        }
                      },
                      child: Container(
                        height: 32,
                        width: 90,
                        decoration: BoxDecoration(
                          color: pGreen,
                          border: Border.all(color: pGreen),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Reserve",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: Dimensions.font14),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
          
        });
  }
}
