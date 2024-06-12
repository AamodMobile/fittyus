import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/model/video_animation_list_model.dart';
import 'package:fittyus/screens/video_details_screen.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class VideoListScreen extends StatefulWidget {
  final String title;
  final String image;
  final String totalSeconds;
  final List<Media> mediaList;

  const VideoListScreen({
    super.key,
    required this.title,
    required this.mediaList,
    required this.image,
    required this.totalSeconds,
  });

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
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
                  widget.title,
                  style: TextStyle(
                    color: mainColor,
                    fontFamily: semiBold,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: Dimensions.font16,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 5),
            SizedBox(
              height: 250,
              width: Get.width,
              child: ClipRRect(
                child: widget.image != ""
                    ? CachedNetworkImage(
                        errorWidget: (context, url, error) => Image.asset(
                          coachTopImg,
                          fit: BoxFit.fill,
                        ),
                        fit: BoxFit.fill,
                        imageUrl: ApiUrl.imageBaseUrl + widget.image.toString(),
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
            Container(
              height: 111,
              width: MediaQuery.of(context).size.width,
              color: whiteColor,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.title}  Workout',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: Dimensions.font16,
                      fontFamily: bold,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                        decoration: BoxDecoration(color: const Color(0xFFDAFFF0), borderRadius: BorderRadius.circular(11), border: Border.all(color: const Color(0xFF27C889), width: 1)),
                        child: Row(
                          children: [
                            Image.asset(
                              clockGIc,
                              height: 14,
                              width: 19,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${(int.parse(widget.totalSeconds) ~/ 60).toString().padLeft(2, '0')}:${(int.parse(widget.totalSeconds) % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(
                                color: const Color(0xFF27C889),
                                fontSize: Dimensions.font14 - 4,
                                fontFamily: bold,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 24,
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0xFFDAFFF0), borderRadius: BorderRadius.circular(11), border: Border.all(color: const Color(0xFF27C889), width: 1)),
                        child: Row(
                          children: [
                            Image.asset(
                              setIc,
                              height: 18,
                              width: 30,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${widget.mediaList.length} Exercises',
                              style: TextStyle(
                                color: const Color(0xFF27C889),
                                fontSize: Dimensions.font14 - 4,
                                fontFamily: bold,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 1),
            Builder(
              builder: (context) {
                if (widget.mediaList.isEmpty) {
                  return SizedBox(
                    width: Dimensions.screenWidth,
                    height: Dimensions.screenHeight - 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No Video',
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.mediaList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return myVideoListTile(widget.mediaList[index]);
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
  }

  myVideoListTile(Media list) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => VideoDetailsScreen(file: list));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 67,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: const Color(0xFFE9E9E9)),
                borderRadius: BorderRadius.circular(9),
                boxShadow: [BoxShadow(offset: const Offset(0, 4), blurRadius: 4, spreadRadius: 0, color: mainColor.withOpacity(0.25))]),
            child: Row(
              children: [
                SizedBox(
                  width: 67,
                  height: 52,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: list.media!.isEmpty
                        ? Image.asset(
                            coachTopImg,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            errorWidget: (context, url, error) => Image.asset(coachTopImg, fit: BoxFit.cover),
                            fit: BoxFit.cover,
                            imageUrl: list.media.toString(),
                            placeholder: (a, b) => const Center(
                              child: CircularProgressIndicator(color: mainColor),
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        list.title.toString(),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          color: mainColor,
                          fontSize: Dimensions.font14 - 3,
                          fontFamily: bold,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${list.totalSeconds} Seconds",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          color: mainColor,
                          fontSize: Dimensions.font14 - 4,
                          fontFamily: medium,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      LinearPercentIndicator(
                        barRadius: const Radius.circular(2),
                        animation: true,
                        padding: EdgeInsets.zero,
                        animationDuration: 1000,
                        lineHeight: 10.0,
                        percent: int.parse(list.previousWatchTime.toString()) / list.totalSeconds!.toInt(),
                        progressColor: const Color(0xFF27C889),
                        backgroundColor: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: SizedBox(
                    width: 47,
                    height: 67,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        list.isLock == 1
                            ? const SizedBox()
                            : Text(
                                "Free",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                  color: pGreen,
                                  fontSize: Dimensions.font14 - 2,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              arrowGreen,
                              height: 17,
                              width: 20,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 11),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
