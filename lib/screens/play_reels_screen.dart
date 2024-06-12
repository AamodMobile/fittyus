// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/controller/challenges_controller.dart';
import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:fittyus/widgets/text_filed_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../constants/constants.dart';
import '../../widgets/video_item.dart';

class PlayReelsScreen extends StatefulWidget {
  final int id;

  const PlayReelsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<PlayReelsScreen> createState() => _PlayReelsScreenState();
}

class _PlayReelsScreenState extends State<PlayReelsScreen> {
  int isLike = 0;
  int countLike = 0;
  int countView = 0;
  int id = 0;
  bool isLightTheme = true;
  ChallengesController controller = Get.find<ChallengesController>();
  UserController user =Get.put(UserController());
  TextEditingController msg = TextEditingController();
  bool isComment = true;
  var replyId = -1;
  var userName = "";
  @override
  void initState() {
    controller.likeList.clear();
    controller.commentList.clear();
    controller.getChallengeVideoApi(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ChallengesController>(),
      initState: (state) {
        Get.find<ChallengesController>()
            .getChallengeVideoApi(widget.id.toString())
            .then((value) {
          if (controller.videoModel.value.id != null) {
            id = controller.videoModel.value.id!.toInt();
          }
          if (controller.videoModel.value.isLike != null) {
            isLike = controller.videoModel.value.isLike!.toInt();
          }
          if (controller.videoModel.value.challengeLike != null) {
            countLike = controller.videoModel.value.challengeLike!.toInt();
          }
        });
      },
      builder: (contextCtrl) {
        return Scaffold(
          body: Builder(
            builder: (context) {
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

              if (contextCtrl.allChallengeList.isEmpty) {
                return SizedBox(
                  width: Dimensions.screenWidth,
                  height: Dimensions.screenHeight - 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No  Challenge Found',
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

              return Stack(
                children: [
                  VideoPlayerItem(
                    videoUrl: controller.videoModel.value.video.toString(),
                    isPaused: false,
                    videoId: id,
                  ),
                  Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        title: Text(
                          "Reel",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: semiBold,
                            fontSize: Dimensions.font14,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.width15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              height: Dimensions.height30,
                              width: Dimensions.width30,
                              child: Container(
                                height: Dimensions.height30,
                                width: Dimensions.width30,
                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: controller.videoModel.value.avatarUrl != null &&
                                              controller.videoModel.value.avatarUrl != ""
                                          ? SizedBox(
                                              height: Dimensions.height30,
                                              width: Dimensions.width30,
                                              child: ClipOval(
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: controller.videoModel.value.avatarUrl.toString(),
                                                  placeholder: (a, b) => Center(
                                                    child: Image.asset(
                                                      defaultUser,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Image.asset(
                                              defaultUser,
                                              fit: BoxFit.cover,
                                              height: Dimensions.height30,
                                              width: Dimensions.width30,
                                            ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width10,
                            ),
                            Expanded(
                              child: Text(
                                controller.videoModel.value.firstName.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: CupertinoColors.white,
                                    fontFamily: regular,
                                    fontSize: Dimensions.font14 - 2,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await controller.challengePostLike(widget.id.toString(), isLike == 0 ? "1" : "0")
                                        .then((value) {
                                      if (isLike == 0) {
                                        setState(() {
                                          isLike = 1;
                                          countLike = countLike + 1;
                                        });
                                      } else {
                                        setState(() {
                                          isLike = 0;
                                          countLike = countLike - 1;
                                        });
                                      }
                                      setState(() {});
                                    });
                                  },
                                  child: Container(
                                    height: Dimensions.height45 - 5,
                                    width: Dimensions.width45 - 5,
                                    decoration: const BoxDecoration(
                                        color: Colors.black87,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: ImageIcon(
                                        const AssetImage(likeIc),
                                        color: isLike == 0
                                            ? Colors.white
                                            : Colors.red,
                                        size: Dimensions.iconSize20,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),
                                Text(
                                  countLike.toString(),
                                  style: TextStyle(
                                      color: CupertinoColors.white,
                                      fontFamily: regular,
                                      fontSize: Dimensions.font14,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                InkWell(
                                  onTap: () {
                                    bottomSheet(context);
                                  },
                                  child: Container(
                                    height: Dimensions.height45 - 5,
                                    width: Dimensions.width45 - 5,
                                    decoration: const BoxDecoration(
                                        color: Colors.black87,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: ImageIcon(
                                        const AssetImage(commentIc),
                                        color: Colors.white,
                                        size: Dimensions.iconSize20,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),
                                Text(
                                  controller.commentCount.toString(),
                                  style: TextStyle(
                                      color: CupertinoColors.white,
                                      fontFamily: regular,
                                      fontSize: Dimensions.font14,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Container(
                                  height: Dimensions.height45 - 5,
                                  width: Dimensions.width45 - 5,
                                  decoration: const BoxDecoration(
                                      color: Colors.black87,
                                      shape: BoxShape.circle),
                                  child: Center(
                                      child: Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                    size: Dimensions.iconSize20,
                                  )),
                                ),
                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),
                                Text(
                                  "22",
                                  style: TextStyle(
                                      color: CupertinoColors.white,
                                      fontFamily: regular,
                                      fontSize: Dimensions.font14,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                ),
                                SizedBox(height: Dimensions.height45)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.height30)
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> bottomSheet(BuildContext context) {
    bool isEdit=false;
    var id="";
    void cancelReply() {
      setState(() {
        replyId = -1;
      });
    }
    return  Get.bottomSheet(
          isScrollControlled: true,
        SingleChildScrollView(
          child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isComment = !isComment;
                        });
                      },
                      child: isComment
                          ? Row(
                              children: [
                                Text(
                                  "Like",
                                  style: TextStyle(
                                    color: mainColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: semiBold,
                                    fontSize: Dimensions.font14,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: Dimensions.iconSize16,
                                  color: mainColor,
                                )
                              ],
                            )
                          : Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: Dimensions.iconSize16,
                                  color: mainColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Comment",
                                  style: TextStyle(
                                    color: mainColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: semiBold,
                                    fontSize: Dimensions.font14,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 10),
                    isComment
                        ? Builder(builder: (context) {
                            return Column(
                              children: [
                                controller.commentList.isNotEmpty
                                    ? SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.40,
                                        child:   MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child:
                                        Obx(()=>ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: controller.commentList.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Container(
                                                    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 30,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:BorderRadius.circular(20)),
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(20),
                                                                child: controller.commentList[index].image != null &&
                                                                        controller.commentList[index].image !=""
                                                                    ? SizedBox(
                                                                        height: Dimensions.height30,
                                                                        width: Dimensions.width30,
                                                                        child: ClipOval(
                                                                          child: CachedNetworkImage(
                                                                            fit: BoxFit.cover,
                                                                            imageUrl: controller.commentList[index].image.toString(),
                                                                            placeholder: (a, b) => Center(
                                                                              child: Image.asset(defaultUser,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Image.asset(
                                                                         defaultUser,
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                padding: const EdgeInsets.all(5),
                                                                decoration: const BoxDecoration(color: Colors.white),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Text(
                                                                controller.commentList[index].username!=null&&controller.commentList[index].username!=""?
                                                                            controller.commentList[index].username.toString():"New User",
                                                                            style: TextStyle(
                                                                                color: mainColor,
                                                                                fontFamily: semiBold,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: Dimensions.font14),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width: 10
                                                                        ),
                                                                        Text(DateFormat('yyyy-MM-dd').format(
                                                                            controller.commentList[index].createdAt!,),
                                                                          style: TextStyle(
                                                                            color: lightGreyTxt,
                                                                            fontFamily: regular,
                                                                            fontWeight: FontWeight.w400,
                                                                            fontStyle: FontStyle.normal,
                                                                            fontSize: Dimensions.font14 - 4,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Align(
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Text(
                                                                        controller.commentList[index].message.toString(),
                                                                        maxLines: 3,
                                                                        style: TextStyle(
                                                                          overflow: TextOverflow.ellipsis,
                                                                          color: lightGreyTxt,
                                                                          fontFamily: regular,
                                                                          fontWeight: FontWeight.w400,
                                                                          fontStyle: FontStyle.normal,
                                                                          fontSize: Dimensions.font14 - 4,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(height: 5),
                                                                    Align(
                                                                      alignment: Alignment.centerRight,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                        children: [
                                                                          user.user.value.id.toString()==controller.commentList[index].userId?
                                                                         Row(
                                                                           children: [
                                                                             InkWell(
                                                                               onTap: (){
                                                                                 tooltipPopup(context,controller.commentList[index].id.toString());
                                                                               },
                                                                                 child: const Icon(Icons.delete,color: mainColor,size: 18,)),
                                                                             const SizedBox(width: 10,),
                                                                             InkWell(
                                                                               onTap: (){
                                                                                 msg.text = controller.commentList[index].message.toString();
                                                                                 FocusScope.of(context).requestFocus(FocusNode());
                                                                                 Future.delayed(const Duration(milliseconds: 100), () {
                                                                                   FocusScope.of(context).requestFocus(FocusNode());
                                                                                   setState((){
                                                                                     isEdit=true;
                                                                                     id=controller.commentList[index].id.toString();
                                                                                   });
                                                                                 });
                                                                               },

                                                                               child:  const Icon(Icons.edit,color: mainColor,size: 18,),),
                                                                           ],
                                                                         ):const SizedBox(),
                                                                          const SizedBox(width: 10,),
                                                                      InkWell(
                                                                        onTap: (){
                                                                            FocusScope.of(context).requestFocus(FocusNode());
                                                                            Future.delayed(const Duration(milliseconds: 100), () {
                                                                              FocusScope.of(context).requestFocus(FocusNode());
                                                                              setState((){

                                                                                replyId = controller.commentList[index].id!.toInt();
                                                                                if (controller.commentList[index].username != null &&
                                                                                    controller.commentList[index].username != "") {
                                                                                  userName = "Replying to "
                                                                                      "${controller.commentList[index].username}";
                                                                                } else {
                                                                                  userName = "Replying to name";
                                                                                }
                                                                              });
                                                                            });
                                                                        },
                                                                        child: const Icon(Icons.reply_rounded,color: mainColor,size: 18,),),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(height: 10,),
                                                        controller.commentList[index].replies!.isEmpty?const SizedBox():
                                                        MediaQuery.removePadding(
                                                          context: context,
                                                          removeTop: true,
                                                          child: ListView.builder(
                                                            itemCount: controller.commentList[index].replies?.length,
                                                            shrinkWrap: true,
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            itemBuilder: (BuildContext context,int ind){
                                                            return   Container(
                                                              margin: const EdgeInsets.only(top: 5,left: 50),
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                    height: 30,
                                                                    width: 30,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:BorderRadius.circular(20)),
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(20),
                                                                      child: controller.commentList[index].replies![ind].image != null &&
                                                                          controller.commentList[index].replies![ind].image !=""
                                                                          ? SizedBox(
                                                                        height: Dimensions.height30,
                                                                        width: Dimensions.width30,
                                                                        child: ClipOval(
                                                                          child: CachedNetworkImage(
                                                                            fit: BoxFit.cover,
                                                                            imageUrl: controller.commentList[index].replies![ind].image.toString(),
                                                                            placeholder: (a, b) => Center(
                                                                              child: Image.asset(defaultUser,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                          : Image.asset(
                                                                        defaultUser,
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5
                                                                  ),
                                                                  Expanded(
                                                                    child: Container(
                                                                      padding: const EdgeInsets.all(5),
                                                                      decoration: const BoxDecoration(color: Colors.white),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Text(
                                                                                  controller.commentList[index].replies![ind].username.toString(),
                                                                                  style: TextStyle(
                                                                                      color: mainColor,
                                                                                      fontFamily: semiBold,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FontStyle.normal,
                                                                                      fontSize: Dimensions.font14),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                  width: 10
                                                                              ),
                                                                              Text(DateFormat('yyyy-MM-dd').format(
                                                                                controller.commentList[index].replies![ind].createdAt!,),
                                                                                style: TextStyle(
                                                                                  color: lightGreyTxt,
                                                                                  fontFamily: regular,
                                                                                  fontWeight: FontWeight.w400,
                                                                                  fontStyle: FontStyle.normal,
                                                                                  fontSize: Dimensions.font14 - 4,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Align(
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Text(
                                                                              controller.commentList[index].replies![ind].message.toString(),
                                                                              maxLines: 3,
                                                                              style: TextStyle(
                                                                                overflow: TextOverflow.ellipsis,
                                                                                color: lightGreyTxt,
                                                                                fontFamily: regular,
                                                                                fontWeight: FontWeight.w400,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: Dimensions.font14 - 4,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(height: 5),
                                                                          Align(
                                                                            alignment: Alignment.centerRight,
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                user.user.value.id.toString()== controller.commentList[index].replies![ind].userId.toString()?
                                                                                Row(
                                                                                  children: [
                                                                                    InkWell(
                                                                                        onTap: (){
                                                                                          tooltipPopup(context, controller.commentList[index].replies![ind].id.toString());
                                                                                        },
                                                                                        child: const Icon(Icons.delete,color: mainColor,size: 18,)),
                                                                                    const SizedBox(width: 10,),
                                                                                    InkWell(
                                                                                      onTap: (){
                                                                                        msg.text = controller.commentList[index].replies![ind].message.toString();
                                                                                        FocusScope.of(context).requestFocus(FocusNode());
                                                                                        Future.delayed(const Duration(milliseconds: 100), () {
                                                                                          FocusScope.of(context).requestFocus(FocusNode());
                                                                                          setState((){
                                                                                            isEdit=true;
                                                                                            id=controller.commentList[index].replies![ind].id.toString();
                                                                                          });
                                                                                        });
                                                                                      },

                                                                                      child:  const Icon(Icons.edit,color: mainColor,size: 18,),),
                                                                                  ],
                                                                                ):const SizedBox(),
                                                                                const SizedBox(width: 10,),
                                                                               /* InkWell(
                                                                                  onTap: (){
                                                                                    FocusScope.of(context).requestFocus(FocusNode());
                                                                                    Future.delayed(const Duration(milliseconds: 100), () {
                                                                                      FocusScope.of(context).requestFocus(FocusNode());
                                                                                      setState((){
                                                                                        replyId = controller.commentList[index].id!.toInt();
                                                                                        if (controller.commentList[index].username != null &&
                                                                                            controller.commentList[index].username != "") {
                                                                                          userName = "Replying to "
                                                                                              "${controller.commentList[index].username}";
                                                                                        } else {
                                                                                          userName = "Replying to name";
                                                                                        }
                                                                                      });
                                                                                    });
                                                                                  },
                                                                                  child: const Icon(Icons.reply_rounded,color: mainColor,size: 18,),),*/
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          ),
                                                          ),
                                                      ],
                                                    ),
                                                  );
                                          }
                                        ),
                                      )
                                ))
                                    : SizedBox(
                                        child: Text(
                                          "No Comments",
                                          style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: semiBold,
                                            fontSize: Dimensions.font14,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                              ],
                            );
                          })
                        : Builder(builder: (context) {
                            return Column(
                              children: [
                                controller.likeList.isNotEmpty
                                    ?   SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.40,
                                    child:   MediaQuery.removePadding(
                                     context: context,
                                     removeTop: true,
                                      child:ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: controller.likeList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20)),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(20),
                                                        child: controller.likeList[index].image != null &&
                                                                controller.likeList[index].image != ""
                                                            ? SizedBox(
                                                                height: Dimensions.height30,
                                                                width: Dimensions.width30,
                                                                child: ClipOval(
                                                                  child: CachedNetworkImage(
                                                                    fit: BoxFit.cover,
                                                                    imageUrl: ApiUrl.imageBaseUrl +
                                                                        controller.likeList[index].image.toString(),
                                                                    placeholder: (a, b) => Center(
                                                                      child: Image.asset(
                                                                        defaultUser,
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Image.asset(
                                                                defaultUser,
                                                                fit: BoxFit.cover,
                                                              ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        controller.likeList[index].fullName.toString(),
                                                        style: TextStyle(
                                                            color: mainColor,
                                                            fontFamily:semiBold,
                                                            fontWeight: FontWeight.w500,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: Dimensions.font14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ))
                                    : SizedBox(
                                        child: Text(
                                          "No Like Yet",
                                          style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: semiBold,
                                            fontSize: Dimensions.font14,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                              ],
                            );
                          }),
                    isComment
                        ? Column(
                      children: [
                        replyId != -1 ? Container(
                    padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: ReplyMessageWidget(
                username: userName,
                onCancelReply: (){
                  setState((){
                   cancelReply();
                  });
                },
              ),
            ): Container(), Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            height: 60,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width * 0.70,
                                  child: MyTextFormField(
                                    controller: msg,
                                    hint: 'Comment Here...',
                                    obscureText: false,
                                    readOnly: false,
                                    border: dividerCl,
                                    fillColor: whiteColor,
                                    onChanged: (v){
                                      setState((){
                                        if(v.isEmpty){
                                          FocusScope.of(context).requestFocus(FocusNode());
                                          if(isEdit==true){
                                            errorToast("Edit is cancel");
                                            isEdit=false;
                                          }else{
                                            if(replyId==-1){
                                              errorToast("comment  is cancel");
                                            }else{
                                              cancelReply();
                                              errorToast("reply  is cancel");
                                            }

                                          }

                                        }
                                      });
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      if(isEdit==true){
                                        controller.challengeCommentUpdate(id, msg.text).then((value){
                                          controller.challengeCommentList(widget.id.toString());
                                          msg.text = "";
                                          isEdit=false;
                                        });
                                      }else{
                                        if(replyId!=-1){
                                          controller.addChallengeComment(widget.id.toString(), msg.text, replyId.toString()).then((value){
                                            controller.challengeCommentList(widget.id.toString());
                                            msg.text = "";
                                            setState((){
                                              cancelReply();
                                            });
                                          });
                                        }else{
                                          controller.addChallengeComment(widget.id.toString(), msg.text, "").then((value){
                                            controller.challengeCommentList(widget.id.toString());
                                            msg.text = "";
                                          });
                                          setState((){});
                                        }
                                      }
                                      setState((){});
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width * 0.16,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Center(
                                        child: ImageIcon(
                                          AssetImage(sendBlueIc
                                          ),
                                          color: Color(0xFF1B3BA9),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ))])
                        : const SizedBox()
                  ],
                ),
              ),
            );
      },
    ),
        )
    );
  }
  Future<void> tooltipPopup(BuildContext context,String commentId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Expanded(
                  child: Text('Message',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red))),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                        "Are you sure you want to delete?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 16),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                       controller.challengeCommentDelete(commentId).then((value){
                         controller.challengeCommentList(widget.id.toString());

                       });
                       setState(() {

                       });
                      },
                      child: Container(
                          width: 85,
                          height: 40,
                          decoration: const BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Remove',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontSize: 16)),
                              ))),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 85,
                          height: 40,
                          decoration: const BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Cancel',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontSize: 16)),
                              ),
                          ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

}

class ReplyMessageWidget extends StatelessWidget {
  final String username;
  final VoidCallback onCancelReply;

  const ReplyMessageWidget({super.key,
    required this.username,
    required this.onCancelReply,
  });

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
      children: [
        Container(
          color: mainColor,
          width: 4,
        ),
        const SizedBox(width: 8),
        Expanded(child: buildReplyMessage()),
      ],
    ),
  );

  Widget buildReplyMessage() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: onCancelReply,
            child: const Icon(Icons.close, size: 16),
          )
        ],
      ),
    ],
  );


}