// ignore_for_file: unrelated_type_equality_checks, invalid_use_of_protected_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/coach_details_controller.dart';
import 'package:fittyus/model/coach_details_model.dart';
import 'package:fittyus/screens/plan_screen.dart';
import 'package:fittyus/screens/video_play_screen.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../services/api_url.dart';

class CoachDetailsScreen extends StatefulWidget {
  final String coachId;

  const CoachDetailsScreen({super.key, required this.coachId});

  @override
  State<CoachDetailsScreen> createState() => _CoachDetailsScreenState();
}

class _CoachDetailsScreenState extends State<CoachDetailsScreen> {
  CarouselController carouselController = CarouselController();
  int selectedIndex = 0;
  int ind = 0;
  var imageList = [coachTopImg, coachTopImg, coachTopImg];
  CoachDetailsController controller = Get.put(CoachDetailsController());

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
        Get.find<CoachDetailsController>().getCoachDetailsApi(widget.coachId.toString());
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
                      "Coaches Details",
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
              child: Builder(
                builder: (context) {
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
                      /* SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider(
                      carouselController: carouselController,
                      options: CarouselOptions(
                        height: 212,
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,
                        pauseAutoPlayOnTouch: true,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          selectedIndex = index;
                          setState(() {
                            ind = index;
                          });
                        },
                      ),
                      items: List.generate(
                          contextCtrl.coachDetails.value.image!.length,
                          (indx) => InkWell(
                                onTap: () {},
                                child: */
                      SizedBox(
                        height: 212,
                        width: Get.width,
                        child: ClipRRect(
                          child: contextCtrl.coachDetails.value.image != null && contextCtrl.coachDetails.value.image != ""
                              ? Image.network(
                                  ApiUrl.imageBaseUrl + contextCtrl.coachDetails.value.image.toString(),
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  coachImg,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      //  ),
                      //   ),
                      // ),
                      // ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      /*  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      imageList.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        padding: const EdgeInsets.all(5),
                        height: 6,
                        width: index == ind ? 10 : 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: index == ind
                              ? mainColor
                              : const Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  ),*/
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              contextCtrl.coachDetails.value.name.toString(),
                              style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                            ),
                            /*  Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: 20,
                              width: 50,
                              decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    contextCtrl.coachDetails.value.averageRating.toString(),
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
                            )*/
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          "About ",
                          style: TextStyle(color: lightGreyTxt, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: contextCtrl.coachDetails.value.aboutTeacher != null
                            ? Html(
                                data: contextCtrl.coachDetails.value.aboutTeacher,
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(Dimensions.font14 - 4),
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: medium,
                                    color: subPrimaryCl,
                                  ),
                                },
                              )
                            : const SizedBox(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      contextCtrl.coachDetails.value.timeslots!.isNotEmpty
                          ? MediaQuery.removePadding(
                              context: context,
                              child: ListView.builder(
                                  itemCount: contextCtrl.coachDetails.value.timeslots!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.only(top: 2),
                                      color: const Color.fromRGBO(252, 247, 247, 1),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                                onTap: () {},
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                contextCtrl.coachDetails.value.timeslots![index].timeSlots.toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                  color: mainColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(228, 236, 255, 1),
                              Color.fromRGBO(217, 217, 217, 0.2),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Text(
                                "Certificate",
                                style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                              ),
                            ),
                            contextCtrl.coachDetails.value.coachCertificate != null && contextCtrl.coachDetails.value.coachCertificate!.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.only(top: 12, left: 14),
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: contextCtrl.coachDetails.value.coachCertificate?.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return AlertDialog(
                                                      backgroundColor: Colors.white,
                                                      contentPadding: EdgeInsets.zero,
                                                      content: Wrap(
                                                        children: [
                                                          Container(
                                                            width: 350,
                                                            height: 500,
                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                                                            padding: const EdgeInsets.all(15),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      contextCtrl.coachDetails.value.coachCertificate![index].certificateTitle.toString(),
                                                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                                                    ),
                                                                    const Spacer(),
                                                                    InkWell(
                                                                      onTap: () {
                                                                        Get.back();
                                                                      },
                                                                      child: const Icon(Icons.close, size: 26, color: greyColorTxt),
                                                                    )
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                const Divider(
                                                                  height: 1,
                                                                  color: greyColorTxt,
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  width: 350,
                                                                  height: 400,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(6),
                                                                    color: Colors.transparent, // Set your desired background color here
                                                                  ),
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(6),
                                                                    child: contextCtrl.coachDetails.value.coachCertificate![index].certificateImage!.isNotEmpty
                                                                        ? CachedNetworkImage(
                                                                            errorWidget: (context, url, error) => Image.asset(
                                                                              certificateImg,
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                            fit: BoxFit.fill,
                                                                            imageUrl: ApiUrl.imageBaseUrl + contextCtrl.coachDetails.value.coachCertificate![index].certificateImage.toString(),
                                                                            placeholder: (a, b) => const Center(
                                                                              child: CircularProgressIndicator(
                                                                                color: mainColor,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Image.asset(
                                                                            certificateImg,
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(right: 12),
                                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                                            width: 239,
                                            height: 141,
                                            decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius: BorderRadius.circular(9),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(0, 0, 0, 0.03),
                                                  offset: Offset(0, 1),
                                                  blurRadius: 15,
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 62,
                                                      height: 64,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(6),
                                                        color: Colors.transparent,
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(6),
                                                        child: contextCtrl.coachDetails.value.coachCertificate![index].certificateImage != "" &&
                                                                contextCtrl.coachDetails.value.coachCertificate![index].certificateImage != null
                                                            ? CachedNetworkImage(
                                                                errorWidget: (context, url, error) => Image.asset(
                                                                  certificateImg,
                                                                  fit: BoxFit.fill,
                                                                ),
                                                                fit: BoxFit.fill,
                                                                imageUrl: ApiUrl.imageBaseUrl + contextCtrl.coachDetails.value.coachCertificate![index].certificateImage.toString(),
                                                                placeholder: (a, b) => const Center(
                                                                  child: CircularProgressIndicator(
                                                                    color: mainColor,
                                                                  ),
                                                                ),
                                                              )
                                                            : Image.asset(
                                                                certificateImg,
                                                                fit: BoxFit.cover,
                                                              ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            contextCtrl.coachDetails.value.coachCertificate![index].certificateTitle.toString(),
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              color: subPrimaryCl,
                                                              fontFamily: bold,
                                                              fontWeight: FontWeight.w600,
                                                              fontStyle: FontStyle.normal,
                                                              fontSize: Dimensions.font14,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          contextCtrl.coachDetails.value.coachCertificate![index].startDate != "" &&
                                                                  contextCtrl.coachDetails.value.coachCertificate![index].endDate != ""
                                                              ? Text(
                                                                  "${contextCtrl.coachDetails.value.coachCertificate![index].startDate.toString()} to ${contextCtrl.coachDetails.value.coachCertificate![index].endDate.toString()}",
                                                                  style: TextStyle(
                                                                      color: lightGreyTxt,
                                                                      fontFamily: medium,
                                                                      fontWeight: FontWeight.w400,
                                                                      fontStyle: FontStyle.normal,
                                                                      fontSize: Dimensions.font14 - 4),
                                                                )
                                                              : const SizedBox(),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  contextCtrl.coachDetails.value.coachCertificate![index].certificateDescription.toString(),
                                                  maxLines: 4,
                                                  style: TextStyle(color: lightGreyTxt, fontFamily: regular, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      "No Certificate",
                                      style: TextStyle(color: lightGreyTxt, fontFamily: regular, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                                    ),
                                  ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          "Past Student Photos",
                          style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                        ),
                      ),
                      contextCtrl.imageList.value.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.only(top: 12, left: 14),
                              height: 110,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: contextCtrl.imageList.value.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                contentPadding: EdgeInsets.zero,
                                                content: Wrap(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      height: 500,
                                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                                                      padding: const EdgeInsets.all(10),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              const Spacer(),
                                                              InkWell(
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                                child: const Icon(
                                                                  Icons.close,
                                                                  size: 26,
                                                                  color: greyColorTxt,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(context).size.width,
                                                            height: 400,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(6),
                                                              color: Colors.transparent, // Set your desired background color here
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(6),
                                                              child: contextCtrl.imageList.value[index].file!.isNotEmpty
                                                                  ? CachedNetworkImage(
                                                                      errorWidget: (context, url, error) => Image.asset(
                                                                        coachTopImg,
                                                                        fit: BoxFit.fill,
                                                                      ),
                                                                      fit: BoxFit.fill,
                                                                      imageUrl: ApiUrl.imageBaseUrl + contextCtrl.imageList.value[index].file!.toString(),
                                                                      placeholder: (a, b) => const Center(
                                                                        child: CircularProgressIndicator(
                                                                          color: mainColor,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Image.asset(
                                                                      coachTopImg,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 9),
                                      width: 115,
                                      height: 115,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFFFFF),
                                        // Secondary color
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.03),
                                            offset: Offset(0, 1),
                                            blurRadius: 15,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: contextCtrl.imageList.value[index].file!.isNotEmpty
                                            ? CachedNetworkImage(
                                                errorWidget: (context, url, error) => Image.asset(
                                                  coachTopImg,
                                                  fit: BoxFit.fill,
                                                ),
                                                fit: BoxFit.fill,
                                                imageUrl: ApiUrl.imageBaseUrl + contextCtrl.imageList.value[index].file.toString(),
                                                placeholder: (a, b) => const Center(
                                                  child: CircularProgressIndicator(
                                                    color: mainColor,
                                                  ),
                                                ),
                                              )
                                            : Image.asset(
                                                coachTopImg,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Text(
                                "No Photo yet",
                                style: TextStyle(color: lightGreyTxt, fontFamily: regular, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          "Video",
                          style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                        ),
                      ),
                      contextCtrl.videoList.value.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.only(top: 12, left: 14),
                              height: 115,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: contextCtrl.videoList.value.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => VideoPlayScreen(file: ApiUrl.imageBaseUrl + contextCtrl.videoList[index].file.toString(), id: contextCtrl.videoList[index].id!.toInt()));
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(right: 10),
                                          width: 175,
                                          height: 115,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFFFFF),
                                            // Secondary color
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(255, 186, 0, 0.04),
                                                offset: Offset(0, 4),
                                                blurRadius: 20,
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(4),
                                                child: contextCtrl.videoList.value[index].file!.isNotEmpty
                                                    ? CachedNetworkImage(
                                                        errorWidget: (context, url, error) => Image.asset(
                                                          coachTopImg,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        fit: BoxFit.fill,
                                                        imageUrl: ApiUrl.imageBaseUrl + contextCtrl.videoList.value[index].file.toString(),
                                                        placeholder: (a, b) => const Center(
                                                          child: CircularProgressIndicator(
                                                            color: mainColor,
                                                          ),
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        coachTopImg,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  playIc,
                                                  height: 30,
                                                  width: 30,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Text(
                                "No Video yet",
                                style: TextStyle(color: lightGreyTxt, fontFamily: regular, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Customer Reviews",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: mainColor,
                            fontFamily: semiBold,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: Dimensions.font14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: contextCtrl.coachDetails.value.rating != null ? contextCtrl.coachDetails.value.rating!.toDouble() : 0.0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  ignoreGestures: true,
                                  itemSize: 18.0,
                                  itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: orange,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  contextCtrl.coachDetails.value.rating != null ? "${contextCtrl.coachDetails.value.rating.toString()} out of 5" : "0 out of 5",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: Dimensions.font14 - 2,
                                    color: mainColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 8),
                            ratingBar('5', contextCtrl.coachDetails.value.ratingPer5.toString()),
                            ratingBar('4', contextCtrl.coachDetails.value.ratingPer4.toString()),
                            ratingBar('3', contextCtrl.coachDetails.value.ratingPer3.toString()),
                            ratingBar('2', contextCtrl.coachDetails.value.ratingPer2.toString()),
                            ratingBar('1', contextCtrl.coachDetails.value.ratingPer2.toString()),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      contextCtrl.coachDetails.value.feedbackList.isNotEmpty
                          ? MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: contextCtrl.coachDetails.value.feedbackList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return recentOrdersItemBuilder(contextCtrl.coachDetails.value.feedbackList[index]);
                                },
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 70)
                    ],
                  );
                },
              ),
            ),
            bottomSheet: controller.isLoading
                ? const SizedBox()
                : Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    color: whiteColor,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Get.to(() => PlanScreen(coachId: controller.coachDetails.value.id.toString()));
                        },
                        child: Container(
                          width: 100,
                          height: 36,
                          decoration: const BoxDecoration(color: whiteColor, boxShadow: [BoxShadow(offset: Offset(0, 4), blurRadius: 4, spreadRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.25))]),
                          child: Center(
                            child: Text(
                              "Book Now",
                              style: TextStyle(
                                color: mainColor,
                                fontSize: Dimensions.font14 - 2,
                                fontFamily: medium,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget ratingBar(String label, String rating) {
    double pct = 0.0;
    try {
      pct = 100 * double.parse(rating);
    } catch (e) {
      errorToast(e.toString());
    }
    int percent = pct.round();
    return Row(
      children: [
        const SizedBox(width: 2),
        label != "1"
            ? Text(
                label,
                style: TextStyle(fontSize: Dimensions.font14),
              )
            : Text(
                label,
                style: TextStyle(fontSize: Dimensions.font14),
              ),
        const SizedBox(width: 8),
        Icon(
          Icons.star,
          color: orange,
          size: Dimensions.iconSize16,
        ),
        const SizedBox(width: 8),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          margin: const EdgeInsets.only(right: 6, top: 5),
          alignment: Alignment.center,
          child: LinearPercentIndicator(
            barRadius: const Radius.circular(2),
            animation: true,
            animationDuration: 1000,
            lineHeight: 10.0,
            percent: percent / 100,
            progressColor: mainColor,
            backgroundColor: Colors.grey[300],
          ),
        ),
        Text(
          "$percent%",
          style: TextStyle(fontSize: Dimensions.font14 - 2, fontWeight: FontWeight.w600, color: mainColor),
        ),
      ],
    );
  }

  Widget recentOrdersItemBuilder(FeedbackList list) {
    String dateOk = dateSetOk(list.createdAt.toString());
    return InkWell(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(3),
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: list.image != null && list.image != ""
                                  ? CachedNetworkImage(
                                      errorWidget: (context, url, error) => Image.asset(demoImg),
                                      fit: BoxFit.cover,
                                      height: Dimensions.height90,
                                      width: Dimensions.width90,
                                      imageUrl: ApiUrl.imageBaseUrl + list.image.toString(),
                                      placeholder: (a, b) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : Image.asset(
                                      slideThree,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                list.userName.toString(),
                                style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                              ),
                              RatingBar.builder(
                                initialRating: double.parse(list.rating.toString()),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 16.0,
                                ignoreGestures: true,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: orange,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        dateOk,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: Dimensions.font14 - 4,
                          color: mainColor,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    list.feedback.toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: Dimensions.font14 - 2,
                      color: mainColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }

  dateSetOk(String s) {
    DateTime timestamp = DateTime.parse(s);
    String formattedDate = DateFormat('d MMM yyyy h:mm a').format(timestamp);
    return formattedDate;
  }
}
