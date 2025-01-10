import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitchgo/ground_list/ground_list.dart';
import 'package:pitchgo/login_screen/login_screen.dart';
import 'package:pitchgo/resource/utils.dart';

import '../app_constant/app_color.dart';
import '../common_widget/common_botton.dart';
import '../common_widget/common_pasword_field.dart';
import '../common_widget/common_text.dart';
import '../common_widget/common_text_field.dart';
import '../controller/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final controller = Get.put(SignupController());
    return Scaffold(
      backgroundColor: AppColors.whiteFFFFFF,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4, left: 15),
              child: Row(
                children: [
                  Image.asset('assets/images/l_icon_1.png',
                      width: 20, height: 20),
                  const SizedBox(
                    width: 110,
                  ),
                  commonText(
                      text: 'Signup',
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Container(
                        width: w,
                        margin:
                            EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                        alignment: Alignment.centerLeft,
                        child: commonText(
                            text: "Your name", color: AppColors.black050F2B)),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    CommonTextField(
                        controller: controller.name,
                        text: 'Input your first name'),
                    const SizedBox(
                      height: 17,
                    ),
                    Container(
                        width: w,
                        margin:
                            EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                        alignment: Alignment.centerLeft,
                        child: commonText(
                            text: "Email address",
                            color: AppColors.black050F2B)),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    CommonTextField(
                        controller: controller.email,
                        text: 'Input email address'),
                    const SizedBox(
                      height: 17,
                    ),
                    Container(
                        width: w,
                        margin:
                            EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                        alignment: Alignment.centerLeft,
                        child: commonText(
                            text: "Password", color: AppColors.black050F2B)),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    CommonPaswordField(
                      controller: controller.password,
                      title: 'Input your password',
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Container(
                        width: w,
                        margin:
                            EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                        alignment: Alignment.centerLeft,
                        child: commonText(
                            text: "Confirm Password",
                            color: AppColors.black050F2B)),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    CommonPaswordField(
                      controller: controller.confPassword,
                      title: 'Input your password',
                    ),
                  ],
                )),
            SizedBox(
              height: h * 0.03,
            ),
            CommonButton(
              title: "Signup",
              onTap: () {
                if (controller.formKey.currentState!.validate()) {
                  if (controller.password.text.trim() !=
                      controller.confPassword.text.trim()) {
                    Utils.showError("Password does not match");
                  } else {
                    controller.signup();
                  }
                }

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const GroundsListScreen()));
              },
            ),
            SizedBox(
              height: h * 0.04,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 15, left: 15),
              child: Row(
                children: <Widget>[
                  Expanded(child: Divider(color: AppColors.greyE9E9E9)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Or sign up with',
                      style: TextStyle(
                          color: AppColors.grey8F8F8F,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.greyE9E9E9)),
                ],
              ),
            ),

            // commonText(text: "Forgot Password?",
            //     color: AppColors.redE73725),
            SizedBox(
              height: h * 0.04,
            ),
            Container(
              width: 350, // width of the container
              height: 50, // height of the container
              decoration: BoxDecoration(
                color: Colors.white, // background color of the container
                borderRadius: BorderRadius.circular(10), // rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), // shadow color
                    spreadRadius: 5, // spread of shadow
                    blurRadius: 10, // blur of shadow
                    offset: const Offset(0, 4), // position of shadow (x, y)
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // You can handle the button press here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // transparent background
                  shadowColor: Colors.transparent, // no button shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30), // match the container's rounded corners
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Google Logo.png',
                        width: 20, height: 20),
                    const SizedBox(width: 10),
                    const Text(
                      'Continue with Google', // Text for the button
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Container(
              width: 350, // width of the container
              height: 50, // height of the container
              decoration: BoxDecoration(
                color: AppColors.black20222C,
                borderRadius: BorderRadius.circular(10), // rounded corners
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Handle the button press here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .transparent, // transparent background for the button
                  shadowColor: Colors.transparent, // no shadow for the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // match the container's rounded corners
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Signup with Phone No', // White text for the button
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: h * 0.07),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonText(
                    text: "Already have an account? ",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black1F1F1F),
                GestureDetector(
                  onTap: () => Get.to(() => const LoginScreen()),
                  child: commonText(
                      text: "Sign in",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.redE73725),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
