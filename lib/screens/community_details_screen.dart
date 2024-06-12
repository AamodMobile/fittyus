import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/community_controller.dart';
import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:fittyus/widgets/my_button.dart';
import 'package:intl/intl.dart';
import '../widgets/text_filed_widget.dart';

class CommunityDetails extends StatefulWidget {
  final String communityId;

  const CommunityDetails({super.key, required this.communityId});

  @override
  State<CommunityDetails> createState() => _CommunityDetailsState();
}

class _CommunityDetailsState extends State<CommunityDetails> {
  CarouselController carouselController = CarouselController();
  UserController user = Get.put(UserController());
  var controller = Get.find<CommunityController>();
  int ind = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CommunityController>(),
      initState: (state) {
        Get.find<CommunityController>().communityDetailsApi(widget.communityId, true);
      },
      builder: (contextCtr) {
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
                      "Community Details",
                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Builder(
                builder: (context) {
                  if (contextCtr.isLoading.value) {
                    return SizedBox(
                      height: Dimensions.screenHeight - 200,
                      width: Dimensions.screenWidth,
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: mainColor,
                      )),
                    );
                  }
                  if (contextCtr.communityDetails == "") {
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
                      Container(
                        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.006),
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01, vertical: MediaQuery.of(context).size.height * 0.01),
                        decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(2)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: contextCtr.communityDetails.value.profileImage != null && contextCtr.communityDetails.value.profileImage != ""
                                              ? CachedNetworkImage(
                                                  errorWidget: (context, url, error) => Image.asset(
                                                    defaultUser,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  fit: BoxFit.cover,
                                                  imageUrl: contextCtr.communityDetails.value.profileImage.toString(),
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
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            contextCtr.communityDetails.value.firstName.toString(),
                                            style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                          ),
                                          Text(
                                            contextCtr.communityDetails.value.date.toString(),
                                            style: TextStyle(color: mainColor, fontFamily: regular, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: Icon(
                                      Icons.more_horiz,
                                      size: Dimensions.iconSize24,
                                      color: dividerCl,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      contextCtr.communityDetails.value.shortDescription.toString(),
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: lightGreyTxt,
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: regular,
                                        fontSize: Dimensions.font14 - 4,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            contextCtr.communityDetails.value.type == "multipal"
                                ?  Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Stack(
                                children: [
                                  CarouselSlider(
                                    carouselController: carouselController,
                                    options: CarouselOptions(
                                      height: MediaQuery.of(context).size.height * 0.400,
                                      enlargeCenterPage: true,
                                      viewportFraction: 1.0,
                                      pauseAutoPlayOnTouch: true,
                                      enableInfiniteScroll: false,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          ind = index;
                                        });
                                      },
                                    ),
                                    items: List.generate(
                                      contextCtr.communityDetails.value.communityImages!.length,
                                      (ind) => InkWell(
                                        onTap: () {},
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.470,
                                          width: Get.width,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: contextCtr.communityDetails.value.communityImages!.isNotEmpty
                                                ? CachedNetworkImage(
                                                    errorWidget: (context, url, error) => Image.asset(
                                                      demoImgTraining,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    fit: BoxFit.cover,
                                                    imageUrl: ApiUrl.imageBaseUrl + contextCtr.communityDetails.value.communityImages![ind].image.toString(),
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
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      width: 40,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(16, 17, 16, 0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${ind + 1}/${contextCtr.communityDetails.value.communityImages!.length}",
                                            style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: Dimensions.font14 - 4, fontFamily: regular, color: whiteColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ):
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      contextCtr.communityDetails.value.beforeImg != "" && contextCtr.communityDetails.value.beforeImg != null
                                          ? Expanded(
                                          child: contextCtr.communityDetails.value.beforeImg != "" && contextCtr.communityDetails.value.beforeImg != null
                                              ? CachedNetworkImage(
                                            errorWidget: (context, url, error) => Image.asset(demoImg, height: MediaQuery.of(context).size.height * 0.400, fit: BoxFit.cover),
                                            fit: BoxFit.fill,
                                            height: MediaQuery.of(context).size.height * 0.400,
                                            imageUrl: ApiUrl.imageBaseUrl + contextCtr.communityDetails.value.beforeImg.toString(),
                                            placeholder: (a, b) => const Center(
                                              child: CircularProgressIndicator(
                                                color: mainColor,
                                              ),
                                            ),
                                          )
                                              : Image.asset(demoImg, height: MediaQuery.of(context).size.height * 0.400, fit: BoxFit.cover))
                                          : const SizedBox(),
                                      contextCtr.communityDetails.value.afterImage != "" && contextCtr.communityDetails.value.afterImage != null
                                          ? Expanded(
                                          child: contextCtr.communityDetails.value.afterImage != "" && contextCtr.communityDetails.value.afterImage != null
                                              ? CachedNetworkImage(
                                            errorWidget: (context, url, error) => Image.asset(demoImg, height: MediaQuery.of(context).size.height * 0.400, fit: BoxFit.cover),
                                            fit: BoxFit.fill,
                                            height: MediaQuery.of(context).size.height * 0.400,
                                            imageUrl: ApiUrl.imageBaseUrl + contextCtr.communityDetails.value.afterImage.toString(),
                                            placeholder: (a, b) => const Center(
                                              child: CircularProgressIndicator(
                                                color: mainColor,
                                              ),
                                            ),
                                          )
                                              : Image.asset(demoImg, height: MediaQuery.of(context).size.height * 0.400, fit: BoxFit.cover))
                                          : const SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.communityLike(contextCtr.communityDetails.value.id.toString(), contextCtr.communityDetails.value.isLike.toString() == "0" ? "1" : "0").then((value) {
                                      user.viewProfile(contextCtr.communityDetails.value.userId.toString(), false);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: [
                                        contextCtr.communityDetails.value.isLike.toString() == "0"
                                            ? Image.asset(
                                                heartIc,
                                                height: 16,
                                                width: 16,
                                              )
                                            : Image.asset(
                                                heartPinkIc,
                                                height: 16,
                                                width: 16,
                                              ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "like ${contextCtr.communityDetails.value.communityCount}",
                                          maxLines: 2,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: mainColor,
                                            fontFamily: regular,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: Dimensions.font14 - 4,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        commentNewIc,
                                        height: 16,
                                        width: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "Comment",
                                        maxLines: 2,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: mainColor,
                                          fontFamily: regular,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: Dimensions.font14 - 4,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: true,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          shareNewIc,
                                          height: 16,
                                          width: 16,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "Share",
                                          maxLines: 2,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: mainColor,
                                            fontFamily: regular,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: Dimensions.font14 - 4,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    "200 Views",
                                    maxLines: 2,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: mainColor,
                                      fontFamily: regular,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14 - 4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            contextCtr.communityDetails.value.comments!.isNotEmpty
                                ? Column(
                                    children: [
                                      MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child: ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: contextCtr.communityDetails.value.comments!.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Container(
                                                margin: const EdgeInsets.symmetric(vertical: 6),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          height: 25,
                                                          width: 25,
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(20),
                                                            child: contextCtr.communityDetails.value.comments![index].userImage != null &&
                                                                    contextCtr.communityDetails.value.comments![index].userImage != ""
                                                                ? CachedNetworkImage(
                                                                    errorWidget: (context, url, error) => Image.asset(
                                                                      defaultUser,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                    fit: BoxFit.cover,
                                                                    imageUrl: contextCtr.communityDetails.value.comments![index].userImage.toString(),
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
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            padding: const EdgeInsets.all(2),
                                                            decoration: const BoxDecoration(color: grayNew),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                        controller.commentList[index].userName.toString(),
                                                                        style: TextStyle(
                                                                            color: mainColor,
                                                                            fontFamily: semiBold,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontStyle: FontStyle.normal,
                                                                            fontSize: Dimensions.font14),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(width: 10),
                                                                    Text(
                                                                      DateFormat('yyyy-MM-dd').format(
                                                                        controller.commentList[index].createdAt!,
                                                                      ),
                                                                      style: TextStyle(
                                                                        color: lightGreyTxt,
                                                                        fontFamily: regular,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontStyle: FontStyle.normal,
                                                                        fontSize: Dimensions.font14 - 4,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    controller.commentList[index].message.toString(),
                                                                    maxLines: 3,
                                                                    style: TextStyle(
                                                                      overflow: TextOverflow.ellipsis,
                                                                      color: lightGreyTxt,
                                                                      fontFamily: regular,
                                                                      fontWeight: FontWeight.w400,
                                                                      fontStyle: FontStyle.normal,
                                                                      fontSize: Dimensions.font14 - 4,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment: Alignment.centerRight,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      user.user.value.id.toString() == controller.commentList[index].userId.toString()
                                                                          ? Row(
                                                                              children: [
                                                                                InkWell(
                                                                                    onTap: () {
                                                                                      tooltipPopup(context, controller.commentList[index].id.toString());
                                                                                    },
                                                                                    child: const Icon(
                                                                                      Icons.delete,
                                                                                      color: mainColor,
                                                                                      size: 18,
                                                                                    )),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                              ],
                                                                            )
                                                                          : const SizedBox(),
                                                                      const SizedBox(width: 10),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              contextCtr.likeComment(contextCtr.communityDetails.value.comments![index].id.toString()).then((value) {
                                                                controller.communityDetailsApi(widget.communityId, false);
                                                                user.viewProfile(contextCtr.communityDetails.value.userId.toString(), false);
                                                              });
                                                            },
                                                            child: Container(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                              decoration: BoxDecoration(
                                                                color: whiteColor,
                                                                borderRadius: BorderRadius.circular(4),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  contextCtr.communityDetails.value.comments![index].like.toString() == "0"
                                                                      ? Image.asset(
                                                                          heartIc,
                                                                          height: 16,
                                                                          width: 16,
                                                                        )
                                                                      : Image.asset(
                                                                          heartPinkIc,
                                                                          height: 16,
                                                                          width: 16,
                                                                        ),
                                                                  const SizedBox(width: 4),
                                                                  Text(
                                                                    "like",
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                      overflow: TextOverflow.ellipsis,
                                                                      color: mainColor,
                                                                      fontFamily: regular,
                                                                      fontWeight: FontWeight.w400,
                                                                      fontStyle: FontStyle.normal,
                                                                      fontSize: Dimensions.font14 - 4,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 4),
                                                          InkWell(
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
                                                                              padding: const EdgeInsets.all(15),
                                                                              child: Column(
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        "Reply on Comment ",
                                                                                        style: TextStyle(
                                                                                            color: Colors.black, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                                                                      ),
                                                                                      const Spacer(),
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          controller.replyComment.text = "";
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
                                                                                    height: 10,
                                                                                  ),
                                                                                  const Divider(
                                                                                    height: 1,
                                                                                    color: greyColorTxt,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: Text(
                                                                                      "Reply:",
                                                                                      style: TextStyle(
                                                                                          color: Colors.black, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: MediaQuery.of(context).size.width,
                                                                                    child: MyTextFormField(
                                                                                      readOnly: false,
                                                                                      maxLines: 1,
                                                                                      controller: controller.replyComment,
                                                                                      validator: (input) {
                                                                                        if (input!.isEmpty) {
                                                                                          return "Enter  Comment";
                                                                                        }
                                                                                        return null;
                                                                                      },
                                                                                      hint: "Enter reply Comment",
                                                                                      obscureText: false,
                                                                                      fillColor: Colors.white,
                                                                                      border: grayNew,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        height: 40,
                                                                                        width: 90,
                                                                                        child: MyButton(
                                                                                            onPressed: () {
                                                                                              if (controller.replyComment.text != "") {
                                                                                                controller
                                                                                                    .addCommentApi(
                                                                                                        widget.communityId.toString(),
                                                                                                        contextCtr.communityDetails.value.comments![index].id.toString(),
                                                                                                        controller.replyComment.text,
                                                                                                        true)
                                                                                                    .then((value) {
                                                                                                  controller.replyComment.text = "";
                                                                                                  user.viewProfile(contextCtr.communityDetails.value.userId.toString(), false);
                                                                                                });
                                                                                              } else {
                                                                                                errorToast("add reply");
                                                                                              }
                                                                                            },
                                                                                            color: greenColor,
                                                                                            child: Text(
                                                                                              "Reply",
                                                                                              style: TextStyle(
                                                                                                  color: Colors.white,
                                                                                                  fontFamily: medium,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  fontStyle: FontStyle.normal,
                                                                                                  fontSize: Dimensions.font14 - 2),
                                                                                            )),
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 40,
                                                                                        width: 90,
                                                                                        child: MyButton(
                                                                                            onPressed: () {
                                                                                              controller.replyComment.text = "";
                                                                                              Get.back();
                                                                                            },
                                                                                            color: redColor,
                                                                                            child: Text(
                                                                                              "Cancel",
                                                                                              style: TextStyle(
                                                                                                  color: Colors.white,
                                                                                                  fontFamily: medium,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  fontStyle: FontStyle.normal,
                                                                                                  fontSize: Dimensions.font14 - 2),
                                                                                            )),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 10,
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
                                                            child: Text(
                                                              "Reply",
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: mainColor,
                                                                fontFamily: regular,
                                                                fontWeight: FontWeight.w400,
                                                                fontStyle: FontStyle.normal,
                                                                fontSize: Dimensions.font14 - 4,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    controller.commentList[index].replies!.isEmpty
                                                        ? const SizedBox()
                                                        : MediaQuery.removePadding(
                                                            context: context,
                                                            removeTop: true,
                                                            child: ListView.builder(
                                                              itemCount: controller.commentList[index].replies?.length,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (BuildContext context, int ind) {
                                                                return Container(
                                                                  margin: const EdgeInsets.only(top: 5, left: 50),
                                                                  child: Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        height: 30,
                                                                        width: 30,
                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                                                        child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(20),
                                                                          child: controller.commentList[index].replies![ind].image != null && controller.commentList[index].replies![ind].image != ""
                                                                              ? SizedBox(
                                                                                  height: Dimensions.height30,
                                                                                  width: Dimensions.width30,
                                                                                  child: ClipOval(
                                                                                    child: CachedNetworkImage(
                                                                                      fit: BoxFit.cover,
                                                                                      imageUrl: controller.commentList[index].replies![ind].image.toString(),
                                                                                      placeholder: (a, b) => Center(
                                                                                        child: Image.asset(
                                                                                          defaultUser,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : Image.asset(
                                                                                  defaultUser,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(width: 5),
                                                                      Expanded(
                                                                        child: Container(
                                                                          padding: const EdgeInsets.all(2),
                                                                          decoration: const BoxDecoration(color: grayNew),
                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      controller.commentList[index].replies![ind].username.toString(),
                                                                                      style: TextStyle(
                                                                                          color: mainColor,
                                                                                          fontFamily: semiBold,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FontStyle.normal,
                                                                                          fontSize: Dimensions.font14),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(width: 10),
                                                                                  Text(
                                                                                    DateFormat('yyyy-MM-dd').format(
                                                                                      controller.commentList[index].replies![ind].createdAt!,
                                                                                    ),
                                                                                    style: TextStyle(
                                                                                      color: lightGreyTxt,
                                                                                      fontFamily: regular,
                                                                                      fontWeight: FontWeight.w400,
                                                                                      fontStyle: FontStyle.normal,
                                                                                      fontSize: Dimensions.font14 - 4,
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Text(
                                                                                  controller.commentList[index].replies![ind].message.toString(),
                                                                                  maxLines: 3,
                                                                                  style: TextStyle(
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    color: lightGreyTxt,
                                                                                    fontFamily: regular,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    fontStyle: FontStyle.normal,
                                                                                    fontSize: Dimensions.font14 - 4,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.centerRight,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    user.user.value.id.toString() == controller.commentList[index].replies![ind].userId.toString()
                                                                                        ? Row(
                                                                                            children: [
                                                                                              InkWell(
                                                                                                  onTap: () {
                                                                                                    tooltipPopup(context, controller.commentList[index].replies![ind].id.toString());
                                                                                                  },
                                                                                                  child: const Icon(
                                                                                                    Icons.delete,
                                                                                                    color: mainColor,
                                                                                                    size: 18,
                                                                                                  )),
                                                                                              const SizedBox(
                                                                                                width: 10,
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                        : const SizedBox(),
                                                                                    const SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    child: Text(
                                      "No Comments",
                                      style: TextStyle(
                                        color: mainColor,
                                        fontFamily: regular,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: Dimensions.font14 - 4,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100)
                    ],
                  );
                },
              ),
            ),
            bottomSheet: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: MyTextFormField(
                        controller: controller.commentController,
                        hint: 'Comment Here...',
                        obscureText: false,
                        readOnly: false,
                        border: dividerCl,
                        fillColor: whiteColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.commentController.text == "") {
                          errorToast("add comment");
                        } else {
                          FocusManager.instance.primaryFocus?.unfocus();
                          controller.addCommentApi(widget.communityId, "", controller.commentController.text, false);
                        }
                      },
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: ImageIcon(
                              AssetImage(
                                sendBlueIc,
                              ),
                              color: Color(0xFF1B3BA9),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  dateSetOk(String s) {
    DateTime timestamp = DateTime.parse(s);
    String formattedDate = DateFormat('d MMM yyyy h:mm a').format(timestamp);
    return formattedDate;
  }

  Future<void> tooltipPopup(BuildContext context, String commentId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Expanded(child: Text('Message', textAlign: TextAlign.center, style: TextStyle(color: Colors.red))),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "Are you sure you want to delete?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 16),
                  )),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        controller.deleteComment(commentId).then((value) {
                          controller.communityDetailsApi(widget.communityId.toString(), false);
                        });
                        setState(() {});
                      },
                      child: Container(
                          width: 85,
                          height: 40,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Remove', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                          ))),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 85,
                        height: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
