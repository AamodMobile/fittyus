import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/check_out_controller.dart';
import 'package:fittyus/controller/copon_list_controller.dart';
import 'package:fittyus/model/coupon_model.dart';
import 'package:fittyus/widgets/my_button.dart';
import 'package:fittyus/widgets/text_filed_widget.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  CouponListController controller = Get.put(CouponListController());
  final checkout = Get.find<CheckOutController>();

  @override
  void initState() {
    controller.isLoading = true;
    controller.coupon.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CouponListController>(),
      initState: (state) {
        Get.find<CouponListController>().getCouponListApi("coupon");
      },
      builder: (contCtr) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar: PreferredSize(
              preferredSize: Size(Dimensions.height90, MediaQuery.of(context).size.width),
              child: Container(
                height: Dimensions.height45 + Dimensions.height20,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(color: whiteColor, boxShadow: [BoxShadow(offset: Offset(0, 1), blurRadius: 15, spreadRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.2))]),
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
                      "Offers",
                      style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: false,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: whiteColor,
                          ),
                          child: Center(
                            child: ImageIcon(
                              const AssetImage(filterIc),
                              size: Dimensions.iconSize20,
                              color: mainColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 44,
                  child: MyTextFormField(
                    controller: controller.coupon,
                    hint: 'Enter Your Coupon Code',
                    fillColor: Colors.white,
                    obscureText: false,
                    readOnly: false,
                    border: dividerCl,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: Material(
                        child: SizedBox(
                          width: 90,
                          height: 44,
                          child: MyButton(
                            color: pGreen,
                            onPressed: () {
                              checkout.checkOutDetails(
                                "1",
                                controller.coupon.text,
                              );
                              Get.back();
                            },
                            child: Center(
                              child: Text(
                                "Apply Now",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: semiBold,
                                  fontSize: Dimensions.font14 - 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Builder(
                  builder: (context) {
                    if (contCtr.isLoading) {
                      return SizedBox(
                        height: Dimensions.screenHeight - 200,
                        width: Dimensions.screenWidth,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: mainColor,
                          ),
                        ),
                      );
                    }
                    if (contCtr.couponNewList.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.30,
                          ),
                          Text(
                            "Coupon",
                            style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: Dimensions.font20),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "There are no coupon here",
                            style: TextStyle(color: subPrimaryCl, fontFamily: semiBold, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                          ),
                        ],
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: contCtr.couponNewList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return myCouponListTile(contCtr.couponNewList[index]);
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  myCouponListTile(CouponModel list) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 7),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: whiteColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 7, right: 12),
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(color: const Color.fromRGBO(217, 217, 217, 1), borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Image.asset(
                        offerIc,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                  Text(
                    list.coupon.toString(),
                    style: TextStyle(color: mainColor, fontFamily: medium, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  list.title.toString(),
                  style: TextStyle(color: mainColor, fontFamily: medium, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  list.description.toString(),
                  maxLines: 3,
                  style: TextStyle(color: subPrimaryCl, fontFamily: regular, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 4),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(offset: Offset(0, 4), blurRadius: 4, spreadRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.25))],
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      list.couponType == "percentage" ? "Save ${list.save}% on this order " : "Save ₹${list.save} on this order ",
                      style: TextStyle(color: subPrimaryCl, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 12,
          right: 13,
          child: InkWell(
            onTap: () {
              checkout.checkOutDetails("1", list.coupon.toString());
              Get.back();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 7,
              ),
              decoration: BoxDecoration(color: pGreen, borderRadius: BorderRadius.circular(4)),
              height: 33,
              width: 92,
              child: Center(
                child: Text(
                  "Apply",
                  style: TextStyle(color: whiteColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font14 - 2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
