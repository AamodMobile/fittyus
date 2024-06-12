import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/my_plan_list_controller.dart';
import 'package:fittyus/model/my_plan_list_model.dart';

import '../controller/user_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserController user = Get.find<UserController>();
  MyPlanListController plan = Get.put(MyPlanListController());

  @override
  void initState() {
    plan.myPlanList.clear();
    plan.isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<UserController>(),
      initState: (state) {
        Get.find<UserController>().getProfile();
        Get.find<MyPlanListController>().myPlanListApi();
      },
      builder: (contextCtrl) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: mainColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.elliptical(MediaQuery.of(context).size.width * 0.5, 100.0),
                              bottomRight: Radius.elliptical(MediaQuery.of(context).size.width * 0.5, 100.0),
                            ),
                            image: const DecorationImage(fit: BoxFit.cover, image: AssetImage(profileBgImg)),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "Profile",
                                    style: TextStyle(color: whiteColor, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
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
                                      demoImg,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Text(
                                "Name",
                                style: TextStyle(color: lightGreyTxt, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                              ),
                            ),
                            Text(
                              user.user.value.firstName == "" ? "New User" : user.user.value.firstName,
                              style: TextStyle(color: mainColor, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 1,
                          color: dividerCl,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Text(
                                "Mobile",
                                style: TextStyle(color: lightGreyTxt, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                              ),
                            ),
                            Text(
                              user.user.value.mobile == "" ? "New User" : user.user.value.mobile,
                              style: TextStyle(color: mainColor, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 1,
                          color: dividerCl,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Text(
                                "Email",
                                style: TextStyle(color: lightGreyTxt, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                user.user.value.email == "" ? "mail id" : user.user.value.email,
                                style: TextStyle(color: mainColor, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 1,
                          color: dividerCl,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Text(
                                "Gander",
                                style: TextStyle(color: lightGreyTxt, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                              ),
                            ),
                            Text(
                              user.user.value.gender == "" ? "gender" : user.user.value.gender,
                              style: TextStyle(color: mainColor, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(
                            height: 1,
                            color: dividerCl,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        /* Text(
                          plan.myPlanList.isNotEmpty
                              ? "Active Plans"
                              : "No Active Plan",
                          style: TextStyle(
                              color: mainColor,
                              fontFamily: medium,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: Dimensions.font16),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Builder(builder: (context) {
                          if (plan.isLoading) {
                            return SizedBox(
                              height: 300,
                              width: Dimensions.screenWidth,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: mainColor,
                                ),
                              ),
                            );
                          }
                          if (plan.myPlanList.isEmpty) {
                            return Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                child: Text(
                                  "You have no  plan now",
                                  style: TextStyle(
                                      color: subPrimaryCl,
                                      fontFamily: semiBold,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14),
                                ),
                              ),
                            );
                          }
                          return SizedBox(
                            height: 210,
                            child: ListView.builder(
                              itemCount: plan.myPlanList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return myActivePlanListTile(
                                    plan.myPlanList[index]);
                              },
                            ),
                          );
                        })*/
                      ],
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

  myActivePlanListTile(MyPlanListModel list) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 200,
        width: 250,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(activePlanBg), fit: BoxFit.contain),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              width: 100,
              child: Text(
                list.name.toString(),
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(color: mainColor, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, overflow: TextOverflow.ellipsis, fontSize: Dimensions.font14 - 4),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 100,
              child: Text(
                list.duration.toString(),
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(color: const Color(0xFF1B63CE), fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "₹${list.paidTotal.toString()}",
              textAlign: TextAlign.center,
              style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 110,
              decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Day left ",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      children: [
                        TextSpan(
                          text: list.dayCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.font16 + 2,
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
          ],
        ),
      ),
    );
  }
}
