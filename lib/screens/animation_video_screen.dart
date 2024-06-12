import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/controller/video_animation_list_controller.dart';
import 'package:fittyus/model/video_animation_list_model.dart';
import 'package:fittyus/screens/video_list_screen.dart';
import 'package:fittyus/services/api_url.dart';

class AnimationVideoScreen extends StatefulWidget {
  const AnimationVideoScreen({super.key});

  @override
  State<AnimationVideoScreen> createState() => _AnimationVideoScreenState();
}

class _AnimationVideoScreenState extends State<AnimationVideoScreen> {
  VideoAnimationListController controller = Get.put(VideoAnimationListController());
  UserController user = Get.find<UserController>();
  int selectedCategoryIndex = -1;

  @override
  void initState() {
    controller.isLoading = false;
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
      init: Get.find<VideoAnimationListController>(),
      initState: (state) {
        Get.find<VideoAnimationListController>().getVideoAnimationListApi();
      },
      builder: (contextCtrl) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: whiteColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Text(
                        "Explore Video",
                        style: TextStyle(
                          color: mainColor,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font16,
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (controller.isLoading) {
                      return SizedBox(
                        height: Dimensions.screenHeight - 200,
                        width: Dimensions.screenWidth,
                        child: const Center(child: CircularProgressIndicator(color: mainColor)),
                      );
                    }
                    if (controller.animationVideoList.isEmpty) {
                      return SizedBox(
                        width: Dimensions.screenWidth,
                        height: Dimensions.screenHeight - 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No Animation Video',
                              style: TextStyle(
                                color: mainColor,
                                fontSize: Dimensions.font16 + 2,
                                fontFamily: regular,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 5),
                            MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: contextCtrl.animationVideoList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return myAnimationVideoCategoryTile(contextCtrl.animationVideoList[index]);
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                          ],
                        ),
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

  myAnimationVideoCategoryTile(AnimationVideoListModel list) {
    return InkWell(
      onTap: () {
        Get.to(() => VideoListScreen(
              image: list.image.toString(),
              title: list.title.toString(),
              mediaList: list.media,
              totalSeconds: list.totalVideoSeconds.toString(),
            ));
      },
      child: Container(
        width: 125,
        height: 150,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.only(top: 11, bottom: 10, left: 20, right: 18),
        decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: whiteColor),
            borderRadius: BorderRadius.circular(11),
            boxShadow: [BoxShadow(offset: const Offset(0, 4), blurRadius: 4, spreadRadius: 0, color: mainColor.withOpacity(0.25))]),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    list.title.toString(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(color: mainColor, fontSize: Dimensions.font20, fontFamily: semiBold, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "${list.media.length} Exercise",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(color: mainColor, fontSize: Dimensions.font14 - 2, fontFamily: regular, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${list.totalMinutes} min.",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(color: mainColor, fontSize: Dimensions.font14 - 2, fontFamily: regular, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 122,
              width: 138,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: list.image!.isEmpty
                    ? Image.asset(
                        coachTopImg,
                        fit: BoxFit.fill,
                      )
                    : CachedNetworkImage(
                        errorWidget: (context, url, error) => Image.asset(
                          coachTopImg,
                          fit: BoxFit.fill,
                        ),
                        fit: BoxFit.fill,
                        imageUrl: ApiUrl.imageBaseUrl + list.image.toString(),
                        placeholder: (a, b) => const Center(
                          child: CircularProgressIndicator(color: mainColor),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
