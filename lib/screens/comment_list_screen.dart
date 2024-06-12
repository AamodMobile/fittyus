import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/blog_comment_list_controller.dart';
import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/model/comment_model.dart';
import 'package:fittyus/widgets/my_button.dart';
import 'package:intl/intl.dart';
import '../widgets/text_filed_widget.dart';

class CommentListScreen extends StatefulWidget {
  final String blogId;
  final String blogTitle;

  const CommentListScreen({super.key, required this.blogId, required this.blogTitle});

  @override
  State<CommentListScreen> createState() => _CommentListScreenState();
}

class _CommentListScreenState extends State<CommentListScreen> {
  BlogCommentListController controller = Get.put(BlogCommentListController());
  UserController user = Get.put(UserController());

  @override
  void initState() {
    controller.isLoading = true;
    controller.commentController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<BlogCommentListController>(),
      initState: (state) {
        Get.find<BlogCommentListController>().getBlogCommentListApi(widget.blogId);
      },
      builder: (contextCtrl) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: bgCommunityItems,
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
                      "Comments",
                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          child: Text(
                            widget.blogTitle,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: Dimensions.font14, color: mainColor, fontFamily: semiBold, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Text("Comment (${controller.totalComment.value}) ",
                              textAlign: TextAlign.start, style: TextStyle(fontSize: Dimensions.font14, color: subPrimaryCl, fontWeight: FontWeight.w500)),
                        ),
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

                          if (contextCtrl.commentList.isEmpty) {
                            return SizedBox(
                              width: Dimensions.screenWidth,
                              height: Dimensions.screenHeight - 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'No Comments',
                                    style: TextStyle(color: mainColor, fontSize: Dimensions.font16, fontFamily: regular, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            );
                          }
                          return MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: contextCtrl.commentList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return myCommentListTile(contextCtrl.commentList[index]);
                                }),
                          );
                        }),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomSheet: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: MyTextFormField(
                        controller: controller.commentController,
                        hint: 'Comment Here...',
                        obscureText: false,
                        readOnly: false,
                        border: dividerCl,
                        fillColor: whiteColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.commentController.text == "") {
                          errorToast("Add Comment");
                        } else {
                          FocusManager.instance.primaryFocus?.unfocus();
                          controller.addCommentApi(widget.blogId, controller.commentController.text, "",false);
                        }
                      },
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: ImageIcon(
                              AssetImage(
                                sendBlueIc,
                              ),
                              color: Color(0xFF1B3BA9),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  Widget myCommentListTile(CommentModel list) {
    var create = formatDate(list.createdAt.toString());
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: list.image.toString().isNotEmpty
                      ? CachedNetworkImage(
                          errorWidget: (context, url, error) => Image.asset(
                            demoImg,
                            fit: BoxFit.cover,
                          ),
                          fit: BoxFit.cover,
                          imageUrl: list.image.toString(),
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
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            list.username != null && list.username != "" ? list.username.toString() : "Name",
                            style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                          ),
                          Text(
                            create,
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
                      Text(
                        list.message.toString(),
                        maxLines: 3,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: lightGreyTxt,
                          fontFamily: regular,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font14 - 2,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            user.user.value.id.toString() == list.userId.toString()
                                ? Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            tooltipPopup(context, list.id.toString());
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: mainColor,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(width: 10),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    controller.likeCommentApi(widget.blogId, list.id.toString(), list.like.toString() == "0" ? "1" : "0").then((value) {
                      controller.getBlogCommentListApi(widget.blogId);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        list.like.toString() == "0"
                            ? Image.asset(
                                heartIc,
                                height: 16,
                                width: 16,
                              )
                            : Image.asset(
                                heartPinkIc,
                                height: 16,
                                width: 16,
                              ),
                        const SizedBox(width: 4),
                        Text(
                          "like",
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: mainColor,
                            fontFamily: regular,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: Dimensions.font14 - 4,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              contentPadding: EdgeInsets.zero,
                              content: Wrap(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Reply on Comment ",
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                controller.replyComment.text = "";
                                                Get.back();
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                size: 26,
                                                color: greyColorTxt,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(
                                          height: 1,
                                          color: greyColorTxt,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Reply:",
                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          child: MyTextFormField(
                                            readOnly: false,
                                            maxLines: 1,
                                            controller: controller.replyComment,
                                            validator: (input) {
                                              if (input!.isEmpty) {
                                                return "Enter  Comment";
                                              }
                                              return null;
                                            },
                                            hint: "Enter reply Comment",
                                            obscureText: false,
                                            fillColor: Colors.white,
                                            border: grayNew,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              width: 90,
                                              child: MyButton(
                                                  onPressed: () {
                                                    if (controller.replyComment.text != "") {
                                                      controller.addCommentApi(widget.blogId.toString(), controller.replyComment.text, list.id.toString(),true).then((value) {
                                                        controller.replyComment.text = "";
                                                      });
                                                    } else {
                                                      errorToast("add reply");
                                                    }
                                                  },
                                                  color: greenColor,
                                                  child: Text(
                                                    "Reply",
                                                    style:
                                                        TextStyle(color: Colors.white, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              width: 90,
                                              child: MyButton(
                                                  onPressed: () {
                                                    controller.replyComment.text = "";
                                                    Get.back();
                                                  },
                                                  color: redColor,
                                                  child: Text(
                                                    "Cancel",
                                                    style:
                                                        TextStyle(color: Colors.white, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    "Reply",
                    maxLines: 2,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: mainColor,
                      fontFamily: regular,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: Dimensions.font14 - 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          list.replies!.isEmpty
              ? const SizedBox()
              : MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    itemCount: list.replies?.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int ind) {
                      return Container(
                        margin: const EdgeInsets.only(top: 5, left: 50),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: list.replies![ind].image != null && list.replies![ind].image != ""
                                    ? SizedBox(
                                        height: Dimensions.height30,
                                        width: Dimensions.width30,
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: list.replies![ind].image.toString(),
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
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(color: grayNew),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            list.replies![ind].username!="" && list.replies![ind].username!=null?
                                            list.replies![ind].username.toString():"User",
                                            style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          DateFormat('yyyy-MM-dd').format(
                                            list.replies![ind].createdAt!,
                                          ),
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
                                        list.replies![ind].message.toString(),
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
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          user.user.value.id.toString() == list.replies![ind].userId.toString()
                                              ? Row(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          tooltipPopup(context, list.replies![ind].id.toString());
                                                        },
                                                        child: const Icon(
                                                          Icons.delete,
                                                          color: mainColor,
                                                          size: 18,
                                                        )),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                          const SizedBox(
                                            width: 10,
                                          ),
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

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  Future<void> tooltipPopup(BuildContext context, String commentId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Expanded(child: Text('Message', textAlign: TextAlign.center, style: TextStyle(color: Colors.red))),
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
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 16),
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
                        controller.deleteCommentApi(commentId).then((value) {
                          controller.getBlogCommentListApi(widget.blogId.toString());
                        });
                        setState(() {});
                      },
                      child: Container(
                          width: 85,
                          height: 40,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Remove', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16)),
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
