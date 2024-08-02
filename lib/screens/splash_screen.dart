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

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3100),
    )..addListener(() {
        setState(() {});
      });

    _animationController.forward();
    _navigator();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
              Image.asset(
                appNewLogo,
                height: 120,
                width: 240,
                fit: BoxFit.cover,
              ),
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: mainColor),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 55),
                child: LinearProgressIndicator(
                  value: _animationController.value,
                  color: mainColor,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "TRAIN SMART-TRAIN ONLINE",
                style: TextStyle(
                  color: mainColor,
                  fontFamily: semiBold,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: Dimensions.font14 - 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigator() async {
    Timer(
      const Duration(milliseconds: 4200),
      () async {
        var instance = await SharedPreferences.getInstance();
        var token = instance.getString('currentToken');
        if (token != null) {
          Get.offAll(() => const DashBoardScreen(index: 0));
        } else {
          Get.off(() => const SliderScreen(), duration: const Duration(seconds: 1), transition: Transition.rightToLeft);
        }
      },
    );
  }
}
