// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:fittyus/widgets/my_button.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../controller/challenges_controller.dart';

class AddChallengePostScreen extends StatefulWidget {
  final String id;

  const AddChallengePostScreen({super.key, required this.id});

  @override
  State<AddChallengePostScreen> createState() => _AddChallengePostScreenState();
}

class _AddChallengePostScreenState extends State<AddChallengePostScreen> {
  ChallengesController cont = Get.put(ChallengesController());
  File? image;
  bool isSelect = false;
  bool isVideo = false;
  VideoPlayerController? controller;
  var thumbPath;

  @override
  void initState() {
    isSelect = false;
    cont.addPostDes.clear();
    super.initState();
  }

/* void _videoControllerListener() {
    setState(() {});
  }*/

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void pickVideo(BuildContext context) async {
    var result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      allowMultiple: false,
      dialogTitle: 'Select a Videos',
      type: FileType.video,
    );
    if (result != null) {
      var files = result.files;
      var file = files[0];
      int size = bytesToMB(file.size);
      if (size > 5) {
        errorToast("Video size should be less then 5mb");
      } else {
        image = File(file.path!);
        isSelect = true;
        isVideo = true;
        _initVideo();
        thumbPath = await _getImage(file.path!);
        Log.console("Thumbnail path: $thumbPath");
        setState(() {});
      }
    }
  }

  Future<String?> _getImage(String videoUrl) async {
    //await Future.delayed(Duration(milliseconds: 500));
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 1000,
      maxHeight: 1000,

      //this image will store in created folderpath
    );
    return thumbnailPath;
  }

  int bytesToMB(int bytes) {
    if (bytes == 0) return 0;
    return (bytes / math.pow(1024, 2)).ceil();
  }

  void _initVideo() async {
    /* if (controller != null) {
      controller!.removeListener(_videoControllerListener);
    }*/

    if (image != null && isSelect == true) {
      controller = VideoPlayerController.file(File(image!.path));

      await controller!.initialize();
      //controller!.addListener(_videoControllerListener);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  "Add Challenge Post",
                  style: TextStyle(
                      color: mainColor,
                      fontFamily: semiBold,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: Dimensions.font16),
                ),
                const Spacer(),
                Visibility(
                  visible: true,
                  child: InkWell(
                      onTap: () {},
                      child:  Container(
                        height: 34,
                        width: 70,
                        margin: const EdgeInsets.only(right: 10),
                        child: MyButton(
                          onPressed: () {
                            if (cont.addPostDes.text == "") {
                              errorToast("Enter Something About challenge");
                            } else {
                              if (image == File("") || image == null) {
                                errorToast("Add video for challenge");
                              } else {
                                cont.postChallenge(widget.id, thumbPath, image?.path);
                              }
                            }
                          },
                          color: pGreen,
                          child: Center(
                            child: Text(
                              "Post",
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
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              width: MediaQuery.of(context).size.width,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(237, 246, 255, 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We'll post this as story in your accountability groups",
                    style: TextStyle(
                        color: mainColor,
                        fontFamily: medium,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: Dimensions.font14 - 2),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Only people from your groups will be able to see your story",
                    style: TextStyle(
                        color: greyColorTxt,
                        fontFamily: medium,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: Dimensions.font14 - 4),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                pickVideo(context);
              },
              child: isVideo == false
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color.fromRGBO(
                            235,
                            237,
                            240,
                            1,
                          )),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(207, 210, 217, 0.3),
                              spreadRadius: 0.0,
                              blurRadius: 50,
                              offset:
                                  Offset(0, 4.0), // changes position of shadow
                            ),
                          ]),
                      child: Row(
                        children: [
                          Image.asset(
                            imageIc,
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Video",
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: Dimensions.font14,
                                    fontFamily: semiBold,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal),
                              ),
                              Text(
                                "MP4,MOV",
                                style: TextStyle(
                                    color: greyColorTxt,
                                    fontSize: Dimensions.font14 - 4,
                                    fontFamily: medium,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: Dimensions.iconSize24,
                          )
                        ],
                      ))
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color.fromRGBO(
                            235,
                            237,
                            240,
                            1,
                          )),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(207, 210, 217, 0.3),
                              spreadRadius: 0.0,
                              blurRadius: 50,
                              offset:
                                  Offset(0, 4.0), // changes position of shadow
                            ),
                          ]),
                      height: 200,
                      child: video()),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color.fromRGBO(
                      235,
                      237,
                      240,
                      1,
                    ),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(207, 210, 217, 0.3),
                      spreadRadius: 0.0,
                      blurRadius: 50,
                      offset: Offset(0, 4.0), // changes position of shadow
                    ),
                  ]),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextFormField(
                  controller: cont.addPostDes,
                  cursorColor: mainColor,
                  cursorHeight: 18,
                  decoration: InputDecoration(
                    hintText: "Write something here",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    hintStyle: TextStyle(
                        color: greyColorTxt,
                        fontSize: Dimensions.font14 - 2,
                        fontFamily: medium,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal),
                    fillColor: whiteColor,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget video() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: controller!.value.aspectRatio,
            child: VideoPlayer(controller!),
          ),
        ),
        Center(
          child: InkWell(
            onTap: () async {
              if (controller != null && controller!.value.isInitialized) {
                if (controller!.value.isPlaying) {
                  await controller!.pause();
                } else {
                  await controller!.play();
                }
                setState(() {});
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
