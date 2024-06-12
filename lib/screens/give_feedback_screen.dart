import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/give_feedback_controller.dart';
import 'package:fittyus/model/my_plan_list_model.dart';
import 'package:fittyus/services/api_url.dart';
import 'package:fittyus/widgets/text_filed_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../widgets/my_button.dart';

class GiveFeedBackScreen extends StatefulWidget {
  final MyPlanListModel? coach;
  final String? id;

  const GiveFeedBackScreen({super.key,this.coach, this.id});

  @override
  State<GiveFeedBackScreen> createState() => _GiveFeedBackScreenState();
}

class _GiveFeedBackScreenState extends State<GiveFeedBackScreen> {
  final GiveFeedbackController _controller = Get.put(GiveFeedbackController());

  @override
  void initState() {
    _controller.feedbackImages.clear();
    _controller.feedbackImages.add("upload");
    _controller.feedback.text = "";
    _controller.rating.value = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        appBar:  PreferredSize(
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
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Give Feedback",
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
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(feedbackBg), fit: BoxFit.contain),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                   widget.coach!=null? Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                spreadRadius: 0,
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: widget.coach!.image != null &&
                                widget.coach!.image != ""
                                ? CachedNetworkImage(
                              errorWidget: (context, url, error) =>
                                  Image.asset(coachTopImg, fit: BoxFit.fill),
                              fit: BoxFit.fill,
                              imageUrl: ApiUrl.imageBaseUrl +
                                  widget.coach!.image.toString(),
                              placeholder: (a, b) => const Center(
                                child: CircularProgressIndicator(
                                  color: mainColor,
                                ),
                              ),
                            )
                                : Image.asset(
                              slideThree,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.coach!.name.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: semiBold,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: Dimensions.font14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.coach!.coachType.toString(),
                          style: TextStyle(
                              color: lightGreyTxt,
                              fontFamily: semiBold,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: Dimensions.font14 - 2),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ):const SizedBox(height: 120,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "How would you rate your coach",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: semiBold,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: Dimensions.font14 - 2),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 28.0,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 0.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          _controller.rating.value = rating.toString();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: MyTextFormField(
                        hint: 'Enter Comment',
                        controller: _controller.feedback,
                        obscureText: false,
                        readOnly: false,
                        border: dividerCl,
                        fillColor: whiteColor,
                        maxLines: 5,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: Obx(
                        () => Align(
                          alignment: Alignment.centerLeft,
                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _controller.feedbackImages.length,
                            reverse: true,
                            itemBuilder: (BuildContext context, int index) {
                              if (_controller.feedbackImages[index] ==
                                  "upload") {
                                return GestureDetector(
                                  onTap: () {
                                    if (_controller.feedbackImages[index] ==
                                        "upload") {
                                      _controller.selectImages().then((value) {
                                        setState(() {});
                                      });
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 9),
                                    clipBehavior: Clip.antiAlias,
                                    height: 66,
                                    width: 66,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Center(
                                      child: Image.asset(uploadImg,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                );
                              }
                              else {
                                return Container(
                                  margin: const EdgeInsets.only(left: 9),
                                  height: 66,
                                  width: 66,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.file(
                                        File(_controller
                                            .feedbackImages[index].path),
                                        fit: BoxFit.cover),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 100,
              height: 40,
              decoration: const BoxDecoration(
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0,4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Color.fromRGBO(0, 0, 0, 0.25)
                    )
                  ]
              ),
              child: MyButton(
                onPressed: () {
                  if (_controller.feedback.text != "") {
                    if (_controller.rating.value != "") {
                      if(widget.coach==null){
                        _controller.giveFeedBack(widget.id.toString());

                      }else{
                        _controller.giveFeedBack(widget.coach!.id.toString());
                      }

                    } else {
                      errorToast("Please give rating");
                    }
                  } else {
                    errorToast("Please enter feedback");
                  }
                },
                color: whiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(submitIc,height: 28,width: 28,),
                    const SizedBox(
                      width: 10
                    ),
                    Text(
                      "Submit",
                      style: TextStyle(
                          color: mainColor,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font14 - 2),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
