import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/community_controller.dart';
import 'package:fittyus/services/api_url.dart';

class GalleryScreen extends StatefulWidget {
  final String id;

  const GalleryScreen({super.key, required this.id});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  CommunityController controller = Get.put(CommunityController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CommunityController>(),
      initState: (state) {
        Get.find<CommunityController>().communityGallery(widget.id);
      },
      builder: (cont) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar: PreferredSize(
              preferredSize:
                  Size(Dimensions.height90, MediaQuery.of(context).size.width),
              child: Container(
                height: Dimensions.height45 + Dimensions.height20,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(color: whiteColor, boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 15,
                      spreadRadius: 0,
                      color: Color.fromRGBO(0, 0, 0, 0.2))
                ]),
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
                    const SizedBox(width: 12),
                    Text(
                      "Gallery",
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
            body: Builder(
              builder: (context) {
                if (cont.isLoading.value) {
                  return SizedBox(
                    height: Dimensions.screenHeight - 200,
                    width: Dimensions.screenWidth,
                    child: const Center(
                        child: CircularProgressIndicator(
                      color: mainColor,
                    )),
                  );
                }
                if (cont.galleryImg.isEmpty) {
                  return Column(
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
                      const SizedBox(height: 30),
                      Text(
                        "There are no images here",
                        style: TextStyle(
                            color: subPrimaryCl,
                            fontFamily: semiBold,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: Dimensions.font14),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                        height: 3, width: MediaQuery.of(context).size.width),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 125 / 151),
                          itemCount: cont.galleryImg.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 125,
                              height: 151,
                              color: whiteColor,
                              child: ClipRRect(
                                child: cont.galleryImg[index].image != "" &&
                                        cont.galleryImg[index].image != null
                                    ? CachedNetworkImage(
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          demoImg,
                                          fit: BoxFit.cover,
                                        ),
                                        fit: BoxFit.cover,
                                        imageUrl: ApiUrl.imageBaseUrl +
                                            cont.galleryImg[index].image
                                                .toString(),
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
                            );
                          }),
                    ),
                    const SizedBox(height: 10)
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
