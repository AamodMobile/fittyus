import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/widgets/my_button.dart';
import 'package:fittyus/widgets/text_filed_widget.dart';
import 'package:share_plus/share_plus.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({super.key});

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {
  UserController user = Get.find<UserController>();
  TextEditingController referCode = TextEditingController();

  @override
  void initState() {
    referCode.text = user.user.value.referCode.toString();
    super.initState();
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
                  "Refer And Earn",
                  style: TextStyle(
                      color: mainColor,
                      fontFamily: semiBold,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: Dimensions.font16),
                ),
                const Spacer(),
                Visibility(
                  visible: false,
                  child: InkWell(
                      onTap: () {},
                      child:  Container(
                        height: 44,
                        width: 90,
                        margin: const EdgeInsets.only(right: 10),
                        child: MyButton(
                          onPressed: () {},
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(
                referImg,
                height: Dimensions.height90 * 1.5,
                width: Dimensions.screenWidth,
              ),
            ),
            SizedBox(
              height: Dimensions.height45,
            ),
            RichText(
                text: TextSpan(
                    text: "Invite Your Friend's Into ",
                    style: TextStyle(
                        color: mainColor,
                        fontSize: Dimensions.font16,
                        fontFamily: regular,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal),
                    children: [
                  TextSpan(
                    text: "FITTYUS ",
                    style: TextStyle(
                        color: mainColor,
                        fontSize: Dimensions.font16 + 2,
                        fontFamily: regular,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal),
                  ),
                  const TextSpan(
                    text: "Journey ! ",
                  ),
                ])),
            SizedBox(
              height: Dimensions.height10,
            ),
            Text(
              "for every friend that plays you get Rs 100  for free ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.font14 - 4,
                  fontFamily: regular,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal),
            ),
            SizedBox(
              height: Dimensions.height30 + 5,
            ),
            SizedBox(
              height: Dimensions.height30 + 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MyTextFormField(
                controller: referCode,
                hint: 'Referral Code',
                obscureText: false,
                readOnly: true,
                border: borderColorCont,
                fillColor: Colors.white,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        Clipboard.setData(
                                ClipboardData(text: referCode.text.toString()))
                            .then((result) {
                          final snackBar = SnackBar(
                            dismissDirection: DismissDirection.up,
                            content: Text(referCode.text),
                            action: SnackBarAction(
                              label: '',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      },
                      child: ImageIcon(
                        const AssetImage(copyIcon),
                        color: mainColor,
                        size: Dimensions.iconSize24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height45,
            ),
            SizedBox(
              height: Dimensions.height30 + 5,
            ),
            SizedBox(
              width: 150,
              height: 40,
              child: MyButton(
                onPressed: () async {
                  await Share.share(
                      'Fittyus App Download From Play Store Use Refer Code${referCode.text}:-'
                      '\n https://play.google.com/store/apps/details?id=com.fittyus.online"');
                },
                color: pGreen,
                child: Text(
                  "Invite friends",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: Dimensions.font16,
                      fontFamily: semiBold,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height45 + 10,
            ),
          ],
        ),
      ),
    );
  }
}
