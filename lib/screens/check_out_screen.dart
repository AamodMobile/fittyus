// ignore_for_file: unrelated_type_equality_checks, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/check_out_controller.dart';
import 'package:fittyus/screens/billing_details_screen.dart';
import 'package:fittyus/screens/offer_screen.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:fittyus/widgets/my_button.dart';

class CheckOutScreen extends StatefulWidget {
  final String coachId;
  final String packageId;
  final String sessionId;
  final String sessionType;

  const CheckOutScreen({super.key, required this.coachId, required this.packageId, required this.sessionId, required this.sessionType});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  CheckOutController controller = Get.put(CheckOutController());
  String? radioButtonItem;
  var paymentType;

  @override
  void initState() {
    controller.coachId = widget.coachId;
    controller.packageId = widget.packageId;
    controller.sessionId = widget.sessionId;
    controller.sessionType = widget.sessionType;
    controller.couponCode = "";
    controller.isLoading = true;
    controller.addressList.clear();
    super.initState();
  }

  @override
  void dispose() {
    controller.razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CheckOutController>(),
      initState: (state) {
        Get.find<CheckOutController>().checkOutDetails("", "");
        Get.find<CheckOutController>().addressListGet();
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
                      "Check Out",
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
            body: Builder(
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

                if (contextCtrl.checkOutData.value == "") {
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
                  children: [
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: const Color.fromRGBO(181, 178, 178, 1),
                          width: 1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.04),
                            offset: Offset(0, 0),
                            blurRadius: 5,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.04),
                            offset: Offset(0, 2),
                            blurRadius: 6,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
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
                                    child: contextCtrl.checkOutData.value.image != null && contextCtrl.checkOutData.value.image != ""
                                        ? CachedNetworkImage(
                                            errorWidget: (context, url, error) => Image.asset(
                                              certificateImg,
                                              fit: BoxFit.fill,
                                            ),
                                            fit: BoxFit.fill,
                                            imageUrl: ApiUrl.imageBaseUrl + contextCtrl.checkOutData.value.image.toString(),
                                            placeholder: (a, b) => const Center(
                                              child: CircularProgressIndicator(
                                                color: mainColor,
                                              ),
                                            ),
                                          )
                                        : Image.asset(
                                            defaultUser,
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
                                        contextCtrl.checkOutData.value.name.toString(),
                                        style: TextStyle(color: Colors.black, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                      ),
                                      Text(
                                        contextCtrl.checkOutData.value.coachType.toString(),
                                        style: TextStyle(color: lightGreyTxt, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
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
                                        contextCtrl.checkOutData.value.avgrating.toString(),
                                        style: const TextStyle(color: whiteColor, fontSize: 8, fontFamily: regular, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              contextCtrl.checkOutData.value.packageDetail != null && contextCtrl.checkOutData.value.packageDetail != ""
                                  ? contextCtrl.checkOutData.value.packageDetail!.packageDescription.toString()
                                  : "",
                              maxLines: 1,
                              style: TextStyle(color: Colors.black, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          widget.sessionType == "single"
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Duration",
                                        style: TextStyle(color: Colors.black, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                      ),
                                      Text(
                                        contextCtrl.checkOutData.value.packageDetail != null && contextCtrl.checkOutData.value.packageDetail != ""
                                            ? contextCtrl.checkOutData.value.packageDetail!.options.toString()
                                            : "",
                                        style: TextStyle(color: lightGreyTxt, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                      ),
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Price",
                                  style: TextStyle(color: Colors.black, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      contextCtrl.checkOutData.value.packageDetail != null && contextCtrl.checkOutData.value.packageDetail != ""
                                          ? "${contextCtrl.checkOutData.value.packageDetail?.packagePrice}" == contextCtrl.checkOutData.value.packageDetail?.originalTotalAmount.toString()
                                              ? ""
                                              : "₹${contextCtrl.checkOutData.value.packageDetail?.packagePrice}"
                                          : "",
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
                                      contextCtrl.checkOutData.value.packageDetail != null && contextCtrl.checkOutData.value.packageDetail != ""
                                          ? "₹ ${contextCtrl.checkOutData.value.packageDetail?.originalTotalAmount}"
                                          : "",
                                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          widget.sessionType == "single"
                              ? const SizedBox()
                              : const Divider(
                                  color: mainColor,
                                  height: 1,
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          widget.sessionType == "single"
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                offerIc,
                                                height: 15,
                                                width: 15,
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              Text(
                                                "Apply Code",
                                                style: TextStyle(color: subPrimaryCl, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => const OfferScreen());
                                            },
                                            child: Text(
                                              "View Offers",
                                              style: TextStyle(
                                                color: pGreen,
                                                fontFamily: medium,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                fontSize: Dimensions.font14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      contextCtrl.checkOutData.value.packageDetail!.couponCode != ""
                                          ? Column(
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Coupon code Apply :- ${contextCtrl.checkOutData.value.packageDetail!.couponCode.toString()}",
                                                        style: TextStyle(
                                                          color: subPrimaryCl,
                                                          fontFamily: semiBold,
                                                          fontWeight: FontWeight.w500,
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: Dimensions.font14 - 2,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Get.find<CheckOutController>().checkOutDetails("", "");
                                                      },
                                                      child: Text(
                                                        "Clear",
                                                        style: TextStyle(
                                                          color: redColor,
                                                          fontFamily: medium,
                                                          fontWeight: FontWeight.w500,
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: Dimensions.font14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                          const SizedBox(height: 10),
                          const Divider(color: mainColor, height: 1),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "Billing Details",
                              style: TextStyle(color: Colors.black, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Plan Amount",
                                  style: TextStyle(color: lightGreyTxt, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                ),
                                Text(
                                  contextCtrl.checkOutData.value.packageDetail != null && contextCtrl.checkOutData.value.packageDetail != ""
                                      ? "₹ ${contextCtrl.checkOutData.value.packageDetail!.originalTotalAmount.toString()}"
                                      : "",
                                  style: TextStyle(
                                    color: lightGreyTxt,
                                    fontFamily: medium,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: Dimensions.font14 - 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          widget.sessionType == "single"
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Offer Apply",
                                        style: TextStyle(color: lightGreyTxt, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                      ),
                                      Text(
                                        contextCtrl.checkOutData.value.packageDetail != null && contextCtrl.checkOutData.value.packageDetail != ""
                                            ? "₹ ${contextCtrl.checkOutData.value.packageDetail!.couponDiscount.toString()}"
                                            : "",
                                        style: TextStyle(color: lightGreyTxt, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                      ),
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: mainColor,
                            height: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount",
                                  style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                ),
                                Text(
                                  contextCtrl.checkOutData.value.packageDetail != null && contextCtrl.checkOutData.value.packageDetail != ""
                                      ? "₹${contextCtrl.checkOutData.value.packageDetail!.totalAmount.toString()}"
                                      : "",
                                  style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(color: Color.fromRGBO(237, 246, 255, 1)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 16,
                                    color: subPrimaryCl,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "Billing Address",
                                    style: TextStyle(color: subPrimaryCl, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => BillingDetailsScreen(isEdit: false));
                                },
                                child: Text(
                                  "Add Address",
                                  style: TextStyle(
                                      color: lightBlueCl,
                                      fontFamily: medium,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14 - 2),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: true,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                contextCtrl.addressList.isEmpty
                                    ? Text(
                                        " No Address fond please Add Address",
                                        style: TextStyle(
                                          color: lightBlueCl,
                                          fontFamily: medium,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: Dimensions.font14 - 2,
                                        ),
                                      )
                                    : SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.70,
                                              child: Text(
                                                "${contextCtrl.addressList[0].address},"
                                                "${contextCtrl.addressList[0].city},"
                                                "${contextCtrl.addressList[0].state},"
                                                "${contextCtrl.addressList[0].country}",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: lightBlueCl,
                                                  fontFamily: medium,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: Dimensions.font14 - 2,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() => BillingDetailsScreen(isEdit: true, addressList: contextCtrl.addressList[0]));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Icon(
                                                  Icons.edit,
                                                  size: Dimensions.iconSize24,
                                                  color: lightBlueCl,
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
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 49,
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      width: MediaQuery.of(context).size.width,
                      child: MyButton(
                        onPressed: () {
                          if (contextCtrl.addressList.isNotEmpty) {
                            contextCtrl.bookingType = widget.sessionType == "single" ? "single" : "category";
                            contextCtrl.checkOutData.value.packageDetail != null && contextCtrl.checkOutData.value.packageDetail != ""
                                ? contextCtrl.couponCode = contextCtrl.checkOutData.value.packageDetail!.couponCode != null && contextCtrl.checkOutData.value.packageDetail!.couponCode != ""
                                    ? contextCtrl.checkOutData.value.packageDetail!.couponCode.toString()
                                    : ""
                                : "";
                            contextCtrl.checkOutData.value.packageDetail != null && contextCtrl.checkOutData.value.packageDetail != ""
                                ? contextCtrl.amount =
                                    contextCtrl.checkOutData.value.packageDetail!.originalTotalAmount != null && contextCtrl.checkOutData.value.packageDetail!.originalTotalAmount != ""
                                        ? contextCtrl.checkOutData.value.packageDetail!.originalTotalAmount.toString()
                                        : ""
                                : "";
                            if (contextCtrl.checkOutData.value.packageDetail!.totalAmount.toString() == "0.00") {
                              contextCtrl.completeBooking(contextCtrl.checkOutData.value.id.toString(), contextCtrl.couponCode, contextCtrl.bookingType, "Online");
                            } else {
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
                                            Column(
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
                                                    "Select Payment Type",
                                                    style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: semiBold, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Radio(
                                                      fillColor: MaterialStateColor.resolveWith((states) => mainColor),
                                                      activeColor: mainColor,
                                                      value: 0,
                                                      groupValue: paymentType,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          paymentType = 0;
                                                          radioButtonItem = "razorpay";
                                                        });
                                                      },
                                                    ),
                                                    const Text(
                                                      "Razorpay",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontFamily: medium,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Visibility(
                                                  visible: false,
                                                  child: Row(
                                                    children: [
                                                      Radio(
                                                        fillColor: MaterialStateColor.resolveWith((states) => mainColor),
                                                        activeColor: mainColor,
                                                        value: 1,
                                                        groupValue: paymentType,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            paymentType = 1;
                                                            radioButtonItem = "paytm";
                                                          });
                                                        },
                                                      ),
                                                      const Text(
                                                        "Paytm",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontFamily: medium,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                MyButton(
                                                    onPressed: () {
                                                      if (paymentType == null) {
                                                        errorToast("SELECT PAYMENT TYPE");
                                                      } else {
                                                        if (paymentType == 0) {
                                                          controller.sendOrderRazor(
                                                            contextCtrl.checkOutData.value.packageDetail != null && contextCtrl.checkOutData.value.packageDetail != ""
                                                                ? " ${contextCtrl.checkOutData.value.packageDetail!.totalAmount.toString()}"
                                                                : "",
                                                            contextCtrl.addressList[0].email.toString(),
                                                            contextCtrl.addressList[0].mobile.toString(),
                                                          );
                                                        } else {
                                                          controller.startTransaction();
                                                        }
                                                      }
                                                    },
                                                    color: pGreen,
                                                    child: Center(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text: "Pay Now",
                                                          style:
                                                              TextStyle(color: whiteColor, fontFamily: semiBold, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                                          children: [
                                                            TextSpan(
                                                                text: contextCtrl.checkOutData.value.packageDetail != null && contextCtrl.checkOutData.value.packageDetail != ""
                                                                    ? " ₹ ${contextCtrl.checkOutData.value.packageDetail!.totalAmount.toString()}"
                                                                    : "")
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  height: 30,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                                  });
                            }
                          } else {
                            errorToast("Add Address Details First");
                            Get.to(() => BillingDetailsScreen(isEdit: false));
                          }
                        },
                        color: pGreen,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Pay Now",
                              style: TextStyle(color: whiteColor, fontFamily: semiBold, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                              children: [
                                TextSpan(
                                    text: contextCtrl.checkOutData.value.packageDetail != null && contextCtrl.checkOutData.value.packageDetail != ""
                                        ? " ₹ ${contextCtrl.checkOutData.value.packageDetail!.totalAmount.toString()}"
                                        : "")
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
