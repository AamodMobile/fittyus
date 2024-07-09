import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/category_list_controller.dart';
import 'package:fittyus/model/home_model.dart';
import 'package:fittyus/screens/coaches_list_screen.dart';
import 'package:fittyus/services/api_url.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryListController controller = Get.put(CategoryListController());

  @override
  void initState() {
    controller.categoryList.clear();
    controller.isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CategoryListController>(),
      initState: (state) {
        Get.find<CategoryListController>().getCategoryListApi();
      },
      builder: (contextCtrl) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar: PreferredSize(
              preferredSize: Size(Dimensions.height90, MediaQuery.of(context).size.width),
              child: Container(
                height: Dimensions.height45 + Dimensions.height20,
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      "Category",
                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Builder(builder: (context) {
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

                  if (contextCtrl.categoryList.isEmpty) {
                    return SizedBox(
                      width: Dimensions.screenWidth,
                      height: Dimensions.screenHeight - 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'No  Category Found',
                            style: TextStyle(color: mainColor, fontSize: Dimensions.font16 + 2, fontFamily: regular, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  }
                  return Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      shrinkWrap: true,
                      itemCount: contextCtrl.categoryList.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, mainAxisExtent: 100, childAspectRatio: (200 / 100), crossAxisSpacing: 7, mainAxisSpacing: 4),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () {
                              if (controller.city.value == "") {
                                controller.getCurrentPosition();
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
                                            child: contextCtrl.categoryList[index].image != null && contextCtrl.categoryList[index].image != ""
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
                                          style: TextStyle(color: mainColor, fontSize: Dimensions.font14 - 2, fontWeight: FontWeight.w500, fontFamily: medium),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ));
                      },
                    ),
                  );
                })
              ],
            ),
          ),
        );
      },
    );
  }

  myCategoryListTile(Category list) {
    return InkWell(
      onTap: () {
        Get.to(() => CoachesListScreen(
              categoryId: list.id.toString(),
              city: '',
            ));
      },
      child: Container(
        decoration: BoxDecoration(image: const DecorationImage(image: AssetImage(bannerImg), fit: BoxFit.cover), borderRadius: BorderRadius.circular(6)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(16, 17, 16, 0.7),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              list.title.toString(),
              textAlign: TextAlign.start,
              style: TextStyle(color: whiteColor, fontSize: Dimensions.font14 - 2, fontWeight: FontWeight.w500, fontFamily: semiBold),
            ),
          ),
        ),
      ),
    );
  }
}
