import 'dart:async';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/screens/dashboard_screenn.dart';
import 'package:fittyus/screens/slider_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              Image.asset(
                appLogoGif,
                height: 220,
                width: 220,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
  _navigator() async {
    Timer(
      const Duration(seconds: 5),
      () async {
        var instance = await SharedPreferences.getInstance();
        var token = instance.getString('currentToken');
        if (token != null) {
          Get.offAll(() => const DashBoardScreen(index: 0));
        } else {
          Get.off(() => const SliderScreen(),
              duration: const Duration(seconds: 5),
              transition: Transition.rightToLeft);
        }
      },
    );
  }
}
