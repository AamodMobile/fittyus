// ignore_for_file: must_be_immutable

import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/check_out_controller.dart';
import 'package:fittyus/controller/user_controller.dart';
import 'package:fittyus/model/address_list_model.dart';
import 'package:fittyus/widgets/my_button.dart';
import 'package:fittyus/widgets/text_filed_widget.dart';

class BillingDetailsScreen extends StatefulWidget {
  final bool isEdit;
  AddressList? addressList;

  BillingDetailsScreen({super.key, required this.isEdit, this.addressList});

  @override
  State<BillingDetailsScreen> createState() => _BillingDetailsScreenState();
}

class _BillingDetailsScreenState extends State<BillingDetailsScreen> {
  CheckOutController controller = Get.put(CheckOutController());
  String strName = "";
  final formKey = GlobalKey<FormState>();
  UserController user = Get.find<UserController>();

  @override
  void initState() {
    if (widget.isEdit) {
      controller.firstName.text = widget.addressList!.firstName.toString();
      controller.lastName.text = widget.addressList!.lastName.toString();
      controller.email.text = widget.addressList!.email.toString();
      controller.mobile.text = widget.addressList!.mobile.toString();
      controller.country.text = widget.addressList!.country.toString();
      controller.state.text = widget.addressList!.state.toString();
      controller.city.text = widget.addressList!.city.toString();
      controller.address.text = widget.addressList!.address.toString();
    } else {
      controller.firstName.text = "";
      controller.lastName.text = "";
      controller.email.text = "";
      controller.mobile.text = "";
      controller.country.text = "";
      controller.state.text = "";
      controller.city.text = "";
      controller.address.text = "";
    }
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
                  "Billing Address",
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

        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Welcome ${user.user.value.firstName} !!",
                          style: TextStyle(
                            fontSize: Dimensions.font20,
                            color: mainColor,
                            fontStyle: FontStyle.normal,
                            fontFamily: semiBold,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 15),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'First Name',
                                        style: TextStyle(
                                            fontSize: Dimensions.font14,
                                            color: mainColor,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: medium,
                                            fontWeight: FontWeight.w500),
                                        children: [
                                          TextSpan(
                                              text: ' *',
                                              style: TextStyle(
                                                fontSize: Dimensions.font14 - 2,
                                                color: redColor,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: medium,
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  MyTextFormField(
                                    controller: controller.firstName,
                                    hint: "Enter First Name",
                                    fillColor: whiteColor,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp("[a-zA-Z ]"),
                                      ),
                                    ],
                                    obscureText: false,
                                    readOnly: false,
                                    border: dividerCl,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Last Name',
                                        style: TextStyle(
                                            fontSize: Dimensions.font14,
                                            color: mainColor,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: medium,
                                            fontWeight: FontWeight.w500),
                                        children: [
                                          TextSpan(
                                              text: ' *',
                                              style: TextStyle(
                                                fontSize: Dimensions.font14 - 2,
                                                color: redColor,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: medium,
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  MyTextFormField(
                                    controller: controller.lastName,
                                    hint: "Enter Last Name",
                                    fillColor: whiteColor,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp("[a-zA-Z ]"),
                                      ),
                                    ],
                                    obscureText: false,
                                    readOnly: false,
                                    border: dividerCl,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Email',
                                        style: TextStyle(
                                            fontSize: Dimensions.font14,
                                            color: mainColor,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: medium,
                                            fontWeight: FontWeight.w500),
                                        children: [
                                          TextSpan(
                                              text: ' *',
                                              style: TextStyle(
                                                fontSize: Dimensions.font14 - 2,
                                                color: redColor,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: medium,
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  MyTextFormField(
                                    controller: controller.email,
                                    hint: "Enter Email Address",
                                    fillColor: whiteColor,
                                    obscureText: false,
                                    readOnly: false,
                                    border: dividerCl,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Mobile Number',
                                        style: TextStyle(
                                            fontSize: Dimensions.font14,
                                            color: mainColor,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: medium,
                                            fontWeight: FontWeight.w500),
                                        children: [
                                          TextSpan(
                                              text: ' *',
                                              style: TextStyle(
                                                fontSize: Dimensions.font14 - 2,
                                                color: redColor,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: medium,
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: const Text(
                                          textAlign: TextAlign.center,
                                          "91",
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        onTap: () {},
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: MyTextFormField(
                                          controller: controller.mobile,
                                          hint: "Enter Mobile Number",
                                          fillColor: whiteColor,
                                          obscureText: false,
                                          readOnly: false,
                                          border: dividerCl,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                            LengthLimitingTextInputFormatter(10),
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Country Name',
                                        style: TextStyle(
                                            fontSize: Dimensions.font14,
                                            color: mainColor,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: medium,
                                            fontWeight: FontWeight.w500),
                                        children: [
                                          TextSpan(
                                              text: ' *',
                                              style: TextStyle(
                                                fontSize: Dimensions.font14 - 2,
                                                color: redColor,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: medium,
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  MyTextFormField(
                                    controller: controller.country,
                                    hint: "Enter Country Name",
                                    fillColor: whiteColor,
                                    obscureText: false,
                                    readOnly: false,
                                    border: dividerCl,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[a-zA-Z ]"))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'State Name',
                                        style: TextStyle(
                                            fontSize: Dimensions.font14,
                                            color: mainColor,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: medium,
                                            fontWeight: FontWeight.w500),
                                        children: [
                                          TextSpan(
                                              text: ' *',
                                              style: TextStyle(
                                                fontSize: Dimensions.font14 - 2,
                                                color: redColor,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: medium,
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  MyTextFormField(
                                    controller: controller.state,
                                    hint: "Enter State Name",
                                    fillColor: whiteColor,
                                    obscureText: false,
                                    readOnly: false,
                                    border: dividerCl,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[a-zA-Z ]"))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'City Name',
                                        style: TextStyle(
                                            fontSize: Dimensions.font14,
                                            color: mainColor,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: medium,
                                            fontWeight: FontWeight.w500),
                                        children: [
                                          TextSpan(
                                              text: ' *',
                                              style: TextStyle(
                                                fontSize: Dimensions.font14 - 2,
                                                color: redColor,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: medium,
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  MyTextFormField(
                                    controller: controller.city,
                                    hint: "Enter City Name",
                                    fillColor: whiteColor,
                                    obscureText: false,
                                    readOnly: false,
                                    border: dividerCl,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[a-zA-Z ]"))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Address',
                                        style: TextStyle(
                                            fontSize: Dimensions.font14,
                                            color: mainColor,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: medium,
                                            fontWeight: FontWeight.w500),
                                        children: [
                                          TextSpan(
                                            text: ' *',
                                            style: TextStyle(
                                              fontSize: Dimensions.font14 - 2,
                                              color: redColor,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: medium,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  MyTextFormField(
                                    controller: controller.address,
                                    hint: "Enter Address",
                                    fillColor: whiteColor,
                                    obscureText: false,
                                    readOnly: false,
                                    border: dividerCl,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 25),
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: MyButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (widget.isEdit) {
                                      controller.updateAddress(
                                          widget.addressList!.id.toString());
                                    } else {
                                      controller.saveAddress();
                                    }
                                  }
                                },
                                color: pGreen,
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                    fontSize: Dimensions.font16,
                                    color: whiteColor,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: medium,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
