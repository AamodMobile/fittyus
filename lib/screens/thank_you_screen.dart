import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/otp_controller.dart';
import 'package:fittyus/screens/dashboard_screenn.dart';
import 'package:fittyus/widgets/my_button.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({super.key});

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  OTPController controller = Get.put(OTPController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                thankYouBgImg,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width,),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Image.asset(
                  thankYouImg,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  '"Look out for an email confirmation that includes all the specifics of your order."',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: greenColorTxt,
                      overflow: TextOverflow.ellipsis,
                      fontFamily: medium,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: Dimensions.font14),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 49,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: MyButton(
                  color: pGreen,
                  onPressed: () {
                    Get.offAll(() => const DashBoardScreen(index: 0));
                  },
                  child: Center(
                    child: Text(
                      "Ok",
                      style: TextStyle(
                          color: whiteColor,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
