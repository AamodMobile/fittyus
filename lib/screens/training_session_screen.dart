// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/home_controller.dart';
import 'package:fittyus/controller/session_list_controller.dart';
import 'package:fittyus/model/session_list_model.dart';
import 'package:fittyus/screens/training_session_details_screen.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:fittyus/widgets/custom_calender.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TrainingSessionScreen extends StatefulWidget {
  const TrainingSessionScreen({super.key});

  @override
  State<TrainingSessionScreen> createState() => _TrainingSessionScreenState();
}

class _TrainingSessionScreenState extends State<TrainingSessionScreen> {
  SessionListController controller = Get.put(SessionListController());
  HomeController cont = Get.find();
  var date;
  var city;

  @override
  void initState() {
    controller.sessionList.clear();
    cont.getCurrentPosition();
    city = cont.city.value;
    date = dateSetOk(DateTime.now().toString());
    super.initState();
  }

  void _onDateSelected(DateTime d) {
    setState(() {
      var dates = dateSetOk(d.toString());
      var currentDateTime = DateTime.now();
      Duration oneDay = const Duration(days: 1);
      DateTime oneDayAgo = currentDateTime.subtract(oneDay);
      if (d.isBefore(oneDayAgo)) {
        date = dateSetOk(DateTime.now().toString());
        controller.sessionListApi(dates, city);
        errorToast("This is not a valid date.");
      } else {
        setState(() {
          controller.sessionListApi(dates, city);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<SessionListController>(),
      initState: (state) {
        if (cont.city.value == "") {
          print("object");
          cont.getCheckInStatus();
        } else {
          print("here");
          Get.find<SessionListController>().sessionListApi(date, city);
        }
      },
      builder: (contextCtrl) {
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
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Text(
                        "Training session",
                        style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70,
                        child: DatePickerCustom(onDateSelected: _onDateSelected),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (contextCtrl.isLoading) {
                      return SizedBox(
                        height: Dimensions.screenHeight - 300,
                        width: Dimensions.screenWidth,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: mainColor,
                          ),
                        ),
                      );
                    }
                    if (contextCtrl.sessionList.isEmpty) {
                      return  SizedBox(
                        width: Dimensions.screenWidth,
                        height: Dimensions.screenHeight - 300,
                        child: Image.asset(
                          noData,
                          fit: BoxFit.contain,
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: contextCtrl.sessionList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return sessionListTile(contextCtrl.sessionList[index]);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  sessionListTile(SessionListModel list) {
    String dateString = list.sessionDate.toString();
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMM').format(dateTime);
    Log.console(formattedDate);
    return InkWell(
      onTap: () {
        Get.to(() => TrainingSessionDetailsScreen(list: list));
      },
      child: Column(
        children: [
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            padding: const EdgeInsets.only(top: 4, right: 10, left: 6, bottom: 7),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 60,
                          child: Text(
                            list.timeslots != null ? list.timeslots.toString() : "",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: mainColor, fontFamily: bold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: list.sessionImage!=""
                                ? CachedNetworkImage(
                                    errorWidget: (context, url, error) => Image.asset(
                                      certificateImg,
                                      fit: BoxFit.cover,
                                    ),
                                    fit: BoxFit.fill,
                                    imageUrl: ApiUrl.imageBaseUrl + list.sessionImage.toString(),
                                    placeholder: (a, b) => const Center(
                                      child: CircularProgressIndicator(
                                        color: mainColor,
                                      ),
                                    ),
                                  )
                                : Image.asset(
                                    demoImgTraining,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list.name.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: mainColor, fontFamily: bold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Slots",
                            style: TextStyle(
                              color: lightGreyTxt,
                              fontSize: 10,
                              fontFamily: regular,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Text(
                            "${list.totalSeats!.toInt() - list.remainingSeat!.toInt()}/${list.totalSeats}",
                            style: const TextStyle(
                              color: lightGreyTxt,
                              fontSize: 12,
                              fontFamily: medium,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(4)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Only ${list.remainingSeat.toString()} Left",
                                  style: TextStyle(color: mainColor, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (list.remainingSeat == 0) {
                                      errorToast("This session is booked");
                                    } else {
                                      if (list.isUser == 1) {
                                        errorToast("All Ready Booked");
                                      } else {
                                        controller.addToCardPlan(
                                          list.coachId.toString(),
                                          list.id.toString(),
                                          list.id.toString(),
                                          "single",
                                          list.timeSlotId.toString(),
                                        );
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 32,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: whiteColor,
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
                                        style: TextStyle(color: pGreen, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: lightGry,
          )
        ],
      ),
    );
  }

  dateSetOk(String s) {
    DateTime timestamp = DateTime.parse(s);
    String formattedDate = DateFormat('yyyy-MM-dd').format(timestamp);
    return formattedDate;
  }
}
