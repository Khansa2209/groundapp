import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitchgo/app_constant/app_color.dart';
import 'package:pitchgo/common_widget/common_botton.dart';
import 'package:pitchgo/common_widget/common_text_field.dart';
import 'package:pitchgo/common_widget/common_pasword_field.dart';
import 'package:pitchgo/common_widget/common_text.dart';

import '../controller/signin_controller.dart';
import '../signup_screen/signup_screen.dart';
// import 'signup_screen.dart';  // Import the SignupScreen

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: AppColors.whiteFFFFFF,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(right: 4, left: 15),
                child: Row(
                  children: [
                    Image.asset('assets/images/l_icon_1.png',
                        width: 20, height: 20),
                    SizedBox(width: 110),
                    commonText(
                      text: 'Login',
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: w,
                margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                alignment: Alignment.centerLeft,
                child: commonText(
                    text: "Email address", color: AppColors.black050F2B),
              ),
              SizedBox(height: h * 0.01),
              Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      CommonTextField(
                          controller: controller.email,
                          text: 'Input email address'),
                      SizedBox(height: 20),
                      Container(
                        width: w,
                        margin:
                            EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                        alignment: Alignment.centerLeft,
                        child: commonText(
                            text: "Password", color: AppColors.black050F2B),
                      ),
                      SizedBox(height: h * 0.01),
                      CommonPaswordField(
                          controller: controller.password,
                          title: 'Input your password'),
                      SizedBox(height: h * 0.03),
                    ],
                  )),

              CommonButton(
                title: "Login",
                onTap: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.login();
                  }
                },
              ),
              SizedBox(height: h * 0.02),
              commonText(
                text: "Forgot Password?",
                color: AppColors.redE73725,
              ),
              SizedBox(height: h * 0.07),
              // Google Login Button with Shadow
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Google sign-in
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/Google Logo.png',
                          width: 20, height: 20),
                      SizedBox(width: 10),
                      Text(
                        'Continue with Google',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              // Phone Sign Up Button
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.black20222C,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle phone sign-up
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        'Signup with Phone No',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: h * 0.12),
              // Already have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  commonText(
                    text: "Already have an account? ",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black1F1F1F,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => const SignupScreen()),
                    child: commonText(
                      text: "Sign up",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.redE73725,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
