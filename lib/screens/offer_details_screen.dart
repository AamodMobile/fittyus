import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/model/coupan_list_new.dart';
import 'package:fittyus/services/api_url.dart';

class OfferDetailsScreen extends StatefulWidget {
  final CouponModelNew model;

  const OfferDetailsScreen({super.key, required this.model});

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
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
                  widget.model.couponName.toString(),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.model.couponName.toString(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: mainColor,
                  fontFamily: semiBold,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: Dimensions.font16,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: widget.model.image.toString().isNotEmpty
                    ? CachedNetworkImage(
                        errorWidget: (context, url, error) => Image.asset(
                          coachTopImg,
                          fit: BoxFit.fill,
                        ),
                        fit: BoxFit.fill,
                        imageUrl: ApiUrl.imageBaseUrl +
                            widget.model.image.toString(),
                        placeholder: (a, b) => const Center(
                          child: CircularProgressIndicator(
                            color: mainColor,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage(coachTopImg), fit: BoxFit.fill),
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Coupon Code",
                style: TextStyle(
                  fontSize: Dimensions.font14,
                  color: mainColor,
                  fontFamily: medium,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            const SizedBox(
              height: 10
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: widget.model.couponCode.toString()))
                      .then((result) {
                    final snackBar = SnackBar(
                      dismissDirection: DismissDirection.up,
                      content: Text(widget.model.couponName.toString()),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(right: 5),
                  height: 100,
                  width: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(selectPlanImg), fit: BoxFit.fill),
                  ),
                  child: Center(
                    child: Text(
                      widget.model.couponName.toString(),
                      style: TextStyle(
                        fontSize: Dimensions.font14,
                        color: mainColor,
                        fontFamily: medium,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Text(
                widget.model.description.toString(),
                style: TextStyle(
                  fontSize: Dimensions.font14,
                  color: mainColor,
                  fontFamily: medium,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
