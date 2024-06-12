import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/my_rating_list_controller.dart';
import 'package:fittyus/model/my_rating_list_model.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyRatingScreen extends StatefulWidget {
  const MyRatingScreen({super.key});

  @override
  State<MyRatingScreen> createState() => _MyRatingScreenState();
}

class _MyRatingScreenState extends State<MyRatingScreen> {
  MyRatingListController controller = Get.put(MyRatingListController());

  @override
  void initState() {
    controller.myRatingList.clear();
    controller.isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<MyRatingListController>(),
      initState: (state) {
        Get.find<MyRatingListController>().myRatingListApi();
      },
      builder: (contextCtrl) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar:   PreferredSize(
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
                      "My Ratings",
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
                        )),
                      );
                    }
                    if (contextCtrl.myRatingList.isEmpty) {
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
                              "No Rating Found",
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
                        itemCount: contextCtrl.myRatingList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return myRatingTile(
                              contextCtrl.myRatingList[index]);
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

  myRatingTile(MyRatingListModel list) {
    List<String> imageUrls = list.feedbackImages!.split(',');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: dividerCl, width: 1),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 10,
                spreadRadius: 0,
                color: Color.fromRGBO(0, 0, 0, 0.04))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  child: list.teacherImage != null && list.teacherImage != ""
                      ? CachedNetworkImage(
                          errorWidget: (context, url, error) => Image.asset(
                            certificateImg,
                            fit: BoxFit.cover,
                          ),
                          fit: BoxFit.fill,
                          imageUrl: ApiUrl.imageBaseUrl +
                              list.teacherImage.toString(),
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
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font14),
                    ),
                    Text(
                      list.coachType.toString(),
                      style: TextStyle(
                          color: lightGreyTxt,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font14 - 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: RatingBar.builder(
              initialRating: double.parse(list.rating.toString()),
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
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Comment",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: semiBold,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: Dimensions.font14),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              list.feedback.toString(),
              maxLines: 4,
              style: TextStyle(
                color: lightGreyTxt,
                overflow: TextOverflow.ellipsis,
                fontFamily: medium,
                fontSize: Dimensions.font14 - 4,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          list.feedbackImages!.isEmpty
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageUrls.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 5),
                        height: 66,
                        width: 66,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: list.feedbackImages!.isNotEmpty
                              ? CachedNetworkImage(
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    demoImg,
                                    fit: BoxFit.cover,
                                  ),
                                  fit: BoxFit.fill,
                                  imageUrl:
                                      ApiUrl.imageBaseUrl + imageUrls[index],
                                  placeholder: (a, b) => const Center(
                                    child: CircularProgressIndicator(
                                      color: mainColor,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
