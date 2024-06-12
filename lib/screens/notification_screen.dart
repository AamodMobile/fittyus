import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/notification_list_controller.dart';
import 'package:fittyus/model/notification_model.dart';
import 'package:fittyus/services/api_url.dart';

import '../widgets/my_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationListController controller = Get.put(NotificationListController());

  @override
  void initState() {
    controller.notificationList.clear();
    controller.isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<NotificationListController>(),
      initState: (state) {
        Get.find<NotificationListController>().getNotificationListApi();
      },
      builder: (contextCtrl) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar:  PreferredSize(
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
                      "Notification",
                      style: TextStyle(
                          color: mainColor,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font16),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: controller.notificationList.isEmpty?false:true,
                      child: InkWell(
                        onTap: () {},
                        child:  Container(
                          height: 44,
                          width: 90,
                          margin: const EdgeInsets.only(right: 10),
                          child: MyButton(
                            onPressed: () {
                              controller.getNotificationListClearApi();
                            },
                            color: pGreen,
                            child: Center(
                              child: Text(
                                "Clear All",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontFamily: semiBold,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: Dimensions.font14 - 2),
                              ),
                            ),
                          ),
                        )
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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

                  if (contextCtrl.notificationList.isEmpty) {
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
                          "Notification",
                          style: TextStyle(
                              color: mainColor,
                              fontFamily: semiBold,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: Dimensions.font20),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "There are no notification here",
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
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: contextCtrl.notificationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return myNotificationListTile(contextCtrl.notificationList[index]);

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

  myNotificationListTile(NotificationModel list) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.only(top: 14, right: 14, left: 14, bottom: 11),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: whiteColor,
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(255, 255, 255, 1),  // Border color
            width: 1,  // Border width
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),  // Shadow position (X, Y)
            blurRadius: 4,  // Blur radius
            spreadRadius: 0,  // Spread radius
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  list.title.toString(),
                  maxLines: 1,
                  style: TextStyle(
                      color: mainColor,
                      overflow: TextOverflow.ellipsis,
                      fontFamily: semiBold,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: Dimensions.font14),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  list.description.toString(),
                  maxLines: 4,
                  style: TextStyle(
                      color: subPrimaryCl,
                      overflow: TextOverflow.ellipsis,
                      fontFamily: medium,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: Dimensions.font14 - 4),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  list.date.toString(),
                  maxLines: 1,
                  style: TextStyle(
                      color: subPrimaryCl,
                      overflow: TextOverflow.ellipsis,
                      fontFamily: semiBold,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: Dimensions.font14 - 4),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: list.image!.isNotEmpty
                  ? CachedNetworkImage(
                      errorWidget: (context, url, error) => const SizedBox(),
                      fit: BoxFit.cover,
                      imageUrl: ApiUrl.imageBaseUrl + list.image.toString(),
                      placeholder: (a, b) => const Center(
                        child: CircularProgressIndicator(
                          color: mainColor,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
