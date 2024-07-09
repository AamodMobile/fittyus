import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/copon_list_controller.dart';
import 'package:fittyus/controller/home_controller.dart';
import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/screens/account_screen.dart';
import 'package:fittyus/screens/banner_details_screen.dart';
import 'package:fittyus/screens/blog_details_screen.dart';
import 'package:fittyus/screens/blog_list_screen.dart';
import 'package:fittyus/screens/category_screen.dart';
import 'package:fittyus/screens/coach_details_screen.dart';
import 'package:fittyus/screens/coaches_list_screen.dart';
import 'package:fittyus/screens/comment_list_screen.dart';
import 'package:fittyus/screens/community_screen.dart';
import 'package:fittyus/screens/new_challenge_screen.dart';
import 'package:fittyus/screens/notification_screen.dart';
import 'package:fittyus/screens/offer_details_screen.dart';
import 'package:fittyus/screens/refer_and_earn_screen.dart';
import 'package:fittyus/screens/search_new_screen.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController carouselController = CarouselController();

  var user = Get.find<UserController>();
  HomeController controller = Get.put(HomeController());
  CouponListController con = Get.put(CouponListController());

  @override
  void initState() {
    controller.city.value = "";
    controller.getCheckInStatus();
    user.getUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<HomeController>(),
      initState: (state) {
        Get.find<HomeController>().getHomeApi();
        Get.find<CouponListController>().getCouponListApi("");
      },
      builder: (contextCtrl) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: whiteColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.09,
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, spreadRadius: 1)],
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => const AccountScreen());
                                },
                                child: Obx(
                                  () => Container(
                                    height: 42,
                                    width: 42,
                                    decoration: BoxDecoration(color: mainColor, border: Border.all(color: mainColor), borderRadius: BorderRadius.circular(22)),
                                    child: user.user.value.avatarUrl.isNotEmpty
                                        ? ClipOval(
                                            child: CachedNetworkImage(
                                              errorWidget: (context, url, error) => Image.asset(
                                                bannerImg,
                                                fit: BoxFit.cover,
                                              ),
                                              fit: BoxFit.cover,
                                              height: Dimensions.height90,
                                              width: Dimensions.width90,
                                              imageUrl: user.user.value.avatarUrl.toString(),
                                              placeholder: (a, b) => const Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            ),
                                          )
                                        : Image.asset(
                                            manIc,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Text(
                                      user.user.value.firstName == "" ? "New User" : user.user.value.firstName.toString(),
                                      maxLines: 2,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: mainColor,
                                          fontFamily: semiBold,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: Dimensions.font14),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => const NotificationScreen());
                                },
                                child: ImageIcon(
                                  const AssetImage(bellIc),
                                  color: mainColor,
                                  size: Dimensions.iconSize24,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const ReferAndEarnScreen());
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7),
                                  height: 30,
                                  width: MediaQuery.of(context).size.width * 0.30,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color.fromRGBO(226, 229, 238, 1), borderColorCont],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        salaryIc,
                                        height: 20,
                                        width: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Refer&Earn",
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: Dimensions.font14 - 2,
                                          fontFamily: semiBold,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    controller.currentAddress == "" || controller.currentAddress == null ? "Address" : "Address:- ${controller.currentAddress}",
                    maxLines: 2,
                    style: TextStyle(overflow: TextOverflow.ellipsis, color: blueCl, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                  ),
                ),
                const SizedBox(height: 10),
                controller.noData
                    ? Center(
                        child: Text(
                          "No Data Found",
                          style: TextStyle(
                            color: subPrimaryCl,
                            fontFamily: semiBold,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: Dimensions.font14,
                          ),
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            color: Colors.white,
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
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Coupons And Offers",
                                            style: TextStyle(
                                              color: mainColor,
                                              fontFamily: bold,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              fontSize: Dimensions.font14,
                                            ),
                                          ),
                                          Visibility(
                                            visible: false,
                                            child: InkWell(
                                              onTap: () {},
                                              child: SizedBox(
                                                child: Text(
                                                  viewAll,
                                                  style: TextStyle(color: lightGreyTxt, fontFamily: medium, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.01,
                                    ),
                                    Obx(
                                      () => Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(0, 1),
                                                blurRadius: 15,
                                                spreadRadius: 0,
                                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                              )
                                            ],
                                          ),
                                          child: CarouselSlider(
                                            carouselController: carouselController,
                                            options: CarouselOptions(
                                              height: 164,
                                              autoPlay: true,
                                              enlargeCenterPage: true,
                                              viewportFraction: 1.0,
                                              pauseAutoPlayOnTouch: true,
                                              enableInfiniteScroll: false,
                                              onPageChanged: (index, reason) {
                                                controller.indexUpdate(index);
                                              },
                                            ),
                                            items: List.generate(
                                                con.couponList.length,
                                                (ind) => InkWell(
                                                      onTap: () {
                                                        if (con.couponList[ind].type == "coupon") {
                                                          Get.to(
                                                            () => OfferDetailsScreen(model: con.couponList[ind]),
                                                          );
                                                        } else {
                                                          Get.to(
                                                            () => BannerDetailsScreen(model: con.couponList[ind]),
                                                          );
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 164,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        width: Get.width,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: con.couponList[ind].image != null && con.couponList[ind].image != ""
                                                              ? CachedNetworkImage(
                                                                  errorWidget: (context, url, error) => Image.asset(
                                                                        bannerImg,
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                  fit: BoxFit.fill,
                                                                  imageUrl: ApiUrl.imageBaseUrl + con.couponList[ind].image.toString(),
                                                                  placeholder: (a, b) => const Center(
                                                                          child: CircularProgressIndicator(
                                                                        color: mainColor,
                                                                      )))
                                                              : Image.asset(
                                                                  bannerImg,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                        ),
                                                      ),
                                                    )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(
                                        con.couponList.length,
                                        (index) => Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 2),
                                          padding: const EdgeInsets.all(5),
                                          height: 6,
                                          width: index == contextCtrl.selectedIndex ? 10 : 6,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: index == contextCtrl.selectedIndex ? mainColor : const Color(0xFFD9D9D9),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.02,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width * 0.05,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(() => const NewChallengeScreen());
                                              },
                                              child: SizedBox(
                                                height: 120,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    Image.asset(
                                                      challengesIc,
                                                      height: 60,
                                                      width: 60,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Expanded(
                                                      child: Text(
                                                        "Challenges",
                                                        style: TextStyle(
                                                          color: mainColor,
                                                          fontFamily: bold,
                                                          fontWeight: FontWeight.w500,
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: Dimensions.font14 - 2,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(() => const CommunityScreen());
                                              },
                                              child: SizedBox(
                                                height: 120,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    Image.asset(
                                                      communityNewIc,
                                                      height: 60,
                                                      width: 60,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Expanded(
                                                      child: Text("Community",
                                                          style: TextStyle(
                                                            color: mainColor,
                                                            fontFamily: bold,
                                                            fontWeight: FontWeight.w500,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: Dimensions.font14 - 2,
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(() => const SearchNewScreen());
                                              },
                                              child: SizedBox(
                                                height: 120,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    Image.asset(
                                                      searchNewIc,
                                                      height: 60,
                                                      width: 60,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Expanded(
                                                      child: Text("Search",
                                                          style: TextStyle(
                                                            color: mainColor,
                                                            fontFamily: bold,
                                                            fontWeight: FontWeight.w500,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: Dimensions.font14 - 2,
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      color: whiteColor,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight: Radius.circular(20),
                                              ),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color.fromRGBO(248, 243, 243, 1),
                                                  Color.fromRGBO(255, 255, 255, 1),
                                                  Color.fromRGBO(255, 255, 255, 1),
                                                ],
                                                stops: [0, 1, 1],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                              border: Border.all(
                                                color: const Color.fromRGBO(255, 255, 255, 1),
                                                width: 1,
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                                  offset: Offset(0, 4),
                                                  blurRadius: 4,
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      topCoach,
                                                      style: TextStyle(
                                                        color: mainColor,
                                                        fontFamily: bold,
                                                        fontWeight: FontWeight.w500,
                                                        fontStyle: FontStyle.normal,
                                                        fontSize: Dimensions.font14,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        if (controller.city.value == "") {
                                                          controller.getCheckInStatus();
                                                        } else {
                                                          Get.to(() => CoachesListScreen(city: controller.city.value, categoryId: ""));
                                                        }
                                                      },
                                                      child: SizedBox(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              viewAll,
                                                              style: TextStyle(
                                                                color: lightGreyTxt,
                                                                fontFamily: medium,
                                                                fontWeight: FontWeight.w400,
                                                                fontStyle: FontStyle.normal,
                                                                fontSize: Dimensions.font14 - 2,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration: BoxDecoration(
                                                                color: mainColor,
                                                                borderRadius: BorderRadius.circular(5),
                                                              ),
                                                              child: const Icon(
                                                                Icons.arrow_forward,
                                                                size: 16,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                SizedBox(
                                                  height: 100,
                                                  width: MediaQuery.of(context).size.width,
                                                  child: contextCtrl.teacherList.isNotEmpty?
                                                  ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: contextCtrl.teacherList.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          Get.to(() => CoachDetailsScreen(
                                                                coachId: contextCtrl.teacherList[index].id.toString(),
                                                              ));
                                                        },
                                                        child: Container(
                                                          width: 60,
                                                          margin: const EdgeInsets.only(right: 25),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: MediaQuery.of(context).size.height * 0.01,
                                                              ),
                                                              Stack(
                                                                clipBehavior: Clip.none,
                                                                children: [
                                                                  Container(
                                                                    height: 60,
                                                                    width: 60,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                    ),
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      child: contextCtrl.teacherList[index].image != null && contextCtrl.teacherList[index].image != ""
                                                                          ? CachedNetworkImage(
                                                                              errorWidget: (context, url, error) => Image.asset(coachImg, fit: BoxFit.cover),
                                                                              fit: BoxFit.cover,
                                                                              imageUrl: ApiUrl.imageBaseUrl + contextCtrl.teacherList[index].image.toString(),
                                                                              placeholder: (a, b) => const Center(
                                                                                child: CircularProgressIndicator(
                                                                                  color: mainColor,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Image.asset(
                                                                              coachImg,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    top: -8,
                                                                    right: -12,
                                                                    child: Container(
                                                                      height: 14,
                                                                      width: 36,
                                                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: [
                                                                          const ImageIcon(
                                                                            AssetImage(
                                                                              starIc,
                                                                            ),
                                                                            size: 8,
                                                                          ),
                                                                          const SizedBox(
                                                                            width: 7,
                                                                          ),
                                                                          Text(
                                                                            contextCtrl.teacherList[index].averageRating.toString(),
                                                                            style: const TextStyle(
                                                                              color: mainColor,
                                                                              fontFamily: bold,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 8,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(context).size.height * 0.01,
                                                              ),
                                                              Text(
                                                                textAlign: TextAlign.start,
                                                                contextCtrl.teacherList[index].name.toString(),
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: mainColor,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontFamily: bold,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontStyle: FontStyle.normal,
                                                                    fontSize: Dimensions.font14),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ):Center(
                                                    child:  Text(
                                                      "No Coach Found In This Location",
                                                      style: TextStyle(
                                                        color: mainColor,
                                                        fontFamily: bold,
                                                        fontWeight: FontWeight.w500,
                                                        fontStyle: FontStyle.normal,
                                                        fontSize: Dimensions.font14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 40,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                            child: Text(
                                              category,
                                              style: TextStyle(
                                                color: mainColor,
                                                fontFamily: bold,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                fontSize: Dimensions.font14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: whiteColor,
                                            height: 315,
                                            margin: const EdgeInsets.only(top: 10),
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: GridView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: contextCtrl.categoryList.length,
                                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 200,
                                                mainAxisExtent: 100,
                                                childAspectRatio: (200 / 100),
                                                crossAxisSpacing: 7,
                                                mainAxisSpacing: 4,
                                              ),
                                              itemBuilder: (BuildContext context, int index) {
                                                return InkWell(
                                                    onTap: () {
                                                      if (controller.city.value == "") {
                                                        controller.getCheckInStatus();
                                                      } else {
                                                        Get.to(() => CoachesListScreen(city: controller.city.value, categoryId: contextCtrl.categoryList[index].id.toString()));
                                                      }
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          width: 166,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius.only(
                                                              topLeft: Radius.circular(6),
                                                              bottomLeft: Radius.circular(6),
                                                            ),
                                                            color: Colors.white.withOpacity(0.8),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.black.withOpacity(0.2),
                                                                blurRadius: 10,
                                                                spreadRadius: 0,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 166,
                                                          height: 100,
                                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                                                          decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topRight: Radius.circular(6),
                                                              bottomRight: Radius.circular(6),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                height: 56,
                                                                padding: const EdgeInsets.only(right: 5, top: 2, bottom: 2),
                                                                margin: const EdgeInsets.only(right: 10),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: const BorderRadius.only(
                                                                    topLeft: Radius.circular(0),
                                                                    topRight: Radius.circular(25),
                                                                    bottomLeft: Radius.circular(25),
                                                                    bottomRight: Radius.circular(25),
                                                                  ),
                                                                  border: Border.all(
                                                                    color: const Color(0xFFB5B2B2),
                                                                    width: 0.5,
                                                                  ),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors.black.withOpacity(0.07),
                                                                      offset: const Offset(0, 4),
                                                                      blurRadius: 4,
                                                                      spreadRadius: 0,
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: ClipRRect(
                                                                    borderRadius: const BorderRadius.only(
                                                                      topLeft: Radius.circular(0),
                                                                      topRight: Radius.circular(25),
                                                                      bottomLeft: Radius.circular(25),
                                                                      bottomRight: Radius.circular(25),
                                                                    ),
                                                                    child: contextCtrl.categoryList[index].image!.isNotEmpty
                                                                        ? CachedNetworkImage(
                                                                            errorWidget: (context, url, error) => Image.asset(
                                                                              coachImg,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                            fit: BoxFit.cover,
                                                                            imageUrl: ApiUrl.imageBaseUrl + contextCtrl.categoryList[index].image.toString(),
                                                                            placeholder: (a, b) => const Center(
                                                                              child: CircularProgressIndicator(
                                                                                color: mainColor,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Image.asset(
                                                                            bannerImg,
                                                                            fit: BoxFit.cover,
                                                                          )),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  contextCtrl.categoryList[index].title.toString(),
                                                                  textAlign: TextAlign.start,
                                                                  style: TextStyle(
                                                                    color: mainColor,
                                                                    fontSize: Dimensions.font14 - 2,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontFamily: medium,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.01,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(() => const CategoryScreen());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                                          child: Text(
                                            "More",
                                            style: TextStyle(
                                              color: lightGreyTxt,
                                              fontFamily: medium,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              fontSize: Dimensions.font14 - 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.01,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
                                      decoration: const BoxDecoration(
                                        color: whiteColor,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16),
                                          topLeft: Radius.circular(16),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                blogs,
                                                style: TextStyle(
                                                  color: mainColor,
                                                  fontFamily: bold,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: Dimensions.font14,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(() => const BlogListScreen());
                                                },
                                                child: SizedBox(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        viewAll,
                                                        style: TextStyle(
                                                          color: lightGreyTxt,
                                                          fontFamily: medium,
                                                          fontWeight: FontWeight.w400,
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: Dimensions.font14 - 2,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration: BoxDecoration(
                                                          color: mainColor,
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        child: const Icon(
                                                          Icons.arrow_forward,
                                                          size: 16,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: contextCtrl.blogList.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return InkWell(
                                                onTap: () {
                                                  Get.to(
                                                    () => BlogDetailsScreen(
                                                      blogId: contextCtrl.blogList[index].id.toString(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(top: 8),
                                                  padding: const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius: BorderRadius.circular(15),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset: const Offset(0, 1),
                                                        blurRadius: 15,
                                                        spreadRadius: 0,
                                                        color: mainColor.withOpacity(0.20),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            height: 104,
                                                            width: 106,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(10),
                                                              child: contextCtrl.blogList[index].image.toString().isNotEmpty
                                                                  ? CachedNetworkImage(
                                                                      errorWidget: (context, url, error) => Image.asset(
                                                                        demoImg,
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                      fit: BoxFit.cover,
                                                                      imageUrl: ApiUrl.imageBaseUrl + contextCtrl.blogList[index].image.toString(),
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
                                                          const SizedBox(width: 8),
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  contextCtrl.blogList[index].title.toString(),
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                    overflow: TextOverflow.ellipsis,
                                                                    color: mainColor,
                                                                    fontFamily: semiBold,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontStyle: FontStyle.normal,
                                                                    fontSize: Dimensions.font14,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  contextCtrl.blogList[index].shortDescription.toString(),
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                    overflow: TextOverflow.ellipsis,
                                                                    color: lightGreyTxt,
                                                                    fontFamily: regular,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontStyle: FontStyle.normal,
                                                                    fontSize: Dimensions.font14 - 4,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      "Posted : ${contextCtrl.blogList[index].date}",
                                                                      maxLines: 2,
                                                                      style: TextStyle(
                                                                        overflow: TextOverflow.ellipsis,
                                                                        color: lightGreyTxt,
                                                                        fontFamily: regular,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontStyle: FontStyle.normal,
                                                                        fontSize: Dimensions.font14 - 4,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 18,
                                                      ),
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              controller.blogLike(contextCtrl.blogList[index].id.toString(), contextCtrl.blogList[index].isBlogLike.toString() == "0" ? "1" : "0");
                                                            },
                                                            child: Container(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                              decoration: BoxDecoration(
                                                                color: lightGry,
                                                                borderRadius: BorderRadius.circular(4),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  contextCtrl.blogList[index].isBlogLike.toString() == "0"
                                                                      ? Image.asset(
                                                                          likeIc,
                                                                          height: 16,
                                                                          width: 16,
                                                                        )
                                                                      : Image.asset(
                                                                          likeIc,
                                                                          height: 16,
                                                                          width: 16,
                                                                          color: Colors.blue,
                                                                        ),
                                                                  const SizedBox(
                                                                    width: 14,
                                                                  ),
                                                                  Text(
                                                                    "like ${contextCtrl.blogList[index].blogCount.toString()}",
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        overflow: TextOverflow.ellipsis,
                                                                        color: mainColor,
                                                                        fontFamily: regular,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontStyle: FontStyle.normal,
                                                                        fontSize: Dimensions.font14 - 4),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 6,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Get.to(() => CommentListScreen(
                                                                    blogId: contextCtrl.blogList[index].id.toString(),
                                                                    blogTitle: contextCtrl.blogList[index].title.toString(),
                                                                  ));
                                                            },
                                                            child: Container(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                              decoration: BoxDecoration(
                                                                color: lightGry,
                                                                borderRadius: BorderRadius.circular(4),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                    commentIc,
                                                                    height: 16,
                                                                    width: 16,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 14,
                                                                  ),
                                                                  Text(
                                                                    "Com.${contextCtrl.blogList[index].commentsCount.toString()}",
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        overflow: TextOverflow.ellipsis,
                                                                        color: mainColor,
                                                                        fontFamily: regular,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontStyle: FontStyle.normal,
                                                                        fontSize: Dimensions.font14 - 4),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 6,
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              await Share.share('Fittyus App Download From Play Store:-'
                                                                  '\n https://play.google.com/store/apps/details?id=com.fittyus"');
                                                            },
                                                            child: Container(
                                                              padding: const EdgeInsets.all(6),
                                                              height: 24,
                                                              width: 24,
                                                              decoration: BoxDecoration(color: lightGreyTxt, borderRadius: BorderRadius.circular(3)),
                                                              child: Image.asset(
                                                                shareIc,
                                                                height: 16,
                                                                width: 16,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 6),
                                                          InkWell(
                                                            onTap: () async {
                                                              await launchUrl(
                                                                Uri.parse("https://wa.me/${91.toString() + contextCtrl.blogList[index].mobile.toString()}/?text=Hii...Welcome to  Fittyus App"),
                                                                mode: LaunchMode.externalApplication,
                                                              );
                                                            },
                                                            child: Container(
                                                              padding: const EdgeInsets.all(6),
                                                              height: 24,
                                                              width: 24,
                                                              decoration: BoxDecoration(color: greenWhats, borderRadius: BorderRadius.circular(3)),
                                                              child: Image.asset(whatsAppIc),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 30)
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
