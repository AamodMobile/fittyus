import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/search_controller.dart';
import 'package:fittyus/screens/challenge_details_screen.dart';
import 'package:fittyus/screens/coach_details_screen.dart';
import 'package:fittyus/screens/coachs_list_screen.dart';
import 'package:fittyus/screens/new_profile_screen.dart';
import 'package:fittyus/screens/training_session_details_screen.dart';
import 'package:fittyus/services/api_url.dart';

class SearchScreen extends StatefulWidget {
  final String type;

  const SearchScreen({super.key, required this.type});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search = TextEditingController();
  UserSearchController controller = Get.put(UserSearchController());

  var list = [
    "All",
    "Challenge",
    "Coach",
    "Category",
    "Session",
    "Customer Profile",
  ];
  int selectedIndex = 0;
  String selectedType = "All";

  @override
  void initState() {
    selectedType = widget.type;
    controller.isData=false;
    controller.sessionList.clear();
    controller.usersList.clear();
    controller.teacherList.clear();
    controller.categoryList.clear();
    controller.allChallengeList.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<UserSearchController>(),
        initState: (state) {},
        builder: (contCtr) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
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
                            FocusScope.of(context).requestFocus(FocusNode());
                            Get.back();
                            controller.sessionList.clear();
                            controller.usersList.clear();
                            controller.teacherList.clear();
                            controller.categoryList.clear();
                            controller.allChallengeList.clear();
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
                      const SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextFormField(
                          controller: search,
                          autofocus: false,
                          maxLines: 1,
                          maxLength: 12,
                          textInputAction: TextInputAction.search,
                          onChanged: (v) {
                            setState(() {
                              search.text = v;
                              if (search.text.length > 3) {
                                contCtr.searchApi(v);
                              }
                            });
                          },
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              contCtr.searchApi(search.text);
                            });
                          },
                          decoration: const InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Search",
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      search.text == ""
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  search.text = "";
                                  controller.isData = false;
                                  contCtr.allChallengeList.clear();
                                  contCtr.teacherList.clear();
                                  contCtr.categoryList.clear();
                                  contCtr.sessionList.clear();
                                });
                              },
                              child: const SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(
                                  Icons.close,
                                  size: 26,
                                  color: mainColor,
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
              body: Builder(builder: (context) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    /*    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                selectedIndex = index;
                                selectedType = list[index];
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              height: 30,
                              decoration: BoxDecoration(
                                  color: selectedIndex == index
                                      ? const Color.fromRGBO(226, 229, 238, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: selectedIndex == index
                                          ? mainColor
                                          : dividerCl)),
                              child: Text(
                                list[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    fontFamily: regular,
                                    color: Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    ),*/
                    const SizedBox(height: 10),
                    contCtr.isLoading
                        ? SingleChildScrollView(
                            child: SizedBox(
                              height: Dimensions.screenHeight - 200,
                              width: Dimensions.screenWidth,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: mainColor,
                                ),
                              ),
                            ),
                          )
                        : contCtr.isData == true
                            ? Builder(builder: (context) {
                                return Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Visibility(
                                          visible: selectedType == "All" ? true : false,
                                          child: Column(
                                            children: [
                                              Visibility(
                                                visible: contCtr.allChallengeList.isNotEmpty ? true : false,
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: Text(
                                                      "Challenges",
                                                      style: TextStyle(color: mainColor, fontFamily: bold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  MediaQuery.removePadding(
                                                    context: context,
                                                    removeTop: true,
                                                    child: ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: contCtr.allChallengeList.length,
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            FocusScope.of(context).requestFocus(FocusNode());
                                                            Get.to(() => ChallengeDetailsScreen(id: contCtr.allChallengeList[index].id.toString()));
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                                            height: 60,
                                                            width: MediaQuery.of(context).size.width,
                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: dividerCl)),
                                                            child: Row(
                                                              children: [
                                                                contCtr.allChallengeList[index].avatarUrl == null && contCtr.allChallengeList[index].avatarUrl == ""
                                                                    ? Image.asset(
                                                                        demoImg,
                                                                        width: 50,
                                                                        fit: BoxFit.fill,
                                                                      )
                                                                    : CachedNetworkImage(
                                                                        errorWidget: (context, url, error) => Image.asset(
                                                                          bannerImg,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                        fit: BoxFit.fill,
                                                                        width: 50,
                                                                        imageUrl: ApiUrl.imageBaseUrl + contCtr.allChallengeList[index].avatarUrl.toString(),
                                                                        placeholder: (a, b) => const Center(
                                                                          child: CircularProgressIndicator(),
                                                                        ),
                                                                      ),
                                                                const SizedBox(width: 15),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      contCtr.allChallengeList[index].title.toString(),
                                                                      textAlign: TextAlign.center,
                                                                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: regular, color: Colors.black),
                                                                    ),
                                                                    Text(
                                                                      contCtr.allChallengeList[index].description.toString(),
                                                                      textAlign: TextAlign.center,
                                                                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: regular, color: dividerCl),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ]),
                                              ),
                                              Visibility(
                                                visible: contCtr.teacherList.isNotEmpty ? true : false,
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: Text(
                                                      "Coach",
                                                      style: TextStyle(color: mainColor, fontFamily: bold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  MediaQuery.removePadding(
                                                    context: context,
                                                    removeTop: true,
                                                    child: ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: contCtr.teacherList.length,
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            FocusScope.of(context).requestFocus(FocusNode());
                                                            Get.to(() => CoachDetailsScreen(coachId: contCtr.teacherList[index].id.toString()));
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                                            height: 60,
                                                            width: MediaQuery.of(context).size.width,
                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: dividerCl)),
                                                            child: Row(
                                                              children: [
                                                                contCtr.teacherList[index].image == null && contCtr.teacherList[index].image == ""
                                                                    ? Image.asset(
                                                                        demoImg,
                                                                        width: 50,
                                                                        fit: BoxFit.fill,
                                                                      )
                                                                    : CachedNetworkImage(
                                                                        errorWidget: (context, url, error) => Image.asset(
                                                                          bannerImg,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                        fit: BoxFit.fill,
                                                                        width: 50,
                                                                        imageUrl: contCtr.teacherList[index].image.toString(),
                                                                        placeholder: (a, b) => const Center(
                                                                          child: CircularProgressIndicator(),
                                                                        ),
                                                                      ),
                                                                const SizedBox(width: 15),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      contCtr.teacherList[index].name.toString(),
                                                                      textAlign: TextAlign.center,
                                                                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: regular, color: Colors.black),
                                                                    ),
                                                                    Text(
                                                                      contCtr.teacherList[index].coachType.toString(),
                                                                      textAlign: TextAlign.center,
                                                                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: regular, color: dividerCl),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ]),
                                              ),
                                              Visibility(
                                                visible: contCtr.categoryList.isNotEmpty ? true : false,
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: Text(
                                                      "Category",
                                                      style: TextStyle(color: mainColor, fontFamily: bold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  MediaQuery.removePadding(
                                                    context: context,
                                                    removeTop: true,
                                                    child: ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: controller.categoryList.length,
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            FocusScope.of(context).requestFocus(FocusNode());
                                                            Get.to(() => CoachesListScreen(categoryId: controller.categoryList[index].id.toString()));
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                                            height: 60,
                                                            width: MediaQuery.of(context).size.width,
                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: dividerCl)),
                                                            child: Row(
                                                              children: [
                                                                contCtr.categoryList[index].image == null && contCtr.categoryList[index].image == ""
                                                                    ? Image.asset(
                                                                        demoImg,
                                                                        width: 50,
                                                                        fit: BoxFit.fill,
                                                                      )
                                                                    : CachedNetworkImage(
                                                                        errorWidget: (context, url, error) => Image.asset(
                                                                          bannerImg,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                        fit: BoxFit.fill,
                                                                        width: 50,
                                                                        imageUrl: ApiUrl.imageBaseUrl + contCtr.categoryList[index].image.toString(),
                                                                        placeholder: (a, b) => const Center(
                                                                          child: CircularProgressIndicator(),
                                                                        ),
                                                                      ),
                                                                const SizedBox(width: 15),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      controller.categoryList[index].title.toString(),
                                                                      textAlign: TextAlign.center,
                                                                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: regular, color: Colors.black),
                                                                    ),
                                                                    Text(
                                                                      controller.categoryList[index].title.toString(),
                                                                      textAlign: TextAlign.center,
                                                                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: regular, color: dividerCl),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ]),
                                              ),
                                              Visibility(
                                                visible: controller.sessionList.isNotEmpty ? true : false,
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: Text(
                                                      "Session",
                                                      style: TextStyle(color: mainColor, fontFamily: bold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  MediaQuery.removePadding(
                                                    context: context,
                                                    removeTop: true,
                                                    child: ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: controller.sessionList.length,
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            FocusScope.of(context).requestFocus(FocusNode());
                                                            Get.to(() => TrainingSessionDetailsScreen(list: controller.sessionList[index]));
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                                            height: 60,
                                                            width: MediaQuery.of(context).size.width,
                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: dividerCl)),
                                                            child: Row(
                                                              children: [
                                                                contCtr.sessionList[index].sessionImage == null && contCtr.sessionList[index].sessionImage == ""
                                                                    ? Image.asset(
                                                                        demoImg,
                                                                        width: 50,
                                                                        fit: BoxFit.fill,
                                                                      )
                                                                    : CachedNetworkImage(
                                                                        errorWidget: (context, url, error) => Image.asset(
                                                                          bannerImg,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                        fit: BoxFit.fill,
                                                                        width: 50,
                                                                        imageUrl: ApiUrl.imageBaseUrl + contCtr.sessionList[index].sessionImage.toString(),
                                                                        placeholder: (a, b) => const Center(
                                                                          child: CircularProgressIndicator(),
                                                                        ),
                                                                      ),
                                                                const SizedBox(width: 15),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        controller.sessionList[index].name.toString(),
                                                                        textAlign: TextAlign.center,
                                                                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: regular, color: Colors.black),
                                                                      ),
                                                                      Text(
                                                                        controller.sessionList[index].shortDescription.toString(),
                                                                        textAlign: TextAlign.center,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        maxLines: 1,
                                                                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: regular, color: dividerCl),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ]),
                                              ),
                                              Visibility(
                                                visible: controller.usersList.isNotEmpty ? true : false,
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: Text(
                                                      "Users Profile",
                                                      style: TextStyle(color: mainColor, fontFamily: bold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  MediaQuery.removePadding(
                                                    context: context,
                                                    removeTop: true,
                                                    child: ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: controller.usersList.length,
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            FocusScope.of(context).requestFocus(FocusNode());
                                                            Get.to(() => TrainingSessionDetailsScreen(list: controller.sessionList[index]));
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                                            height: 60,
                                                            width: MediaQuery.of(context).size.width,
                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: dividerCl)),
                                                            child: Row(
                                                              children: [
                                                                contCtr.usersList[index].profileImage != ""
                                                                    &&contCtr.usersList[index].profileImage!=null
                                                                    ? CachedNetworkImage(
                                                                        errorWidget: (context, url, error) => Image.asset(
                                                                          bannerImg,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                        fit: BoxFit.fill,
                                                                        width: 50,
                                                                        imageUrl: contCtr.usersList[index].profileImage.toString(),
                                                                        placeholder: (a, b) => const Center(
                                                                          child: CircularProgressIndicator(),
                                                                        ),
                                                                      ):Image.asset(
                                                                  demoImg,
                                                                  width: 50,
                                                                  fit: BoxFit.fill,
                                                                ),
                                                                const SizedBox(width: 15),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        controller.usersList[index].firstName.toString(),
                                                                        textAlign: TextAlign.center,
                                                                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: regular, color: Colors.black),
                                                                      ),
                                                                      Text(
                                                                        controller.usersList[index].gender.toString(),
                                                                        textAlign: TextAlign.center,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        maxLines: 1,
                                                                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: regular, color: dividerCl),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                            visible: selectedType == "Challenge" ? true : false,
                                            child: Column(
                                              children: [
                                                MediaQuery.removePadding(
                                                  context: context,
                                                  removeTop: true,
                                                  child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: controller.allChallengeList.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          FocusScope.of(context).requestFocus(FocusNode());
                                                          Get.to(() => ChallengeDetailsScreen(id: controller.allChallengeList[index].id.toString()));
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                                          height: 60,
                                                          width: MediaQuery.of(context).size.width,
                                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: dividerCl)),
                                                          child: Row(
                                                            children: [
                                                              contCtr.allChallengeList[index].avatarUrl == null && contCtr.allChallengeList[index].avatarUrl == ""
                                                                  ? Image.asset(
                                                                      demoImg,
                                                                      width: 50,
                                                                      fit: BoxFit.fill,
                                                                    )
                                                                  : CachedNetworkImage(
                                                                      errorWidget: (context, url, error) => Image.asset(
                                                                        bannerImg,
                                                                        fit: BoxFit.fill,
                                                                      ),
                                                                      fit: BoxFit.fill,
                                                                      width: 50,
                                                                      imageUrl: ApiUrl.imageBaseUrl + contCtr.allChallengeList[index].avatarUrl.toString(),
                                                                      placeholder: (a, b) => const Center(
                                                                        child: CircularProgressIndicator(),
                                                                      ),
                                                                    ),
                                                              const SizedBox(width: 15),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    controller.allChallengeList[index].title.toString(),
                                                                    textAlign: TextAlign.center,
                                                                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: regular, color: Colors.black),
                                                                  ),
                                                                  Text(
                                                                    controller.allChallengeList[index].description.toString(),
                                                                    textAlign: TextAlign.center,
                                                                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: regular, color: dividerCl),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            )),
                                        Visibility(
                                            visible: selectedType == "Coach" ? true : false,
                                            child: Column(
                                              children: [
                                                MediaQuery.removePadding(
                                                  context: context,
                                                  removeTop: true,
                                                  child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: contCtr.teacherList.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          FocusScope.of(context).requestFocus(FocusNode());
                                                          Get.to(() => CoachDetailsScreen(coachId: contCtr.teacherList[index].id.toString()));
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                                          height: 60,
                                                          width: MediaQuery.of(context).size.width,
                                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: dividerCl)),
                                                          child: Row(
                                                            children: [
                                                              contCtr.teacherList[index].image == null && contCtr.teacherList[index].image == ""
                                                                  ? Image.asset(
                                                                      demoImg,
                                                                      width: 50,
                                                                      fit: BoxFit.fill,
                                                                    )
                                                                  : CachedNetworkImage(
                                                                      errorWidget: (context, url, error) => Image.asset(
                                                                        bannerImg,
                                                                        fit: BoxFit.fill,
                                                                      ),
                                                                      fit: BoxFit.fill,
                                                                      width: 50,
                                                                      imageUrl: contCtr.teacherList[index].image.toString(),
                                                                      placeholder: (a, b) => const Center(
                                                                        child: CircularProgressIndicator(),
                                                                      ),
                                                                    ),
                                                              const SizedBox(width: 15),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    controller.teacherList[index].name.toString(),
                                                                    textAlign: TextAlign.center,
                                                                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: regular, color: Colors.black),
                                                                  ),
                                                                  Text(
                                                                    controller.teacherList[index].coachType.toString(),
                                                                    textAlign: TextAlign.center,
                                                                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: regular, color: dividerCl),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            )),
                                        Visibility(
                                            visible: selectedType == "Category" ? true : false,
                                            child: Column(
                                              children: [
                                                MediaQuery.removePadding(
                                                  context: context,
                                                  removeTop: true,
                                                  child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: controller.categoryList.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          FocusScope.of(context).requestFocus(FocusNode());
                                                          Get.to(() => CoachesListScreen(categoryId: controller.categoryList[index].id.toString()));
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                                          height: 60,
                                                          width: MediaQuery.of(context).size.width,
                                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: dividerCl)),
                                                          child: Row(
                                                            children: [
                                                              contCtr.categoryList[index].image == null && contCtr.categoryList[index].image == ""
                                                                  ? Image.asset(
                                                                      demoImg,
                                                                      width: 50,
                                                                      fit: BoxFit.fill,
                                                                    )
                                                                  : CachedNetworkImage(
                                                                      errorWidget: (context, url, error) => Image.asset(
                                                                        bannerImg,
                                                                        fit: BoxFit.fill,
                                                                      ),
                                                                      fit: BoxFit.fill,
                                                                      width: 50,
                                                                      imageUrl: ApiUrl.imageBaseUrl + contCtr.categoryList[index].image.toString(),
                                                                      placeholder: (a, b) => const Center(
                                                                        child: CircularProgressIndicator(),
                                                                      ),
                                                                    ),
                                                              const SizedBox(width: 15),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      controller.categoryList[index].title.toString(),
                                                                      textAlign: TextAlign.center,
                                                                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: regular, color: Colors.black),
                                                                    ),
                                                                    Text(
                                                                      controller.categoryList[index].title.toString(),
                                                                      textAlign: TextAlign.center,
                                                                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: regular, color: dividerCl),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            )),
                                        Visibility(
                                          visible: selectedType == "Session" ? true : false,
                                          child: Column(
                                            children: [
                                              MediaQuery.removePadding(
                                                context: context,
                                                removeTop: true,
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: controller.sessionList.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        FocusScope.of(context).requestFocus(FocusNode());
                                                        Get.to(() => TrainingSessionDetailsScreen(list: controller.sessionList[index]));
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                                        height: 60,
                                                        width: MediaQuery.of(context).size.width,
                                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: dividerCl)),
                                                        child: Row(
                                                          children: [
                                                            contCtr.sessionList[index].sessionImage == null && contCtr.sessionList[index].sessionImage == ""
                                                                ? Image.asset(
                                                                    demoImg,
                                                                    width: 50,
                                                                    fit: BoxFit.fill,
                                                                  )
                                                                : CachedNetworkImage(
                                                                    errorWidget: (context, url, error) => Image.asset(
                                                                      bannerImg,
                                                                      fit: BoxFit.fill,
                                                                    ),
                                                                    fit: BoxFit.fill,
                                                                    width: 50,
                                                                    imageUrl: ApiUrl.imageBaseUrl + contCtr.sessionList[index].sessionImage.toString(),
                                                                    placeholder: (a, b) => const Center(
                                                                      child: CircularProgressIndicator(),
                                                                    ),
                                                                  ),
                                                            const SizedBox(width: 15),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    controller.sessionList[index].name.toString(),
                                                                    textAlign: TextAlign.center,
                                                                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: regular, color: Colors.black),
                                                                  ),
                                                                  Text(
                                                                    controller.sessionList[index].shortDescription.toString(),
                                                                    textAlign: TextAlign.center,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: regular, color: dividerCl),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: selectedType == "Customer Profile" ? true : false,
                                          child: Column(
                                            children: [
                                              MediaQuery.removePadding(
                                                context: context,
                                                removeTop: true,
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: controller.usersList.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        FocusScope.of(context).requestFocus(FocusNode());
                                                        Get.to(() => NewProfileScreen(id: controller.usersList[index].id.toString()));
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                                        height: 60,
                                                        width: MediaQuery.of(context).size.width,
                                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: dividerCl)),
                                                        child: Row(
                                                          children: [
                                                            contCtr.usersList[index].profileImage != ""
                                                                &&contCtr.usersList[index].profileImage!=null
                                                                ? CachedNetworkImage(
                                                              errorWidget: (context, url, error) => Image.asset(
                                                                bannerImg,
                                                                fit: BoxFit.fill,
                                                              ),
                                                              fit: BoxFit.fill,
                                                              width: 50,
                                                              imageUrl: contCtr.usersList[index].profileImage.toString(),
                                                              placeholder: (a, b) => const Center(
                                                                child: CircularProgressIndicator(),
                                                              ),
                                                            ):Image.asset(
                                                              demoImg,
                                                              width: 50,
                                                              fit: BoxFit.fill,
                                                            ),
                                                            const SizedBox(width: 15),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    controller.usersList[index].firstName.toString(),
                                                                    textAlign: TextAlign.center,
                                                                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: regular, color: Colors.black),
                                                                  ),
                                                                  Text(
                                                                    controller.usersList[index].gender.toString(),
                                                                    textAlign: TextAlign.center,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    maxLines: 1,
                                                                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: regular, color: dividerCl),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                            : SingleChildScrollView(
                                child: SizedBox(
                                  width: Dimensions.screenWidth,
                                  height: Dimensions.screenHeight - 700,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'No  Data',
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: Dimensions.font16 + 2,
                                          fontFamily: regular,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                  ],
                );
              }),
            ),
          );
        });
  }
}
