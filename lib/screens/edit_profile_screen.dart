import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/edit_profile_controller.dart';
import 'package:fittyus/controller/user_controller.dart';
import '../widgets/my_button.dart';
import '../widgets/text_filed_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreen();
}

class _EditProfileScreen extends State<EditProfileScreen> {
  EditProfileController controller = Get.put(EditProfileController());
  UserController user = Get.find<UserController>();

  @override
  void initState() {
    controller.image.value = File("");
    controller.firstName.text = user.user.value.firstName;
    controller.lastName.text = user.user.value.lastName;
    controller.email.text = user.user.value.email;
    controller.mobile.text = user.user.value.mobile;
    controller.country.text = user.user.value.country;
    controller.state.text = user.user.value.state;
    controller.city.text = user.user.value.city;
    controller.address.text = user.user.value.address;
    controller.occupation.text = user.user.value.occupation;
    if (user.user.value.gender == "Female") {
      controller.radioButtonItem.value = "Female";
      controller.gender = 0;
    } else if(user.user.value.gender == "Male") {
      controller.radioButtonItem.value = "Male";
      controller.gender = 1;
    }else{
      controller.radioButtonItem.value = "Other";
      controller.gender = 2;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: PreferredSize(
          preferredSize:
              Size(Dimensions.height90, MediaQuery.of(context).size.width),
          child: Container(
            height: Dimensions.height45 + Dimensions.height20,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(color: whiteColor, boxShadow: [
              BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 15,
                  spreadRadius: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.2))
            ]),
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
                  "Update Profile",
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
                      child: Container(
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
                      )),
                )
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15,),
                  /*  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "Welcome ${user.user.value.firstName} !!",
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),*/

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
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
                                              color: mainColor,
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
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Material(
                                      child: Image.asset(
                                        personIc,
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
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
                                              color: mainColor,
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
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[a-zA-Z ]"))
                                  ],
                                  fillColor: whiteColor,
                                  obscureText: false,
                                  readOnly: false,
                                  border: dividerCl,
                                  hint: "Enter Last Name",
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Material(
                                      child: Image.asset(
                                        personIc,
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
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
                                              color: mainColor,
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
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Material(
                                      child: Image.asset(
                                        mailNewIc,
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Phone Number',
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
                                              color: mainColor,
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
                                  controller: controller.mobile,
                                  hint: "Enter Mobile Number",
                                  fillColor: whiteColor,
                                  obscureText: false,
                                  readOnly: true,
                                  border: dividerCl,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Material(
                                      child: Image.asset(
                                        phoneIc,
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Occupation',
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
                                  height: 5
                                ),
                                MyTextFormField(
                                  controller: controller.occupation,
                                  hint: "Enter Occupation",
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
                                  height: 20,
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
                                            color: mainColor,
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
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Material(
                                      child: Image.asset(
                                        addressIc,
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Zip Code',
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
                                            color: mainColor,
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
                                  hint: "Enter zip code",
                                  fillColor: whiteColor,
                                  obscureText: false,
                                  readOnly: false,
                                  border: dividerCl,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Gander',
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
                                            color: mainColor,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: medium,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ]),
                                ),

                              ],
                            ),
                          ),
                        ),
const SizedBox(height: 5),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,),
                                    fillColor: MaterialStateColor
                                        .resolveWith(
                                            (states) => mainColor),
                                    activeColor: mainColor,
                                    value: 1,
                                    groupValue: controller.gender,
                                    onChanged: (val) {
                                      setState(() {
                                        controller.gender = 1;
                                        controller.radioButtonItem
                                            .value = "Male";
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "Male",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: medium,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    visualDensity:  const VisualDensity(horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,),
                                    fillColor:
                                    MaterialStateColor.resolveWith(
                                            (states) => mainColor),
                                    activeColor: mainColor,
                                    value: 0,
                                    groupValue: controller.gender,
                                    onChanged: (val) {
                                      setState(() {
                                        controller.gender = 0;
                                        controller.radioButtonItem
                                            .value = "Female";
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "Female",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: medium,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,),
                                    fillColor:
                                    MaterialStateColor.resolveWith((states) => mainColor),
                                    activeColor: mainColor,
                                    value: 2,
                                    groupValue: controller.gender,
                                    onChanged: (val) {
                                      setState(() {
                                        controller.gender = 2;
                                        controller.radioButtonItem
                                            .value = "Other";
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "Rather Not Say",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: medium,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20
                        ),
                        Obx(
                              () => GestureDetector(
                            onTap: () {
                              controller.pickImage(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 22),
                              height: 136,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: controller.image.value.path.isEmpty
                                    ? (user.user.value.avatarUrl.isNotEmpty)
                                    ? CachedNetworkImage(
                                      errorWidget:
                                          (context, url, error) =>
                                          Image.asset(
                                            uploadProfileBg,
                                            fit: BoxFit.cover,
                                          ),
                                      fit: BoxFit.cover,
                                      height: Dimensions.height90,
                                      width: Dimensions.width90,
                                      imageUrl: user
                                          .user.value.avatarUrl
                                          .toString(),
                                      placeholder: (a, b) =>
                                      const Center(
                                        child:
                                        CircularProgressIndicator(
                                          color: pGreen,
                                        ),
                                      ),
                                    )
                                    : Image.asset(
                                  uploadProfileBg,
                                  fit: BoxFit.fill,
                                )
                                    : Image.file(
                                  controller.image.value,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          height: 49,
                          width: MediaQuery.of(context).size.width,
                          child: MyButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              controller.editProfileApi();
                            },
                            color: pGreen,
                            child: Text(
                              'Save',
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
                        const SizedBox(height: 20),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
