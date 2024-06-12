import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/sign_in_controller.dart';
import 'package:fittyus/widgets/text_filed_widget.dart';
import '../widgets/custom_check_box.dart';
import '../widgets/my_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInController controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.07,
                    vertical: 20,
                  ),
                  color: subPrimaryCl,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: whiteColor, width: 2)),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.075),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.09,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Text(
                        signIn,
                        style: TextStyle(
                            color: mainColor,
                            fontFamily: semiBold,
                            fontStyle: FontStyle.normal,
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        yourName,
                        style: TextStyle(
                            color: subPrimaryCl,
                            fontFamily: semiBold,
                            fontStyle: FontStyle.normal,
                            fontSize: Dimensions.font14 - 2,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.004,
                      ),
                      MyTextFormField(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 0,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: SizedBox(
                                width: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      circleUserIc,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        hint: enterYourName,
                        obscureText: false,
                        readOnly: false,
                        fillColor: whiteColor,
                        border: dividerCl,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        emailAddress,
                        style: TextStyle(
                            color: subPrimaryCl,
                            fontFamily: semiBold,
                            fontStyle: FontStyle.normal,
                            fontSize: Dimensions.font14 - 2,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.004,
                      ),
                      MyTextFormField(
                        hint: enterYourEmail,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 0,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: SizedBox(
                                width: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      mailIc,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        obscureText: false,
                        readOnly: false,
                        fillColor: whiteColor,
                        border: dividerCl,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 22,
                          child: Obx(
                            () => LabeledCheckbox(
                              value: controller.isAccept.value,
                              label: "Accept All Terms and  condition ",
                              onChanged: (value) {
                                controller.isAccept.value = value!;
                              },
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: MyButton(
                          onPressed: () {},
                          color: mainColor,
                          child: Text(
                            signIn,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontFamily: medium,
                              fontSize: Dimensions.font14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.07,
                  ),
                  child: Image.asset(
                    singInImg,
                    height: 91,
                    width: 91,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
