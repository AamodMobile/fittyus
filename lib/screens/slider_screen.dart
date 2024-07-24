import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/slider_controller.dart';
import 'package:fittyus/screens/login_screen.dart';
import 'package:fittyus/widgets/my_button.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<StatefulWidget> createState() => SliderScreenState();
}

class SliderScreenState extends State<SliderScreen> {
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  SliderController con = Get.put(SliderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildPageView(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Obx(() => con.currentPage.value == 0
                ? Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.075),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: [
                          BoxShadow(
                            color: mainColor.withOpacity(0.25),
                            offset: const Offset(0, 0),
                            blurRadius: 10,
                            spreadRadius: 0,
                          ),
                        ]),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Fitness Redefined",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.font14,
                              fontStyle: FontStyle.normal,
                              fontFamily: semiBold,
                              color: greenColorTxt),
                          children: [
                            TextSpan(
                              text: "\nfor You",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: Dimensions.font14,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: medium,
                                  color: mainColor),
                            )
                          ],
                        ),
                      ),
                    ))
                : con.currentPage.value == 1
                    ? Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.075),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.height * 0.20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11),
                            boxShadow: [
                              BoxShadow(
                                color: mainColor.withOpacity(0.25),
                                offset: const Offset(0, 0),
                                blurRadius: 10,
                                spreadRadius: 0,
                              ),
                            ]),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            certifiedTrainers,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Dimensions.font16,
                                fontStyle: FontStyle.normal,
                                fontFamily: semiBold,
                                color: mainColor),
                          ),
                        ),
                      )
                    : const SizedBox()),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => Text(
                        textAlign: TextAlign.center,
                        con.currentPage.value == 0
                            ? slideOneText
                            : con.currentPage.value == 1
                                ? slideTwoText
                                : sliderThreeText,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Dimensions.font16,
                            fontStyle: FontStyle.normal,
                            fontFamily: semiBold,
                            color: mainColor),
                      )),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              con.images.length,
                              (ind) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                padding: const EdgeInsets.all(5),
                                height: 10,
                                width: ind == con.currentPage.value ? 29 : 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: ind == con.currentPage.value
                                      ? mainColor
                                      : const Color(0xFFD9D9D9),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: Dimensions.height45,
                        width: Dimensions.width90 + Dimensions.width10,
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
                            Get.to(() => const LoginScreen());
                          },
                          color: whiteColor,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "SKIP",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color:pGreen,
                                    fontSize: Dimensions.font14 - 2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const ImageIcon(
                                  AssetImage(
                                    arrowRight,
                                  ),
                                  color: pGreen,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      itemCount: con.totalPages.value,
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 1.0;
            if (_pageController.position.haveDimensions) {
              value = _pageController.page! - index;
              value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
            }
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0.0, 100 * (1 - value)),
                // Adjust the offset as needed
                child: child,
              ),
            );
          },
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: Image.asset(
                con.images[index],
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
      onPageChanged: (int index) {
        _currentPageNotifier.value = index;
        con.currentPage.value = index;
      },
    );
  }
}
