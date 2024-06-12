import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/cms_controller.dart';
import 'package:flutter_html/flutter_html.dart';

class CMSScreen extends StatefulWidget {
  final String tittle;

  const CMSScreen({super.key, required this.tittle});

  @override
  State<CMSScreen> createState() => _CMSScreenState();
}

class _CMSScreenState extends State<CMSScreen> {
  CmsController controller = Get.put(CmsController());
  String slug = "";

  @override
  void initState() {
    if (widget.tittle =="About Us") {
      slug ="about_us";
    } else if (widget.tittle =="Privacy policy") {
      slug ="privacy_policy";
    } else {
      slug ="terms_condition";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.tittle,
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
        body: GetBuilder(
          init: Get.find<CmsController>(),
          initState: (state) {
            Get.find<CmsController>().isLoading = true;
            Get.find<CmsController>().content = '';
            if (Get.find<CmsController>().content.isEmpty) {
              Get.find<CmsController>().fetchPage(slug);
            }
          },
          builder: (context) {
            if (context.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Html(
                    data: context.content,
                    style: {
                      "body": Style(
                        fontSize: FontSize(Dimensions.font14-4),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontFamily: medium,
                        color: subPrimaryCl,
                      ),
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
