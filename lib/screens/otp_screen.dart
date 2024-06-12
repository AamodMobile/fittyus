import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/login_controller.dart';
import 'package:fittyus/controller/otp_controller.dart';
import 'package:fittyus/widgets/my_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  final String countryCode;
  final String email;

  const OTPScreen({super.key, required this.phone, required this.email, required this.countryCode});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  OTPController otpController = Get.put(OTPController());
  final formKey = GlobalKey<FormState>();
  var con = Get.find<LoginController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.07, vertical: 20),
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
                            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(5), border: Border.all(color: whiteColor, width: 2)),
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
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.075),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Text(
                          widget.phone.isNotEmpty ? verifyYourPhoneNumber : verifyYourEmail,
                          style: TextStyle(color: mainColor, fontFamily: semiBold, fontStyle: FontStyle.normal, fontSize: Dimensions.font20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          widget.phone.isNotEmpty ? "$enterOTPSend ${widget.phone}" : "$enterOTPSend ${widget.email}",
                          style: TextStyle(color: lightGreyTxt, fontFamily: semiBold, fontStyle: FontStyle.normal, fontSize: Dimensions.font16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.70,
                          child: PinCodeTextField(
                            enabled: true,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            appContext: context,
                            pastedTextStyle: const TextStyle(
                              color: mainColor,
                            ),
                            length: 4,
                            obscureText: true,
                            obscuringCharacter: '*',
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 4) {
                                return "Please enter valid OTP";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 50,
                              fieldWidth: 50,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              inactiveColor: borderColorCont,
                              activeColor: mainColor,
                              selectedColor: mainColor,
                              selectedFillColor: whiteColor,
                              borderWidth: 0.5,
                              inActiveBoxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 1),
                                  color: mainColor.withOpacity(0.20),
                                  blurRadius: 15,
                                )
                              ],
                              activeBoxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 1),
                                  color: mainColor.withOpacity(0.20),
                                  blurRadius: 15,
                                )
                              ],
                            ),
                            cursorColor: Colors.black,
                            animationDuration: const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            controller: otpController.otp,
                            boxShadows: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                color: mainColor.withOpacity(0.20),
                                blurRadius: 15,
                              )
                            ],
                            keyboardType: TextInputType.number,
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: medium,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                            onCompleted: (v) {
                              otpController.otp.text = v;
                            },
                            onChanged: (value) {},
                            beforeTextPaste: (text) {
                              return true;
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (widget.phone.isNotEmpty) {
                              con.loginWithMobile();
                            } else {
                              con.loginWithEmail();
                            }
                          },
                          child: Text(
                            resendOTP,
                            style: TextStyle(color: blueCl, fontFamily: semiBold, fontStyle: FontStyle.normal, fontSize: Dimensions.font14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
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
                                if (otpController.otp.text.length < 4) {
                                  errorToast("Enter 5 digit otp");
                                } else {
                                  if (widget.phone.isNotEmpty) {
                                    otpController.otpVerifyWithMobile(widget.phone, widget.countryCode);
                                  } else {
                                    otpController.otpVerifyWithEmail(widget.email);
                                  }
                                }
                              }
                            },
                            color: whiteColor,
                            child: Text(
                              verify,
                              style: TextStyle(
                                color: pGreen,
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
                    otpImg,
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
