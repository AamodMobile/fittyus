import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/screens/cms_screen.dart';
import 'package:fittyus/screens/edit_profile_screen.dart';
import 'package:fittyus/screens/help_and_support_screen.dart';
import 'package:fittyus/screens/login_screen.dart';
import 'package:fittyus/screens/my_plan_screen.dart';
import 'package:fittyus/screens/my_rating_screen.dart';
import 'package:fittyus/screens/my_session_screen.dart';
import 'package:fittyus/screens/new_profile_screen.dart';
import 'package:fittyus/widgets/my_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UserController user = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
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
                  "Account",
                  style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                ),
                const Spacer(),
                Visibility(
                  visible: false,
                  child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 44,
                        width: 90,
                        margin: const EdgeInsets.only(right: 10),
                        child: MyButton(
                          onPressed: () {},
                          color: pGreen,
                          child: Center(
                            child: Text(
                              "Clear All",
                              style: TextStyle(color: whiteColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                            ),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => NewProfileScreen(id: user.user.value.id.toString()));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 116,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        offset: Offset(0, 2),
                        blurRadius: 6,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 18,
                      ),
                      Obx(
                        () => Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Color.fromRGBO(0, 0, 0, 0.04),
                                spreadRadius: 0,
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
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
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                user.user.value.firstName == "" ? "New User" : user.user.value.firstName,
                                style: TextStyle(color: Colors.black, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                              ),
                            ),
                            Text(
                              user.user.value.mobile == "" ? "" : user.user.value.mobile,
                              style: TextStyle(color: lightGreyTxt, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(() => const EditProfileScreen());
                          },
                          child: Icon(
                            Icons.edit,
                            color: subPrimaryCl,
                            size: Dimensions.iconSize24,
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Get.to(
                    () => const MyPlanScreen(),
                  );
                },
                child: myMenuCont(planIc, "My Coaches"),
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () {
                  Get.to(
                    () => const MYSessionScreen(),
                  );
                },
                child: myMenuCont(planIc, "My Session"),
              ),
              const SizedBox(
                height: 12,
              ),
              Visibility(
                visible: false,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => const MyRatingScreen(),
                        );
                      },
                      child: myMenuCont(favIc, "My Ratings"),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
              const Visibility(
                visible: false,
                child: SizedBox(
                  height: 12,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(
                    () => const CMSScreen(tittle: "About Us"),
                  );
                },
                child: myMenuCont(infoIc, "About Us"),
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () async {
                  await Share.share('Fittyus App Download From Play Store:-'
                      '\n https://play.google.com/store/apps/details?id=com.fittyus"');
                },
                child: myMenuCont(shareMenuIc, "Share"),
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const HelpAndSupport());
                },
                child: myMenuCont(questionIc, "Help & Support"),
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const CMSScreen(tittle: "Terms of uses"));
                },
                child: myMenuCont(termIc, "Terms of uses"),
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const CMSScreen(tittle: "Privacy policy"));
                },
                child: myMenuCont(termIc, "Privacy policy"),
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () {
                  Get.defaultDialog(
                    title: "",
                    content: Column(
                      children: [
                        Image.asset(
                          appNewLogo,
                          height: 90,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          textAlign: TextAlign.center,
                          "Are you sure want to delete Account ?",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    backgroundColor: Colors.white,
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300], fixedSize: const Size(100, 15), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 15), backgroundColor: Colors.red, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () async {
                          user.deleteAccount();
                        },
                      )
                    ],
                    barrierDismissible: true,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4, spreadRadius: 0)], color: Colors.red, borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(13)),
                          child: const Center(
                            child: ImageIcon(
                              AssetImage(deleteAcIc),
                              size: 16,
                              color: mainColor,
                            ),
                          )),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Delete Account",
                        style: TextStyle(color: Colors.black, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                      ),
                      const Spacer(),
                      const ImageIcon(
                        AssetImage(
                          arrowForWordIc,
                        ),
                        size: 12,
                        color: mainColor,
                      ),
                      const SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 100,
                height: 40,
                decoration: const BoxDecoration(color: whiteColor, boxShadow: [BoxShadow(offset: Offset(0, 4), blurRadius: 4, spreadRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.25))]),
                child: MyButton(
                  onPressed: () async {

                    Get.defaultDialog(
                      title: "",
                      contentPadding: EdgeInsets.zero,
                      titlePadding: EdgeInsets.zero,
                      content: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width),
                            Image.asset(
                              splashLogo,
                              height: 70,
                              width: 70,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Are you sure want to logout",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[300], fixedSize: const Size(100, 15), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                const SizedBox(width: 30),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(100, 15), backgroundColor: mainColor, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                                  child: const Text(
                                    "Confirm",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onPressed: () async {
                                    SharedPreferences preferences = await SharedPreferences.getInstance();
                                    await preferences.clear();
                                    Get.offAll(() => const LoginScreen());
                                    Get.back();
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      backgroundColor: Colors.white,
                      barrierDismissible: true,

                    );
                  },
                  color: whiteColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        logoutNewIc,
                        height: 28,
                        width: 17,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  myMenuCont(String image, String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4, spreadRadius: 0)], color: whiteColor, borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(7),
              height: 26,
              width: 26,
              decoration: BoxDecoration(color: dividerClSec, borderRadius: BorderRadius.circular(13)),
              child: ImageIcon(
                AssetImage(
                  image,
                ),
                color: mainColor,
              )),
          const SizedBox(
            width: 16,
          ),
          Text(
            name,
            style: TextStyle(color: Colors.black, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
          ),
          const Spacer(),
          Image.asset(
            arrowForWordIc,
            height: 12,
            width: 7,
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
    );
  }
}
