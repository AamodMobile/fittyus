import 'package:fittyus/constants/constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/cms_controller.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({super.key});

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  CmsController controller = Get.put(CmsController());
  String slug = "contact_us";

  @override
  void initState() {
    controller.fetchContactDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CmsController>(),
      initState: (state) {
        Get.find<CmsController>().isLoading = true;
        Get.find<CmsController>().content = '';
        if (Get.find<CmsController>().content.isEmpty) {
          Get.find<CmsController>().fetchPage(slug);
        }
      },
      builder: (cont) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar:  PreferredSize(
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
                      "Help & Support",
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                ),
                Image.asset(
                  helpAndSuppTopImg,
                  height: 220,
                  width: 220,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Help & Support",
                  style: TextStyle(
                      color: mainColor,
                      fontFamily: semiBold,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: Dimensions.font20),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Html(
                    data: controller.content,
                    style: {
                      "body": Style(
                        color: mainColor,
                        fontFamily: medium,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: FontSize(Dimensions.font14 - 2),
                        maxLines: 3,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await launchUrl(
                              Uri.parse(
                                  "https://wa.me/${controller.mobile}/?text=Hii... Welcome to  Fittyus App"),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: Container(
                            width: 154,
                            height: 178,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                  offset: Offset(0, 1),
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  whatsHelpIc,
                                  height: 54,
                                  width: 54,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "On Chat",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: const Color(0xFF6D6D6D),
                                      fontFamily: medium,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14 - 2),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Whatsapp",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: const Color(0xFF009806),
                                      fontFamily: semiBold,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final Uri params = Uri(
                              scheme: 'mailto',
                              path: controller.email,
                              query: 'subject=Support & body=Hi,Fittyus App',
                            );
                            await launchUrl(
                              (params),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: Container(
                            width: 154,
                            height: 178,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                  offset: Offset(0, 1),
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  emailHelpIc,
                                  height: 54,
                                  width: 54,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "On Chat",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: const Color(0xFF6D6D6D),
                                      fontFamily: medium,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14 - 2),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Email",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: const Color(0xFFFF5151),
                                      fontFamily: semiBold,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize: Dimensions.font14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
