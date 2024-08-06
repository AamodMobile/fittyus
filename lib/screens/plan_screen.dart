// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/coach_plan_details_controller.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:fittyus/widgets/my_button.dart';

class PlanScreen extends StatefulWidget {
  final String coachId;

  const PlanScreen({super.key, required this.coachId});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  CoachPlansDetailsController controller = Get.put(CoachPlansDetailsController());
  String? radioButtonItem;
  var paymentType;

  @override
  void initState() {
    controller.plansList.clear();
    controller.isLoading = true;
    controller.getCoachPlanDetailsListApi(widget.coachId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CoachPlansDetailsController>(),
      initState: (state) {
        Get.find<CoachPlansDetailsController>().getCoachPlanDetailsListApi(widget.coachId);
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
                      "Plan",
                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: false,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: whiteColor,
                          ),
                          child: Center(
                            child: ImageIcon(
                              const AssetImage(filterIc),
                              size: Dimensions.iconSize20,
                              color: mainColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Builder(builder: (context) {
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
                          style: TextStyle(color: mainColor, fontSize: Dimensions.font16 + 2, fontFamily: regular, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(244, 244, 244, 1),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.04),
                            offset: Offset(0, 0),
                            blurRadius: 5,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.04),
                                    offset: Offset(0, 2),
                                    blurRadius: 6,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                      child: contextCtrl.coach.value.profileImage != null && contextCtrl.coach.value.profileImage != ""
                                          ? CachedNetworkImage(
                                              errorWidget: (context, url, error) => Image.asset(
                                                certificateImg,
                                                fit: BoxFit.fill,
                                              ),
                                              fit: BoxFit.fill,
                                              imageUrl: ApiUrl.imageBaseUrl + contextCtrl.coach.value.profileImage.toString(),
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
                                          contextCtrl.coach.value.name.toString(),
                                          style: TextStyle(color: Colors.black, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                        ),
                                        Text(
                                          contextCtrl.coach.value.coachType.toString(),
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
                                          contextCtrl.coachDetails.value.avgRating.toString(),
                                          style: const TextStyle(
                                            color: whiteColor,
                                            fontSize: 8,
                                          ),
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
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        "Select Plan",
                        style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      height: 200,
                      margin: const EdgeInsets.only(left: 15),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: contextCtrl.plansList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(right: 5),
                            height: 200,
                            width: 150,
                            decoration: const BoxDecoration(
                              image: DecorationImage(image: AssetImage(selectPlanImg), fit: BoxFit.cover),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    height: 16,
                                    width: 70,
                                    decoration: BoxDecoration(color: const Color.fromRGBO(244, 244, 244, 1), borderRadius: BorderRadius.circular(3)),
                                    child: Center(
                                      child: Text(
                                        "BestSeller",
                                        style: TextStyle(color: lightGreyTxt, fontStyle: FontStyle.normal, fontFamily: medium, fontWeight: FontWeight.w400, fontSize: Dimensions.font14 - 4),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  contextCtrl.plansList[index].options.toString(),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: const Color(0xFF1B63CE), fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${contextCtrl.plansList[index].packagePrice}.0" == contextCtrl.plansList[index].totalAmount.toString() ? "" : "₹${contextCtrl.plansList[index].packagePrice}",
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
                                      "₹ ${contextCtrl.plansList[index].totalAmount}",
                                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
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
                                        decoration: BoxDecoration(color: const Color.fromRGBO(244, 244, 244, 1), borderRadius: BorderRadius.circular(3)),
                                        child: Center(
                                          child: Text(
                                            contextCtrl.plansList[index].discountType == "Price"
                                                ? "Save ₹${contextCtrl.plansList[index].packageDiscount}"
                                                : "Save ${contextCtrl.plansList[index].packageDiscount}%",
                                            style: TextStyle(color: greenColorTxt, fontStyle: FontStyle.normal, fontFamily: medium, fontWeight: FontWeight.w400, fontSize: Dimensions.font14 - 4),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 24,
                                      ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        backgroundColor: whiteColor,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        context: context,
                                        builder: (BuildContext builderContext) {
                                          return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                              child: Wrap(
                                                children: [
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        const Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            "Select Time Slot",
                                                            style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: semiBold, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
                                                          ),
                                                        ),
                                                        MediaQuery.removePadding(
                                                          context: context,
                                                          removeTop: true,
                                                          child: ListView.builder(
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              scrollDirection: Axis.vertical,
                                                              shrinkWrap: true,
                                                              itemCount: contextCtrl.coach.value.timeslots!.length,
                                                              itemBuilder: (BuildContext context, int index) {
                                                                return SizedBox(
                                                                  height: 30,
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: Row(
                                                                    children: [
                                                                      Radio(
                                                                        fillColor: MaterialStateColor.resolveWith((states) => mainColor),
                                                                        activeColor: mainColor,
                                                                        value: index,
                                                                        groupValue: paymentType,
                                                                        onChanged: (val) {
                                                                          setState(() {
                                                                            paymentType = val;
                                                                            radioButtonItem = contextCtrl.coach.value.timeslots![index].id.toString();
                                                                          });
                                                                        },
                                                                      ),
                                                                      Text(
                                                                        contextCtrl.coach.value.timeslots![index].timeSlots.toString(),
                                                                        style: const TextStyle(
                                                                          fontSize: 16,
                                                                          color: Colors.black,
                                                                          fontFamily: medium,
                                                                          fontWeight: FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        MyButton(
                                                            onPressed: () {
                                                              if (paymentType == null) {
                                                                errorToast("SELECT time  slot");
                                                              } else {
                                                                controller.addToCardPlan(widget.coachId, contextCtrl.plansList[index].packageId.toString(), "0", "category", radioButtonItem.toString());
                                                              }
                                                            },
                                                            color: pGreen,
                                                            child: Center(
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  text: "Pay Now",
                                                                  style: TextStyle(
                                                                      color: whiteColor, fontFamily: semiBold, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                                                ),
                                                              ),
                                                            )),
                                                        const SizedBox(
                                                          height: 30,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                        });
                                  },
                                  child: Container(
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
                                          "Pay Now ₹${contextCtrl.plansList[index].totalAmount}",
                                          style: TextStyle(color: pGreen, fontFamily: medium, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: List.generate(
                          contextCtrl.plansList.length,
                          (index) => Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              border: Border.all(color: dividerCl, width: 1),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Plan Details",
                                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                                    ),
                                    Text(
                                      contextCtrl.plansList[index].options.toString(),
                                      style: TextStyle(color: greenColorTxt, fontFamily: medium, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "What is Plan?",
                                  style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  contextCtrl.plansList[index].packageDescription.toString(),
                                  style: TextStyle(color: lightGreyTxt, fontFamily: regular, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
