import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/coach_list_controller.dart';
import 'package:fittyus/model/coach_model.dart';
import 'package:fittyus/screens/coach_details_screen.dart';
import 'package:fittyus/screens/plan_screen.dart';
import 'package:fittyus/services/api_url.dart';

class CoachesListScreen extends StatefulWidget {
  final String categoryId;
  final String city;

  const CoachesListScreen({super.key, required this.categoryId, required this.city});

  @override
  State<CoachesListScreen> createState() => _CoachesListScreenState();
}

class _CoachesListScreenState extends State<CoachesListScreen> {
  CoachListController controller = Get.put(CoachListController());

  @override
  void initState() {
    controller.teacherList.clear();
    controller.isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CoachListController>(),
      initState: (state) {
        Get.find<CoachListController>().getCoachListApi(
            widget.categoryId.toString(),"");
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
                      "Coach's",
                      style: TextStyle(
                          color: mainColor,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font16),
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
            body: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Builder(
                  builder: (context) {
                    if (contextCtrl.isLoading) {
                      return SizedBox(
                        height: Dimensions.screenHeight - 200,
                        width: Dimensions.screenWidth,
                        child: const Center(
                            child: CircularProgressIndicator(color: mainColor)),
                      );
                    }

                    if (contextCtrl.teacherList.isEmpty) {
                      return SizedBox(
                        width: Dimensions.screenWidth,
                        height: Dimensions.screenHeight - 200,
                       child: Image.asset(noCoachFound,
                         fit: BoxFit.contain,
                        ),
                      );
                    }
                    return Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: contextCtrl.teacherList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 230,
                                childAspectRatio: 1,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 15,
                                crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return myCoachListTile(contextCtrl.teacherList[index]);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  myCoachListTile(CoachList list) {
    return InkWell(
      onTap: () {
        Get.to(() => CoachDetailsScreen(
              coachId: list.id.toString(),
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 9,vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        width: 160,
        height: 250,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(0, 2),
              blurRadius: 6,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              height: 14,
              width: 36,
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(18)),
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
                    list.averageRating.toString(),
                    style: const TextStyle(color: whiteColor, fontSize: 8),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
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
                  child: list.image!.isNotEmpty
                      ? CachedNetworkImage(
                          errorWidget: (context, url, error) => Image.asset(
                            certificateImg,
                            fit: BoxFit.cover,
                          ),
                          fit: BoxFit.fill,
                          imageUrl: ApiUrl.imageBaseUrl + list.image.toString(),
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
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text(
                    list.name.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: semiBold,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: Dimensions.font14),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    list.coachType != null && list.coachType != ""
                        ? list.coachType.toString()
                        : "Silver Coach",
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
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: list.timeslots!.isNotEmpty
                  ? SizedBox(
                child: Text(
                  "Slots Available ${list.timeslots!.length}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: mainColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
                  : const SizedBox(
                      child: Text(
                        "No Time Slots",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.0,
                          color: mainColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Get.to(() => PlanScreen(coachId: list.id.toString()));
                },
                child: Container(
                  height: 32,
                  width: 98,
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
                      style: TextStyle(
                          color:pGreen,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font14),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
