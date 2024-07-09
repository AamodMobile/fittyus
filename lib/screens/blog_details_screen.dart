import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/blog_details_controller.dart';
import 'package:fittyus/screens/comment_list_screen.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:flutter_html/flutter_html.dart';

class BlogDetailsScreen extends StatefulWidget {
  final String blogId;

  const BlogDetailsScreen({super.key, required this.blogId});

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  BlogDetailsController controller = Get.put(BlogDetailsController());

  @override
  void initState() {
    controller.isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<BlogDetailsController>(),
      initState: (state) {
        Get.find<BlogDetailsController>()
            .blogDetailsApi(widget.blogId.toString());
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
                      "Blog Details",
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

            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Builder(builder: (context) {
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
                        if (contextCtrl.blogDetails == "") {
                          return SizedBox(
                            width: Dimensions.screenWidth,
                            height: Dimensions.screenHeight - 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'No Details Found',
                                  style: TextStyle(
                                      color: mainColor,
                                      fontSize: Dimensions.font16 + 2,
                                      fontFamily: regular,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Text(
                                contextCtrl.blogDetails.value.title.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: mainColor,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: Dimensions.font16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: contextCtrl.blogDetails.value.image
                                        .toString()
                                        .isNotEmpty
                                    ? CachedNetworkImage(
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          coachTopImg,
                                          fit: BoxFit.fill,
                                        ),
                                        fit: BoxFit.fill,
                                        imageUrl: ApiUrl.imageBaseUrl +
                                            contextCtrl.blogDetails.value.image
                                                .toString(),
                                        placeholder: (a, b) => const Center(
                                          child: CircularProgressIndicator(
                                            color: mainColor,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(10),
                                          image: const DecorationImage(
                                              image: AssetImage(coachTopImg),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Html(
                                data: contextCtrl.blogDetails.value.description
                                    .toString(),
                                style: {
                                  "body": Style(
                                    color: mainColor,
                                    fontFamily: medium,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      }),
                    ),
                  ),
                  !controller.isLoading
                      ? Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: InkWell(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                width: MediaQuery.of(context).size.width * 0.40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text("Comments",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: semiBold,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              fontSize: Dimensions.font16)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Image.asset(
                                          messageIc,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                Get.to(() => CommentListScreen(
                                      blogId: widget.blogId,
                                      blogTitle: contextCtrl
                                          .blogDetails.value.title
                                          .toString(),
                                    ));
                              },
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
