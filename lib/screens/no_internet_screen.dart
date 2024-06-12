import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/widgets/my_button.dart';

class NoInterNetScreen extends StatefulWidget {
  const NoInterNetScreen({super.key});

  @override
  State<NoInterNetScreen> createState() => _NoInterNetScreenState();
}

class _NoInterNetScreenState extends State<NoInterNetScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
            Image.asset(
              noInternetImg,
              height: 196,
              width: 196,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "No Internet Connection",
              style: TextStyle(
                  color: const Color.fromRGBO(28, 27, 78, 1),
                  fontFamily: semiBold,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: Dimensions.font20),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "There is no internet connection Please check your internet connection and try again",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: subPrimaryCl,
                    fontFamily: semiBold,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: Dimensions.font14),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              height: 41,
              width: 140,
              decoration: const BoxDecoration(color: whiteColor, boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: Color.fromRGBO(0, 0, 0, 0.25))
              ]),
              child: MyButton(
                color: whiteColor,
                onPressed: () async {},
                child: Center(
                  child: Text(
                    "Try again",
                    style: TextStyle(
                      color: mainColor,
                      fontSize: Dimensions.font14,
                      fontFamily: semiBold,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
