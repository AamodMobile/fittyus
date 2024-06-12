import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/login_controller.dart';
import 'package:fittyus/screens/cms_screen.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:fittyus/widgets/my_button.dart';
import 'package:fittyus/widgets/text_filed_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();
  late FirebaseMessaging messaging;
  var androidToken = "";
  var iosToken = "";

  @override
  void initState() {
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      Log.console('fcm token : $value');
      if (Platform.isAndroid) {
        androidToken = value.toString();
      } else if (Platform.isIOS) {
        iosToken = value.toString();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        body: Stack(
          children: [
            Image.asset(
              loginBg,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Image.asset(
                        transparentLogo,
                        height: MediaQuery.of(context).size.height * 0.19,
                        width: MediaQuery.of(context).size.width * 0.40,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        signInOr,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: Dimensions.font20, fontStyle: FontStyle.normal, fontFamily: semiBold, color: mainColor),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08),
                        child: Obx(
                          () => !controller.isLoginUsingPhoneNumber.value
                              ? MyTextFormField(
                                  validator: (input) {
                                    if (input!.isEmpty) {
                                      return "Enter mobile number";
                                    }
                                    return null;
                                  },
                                  controller: controller.mobile,
                                  focusNode: controller.mobileFocusNode.value,
                                  fillColor: Colors.white,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.digitsOnly],
                                  hint: enterYourMobileNo,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        child: SizedBox(
                                          width: 60,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                indiaFlag,
                                                height: 16,
                                                width: 16,
                                              ),
                                              Text(
                                                textAlign: TextAlign.center,
                                                controller.selectedCode.value,
                                                style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  obscureText: false,
                                  readOnly: false,
                                  border: mainColor,
                                )
                              : MyTextFormField(
                                  validator: (input) {
                                    if (input!.isEmpty) {
                                      return "Enter email address";
                                    }
                                    return null;
                                  },
                                  controller: controller.email,
                                  focusNode: controller.emailFocusNode.value,
                                  hint: enterYourEmail,
                                  obscureText: false,
                                  readOnly: false,
                                  fillColor: Colors.white,
                                  keyboardType: TextInputType.emailAddress,
                                  border: mainColor,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(color: pGreen),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: MyButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (!controller.isLoginUsingPhoneNumber.value) {
                                if (controller.mobile.text.length < 10) {
                                  errorToast("Please enter phone number of 10 digits.");
                                } else {
                                  controller.loginWithMobile();
                                }
                              } else {
                                if (!controller.isEmail(controller.email.text)) {
                                  errorToast("Please enter a valid email.");
                                } else {
                                  controller.loginWithEmail();
                                }
                              }
                            }
                          },
                          color: whiteColor,
                          child: Text(
                            sendOtp,
                            style: TextStyle(color: pGreen, fontFamily: medium, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, fontSize: Dimensions.font14),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.09),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: const Divider(
                                height: 1,
                                color: dividerCl,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                              child: Text(
                                "OR",
                                style: TextStyle(color: lightGreyTxt, fontSize: Dimensions.font14, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontFamily: medium),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: const Divider(
                                height: 1,
                                color: dividerCl,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          border: Border.all(color: dividerCl),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              fbIc,
                              height: Dimensions.iconSize24,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.08,
                            ),
                            Text(
                              continueWithFb,
                              style: TextStyle(color: mainColor, fontSize: Dimensions.font14, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontFamily: medium),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          border: Border.all(color: dividerCl),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              googleIc,
                              height: Dimensions.iconSize24,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.08,
                            ),
                            Text(
                              continueWithGoogle,
                              style: TextStyle(color: mainColor, fontSize: Dimensions.font14, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontFamily: medium),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          controller.isLoginUsingPhoneNumber.value = !controller.isLoginUsingPhoneNumber.value;
                          controller.mobileFocusNode.value.unfocus();
                          controller.emailFocusNode.value.unfocus();
                        },
                        child: Obx(
                          () => !controller.isLoginUsingPhoneNumber.value
                              ? Container(
                                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: dividerCl),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        emailIc,
                                        height: Dimensions.iconSize24,
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.08,
                                      ),
                                      Text(
                                        continueWithEmail,
                                        style: TextStyle(color: mainColor, fontSize: Dimensions.font14, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontFamily: medium),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: dividerCl),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone_android,
                                        size: Dimensions.iconSize24,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.08,
                                      ),
                                      Text(
                                        continueWithPhone,
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: Dimensions.font14,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: medium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      InkWell(
                        onTap: (){
                          Get.to(() => const CMSScreen(tittle: "Terms of uses"));
                        },
                        child: Text(
                          termAndCondition,
                          style: TextStyle(
                            color: mainColor,
                            fontSize: Dimensions.font14,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontFamily: semiBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
