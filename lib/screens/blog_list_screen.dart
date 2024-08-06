import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/blog_list_controller.dart';
import 'package:fittyus/model/blog_list_model.dart';
import 'package:fittyus/screens/blog_details_screen.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'comment_list_screen.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({
    super.key,
  });

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  BlogListController controller = Get.put(BlogListController());

  @override
  void initState() {
    controller.blogList.clear();
    controller.isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<BlogListController>(),
      initState: (state) {
        Get.find<BlogListController>().getBlogListApi();
      },
      builder: (contextCtrl) {
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
                      "Blogs",
                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                    ),
                    const Spacer(),
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
                        child: const Center(child: CircularProgressIndicator(color: mainColor)),
                      );
                    }
                    if (contextCtrl.blogList.isEmpty) {
                      return SizedBox(
                        width: Dimensions.screenWidth,
                        height: Dimensions.screenHeight - 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'No  Blogs Found',
                              style: TextStyle(color: mainColor, fontSize: Dimensions.font16 + 2, fontFamily: regular, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      );
                    }
                    return Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16),
                          ),
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: contextCtrl.blogList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return myBlogListTile(contextCtrl.blogList[index]);
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }

  myBlogListTile(BlogList list) {
    return InkWell(
      onTap: () {
        Get.to(
              () => BlogDetailsScreen(
            blogId: list.id.toString(),
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
                    child: list.image.toString().isNotEmpty
                        ? CachedNetworkImage(
                      errorWidget: (context, url, error) => Image.asset(
                        demoImg,
                        fit: BoxFit.cover,
                      ),
                      fit: BoxFit.cover,
                      imageUrl: ApiUrl.imageBaseUrl + list.image.toString(),
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
                        list.title.toString(),
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
                      const SizedBox(height: 5,),
                      Text(
                        list.shortDescription.toString(),
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
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Text(
                            "Posted : ${list.date}",
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
                    controller.blogLike(list.id.toString(), list.isBlogLike.toString() == "0" ? "1" : "0");
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: lightGry,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        list.isBlogLike.toString() == "0"
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
                          "like ${list.blogCount.toString()}",
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
                      blogId: list.id.toString(),
                      blogTitle: list.title.toString(),
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
                          "Com.${list.commentsCount.toString()}",
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
                        '\n https://play.google.com/store/apps/details?id=com.fittyus.online"');
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
                      Uri.parse("https://wa.me/${91.toString() + list.mobile.toString()}/?text=Hii...Welcome to  Fittyus App"),
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
  }
}
