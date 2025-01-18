import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pitchgo/login_screen/login_screen.dart';
import '../network_data/handle_error.dart';
import '../repository/auth_repository.dart';
import '../resource/secure_storage.dart';
import '../resource/utils.dart';

class SignupController extends GetxController {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confPassword = TextEditingController();
  final passwordVisible = false.obs;
  final confPasswordVisible = false.obs;

  final formKey = GlobalKey<FormState>();

  final _myRepo = AuthRepository();

  void signup() async {
    EasyLoading.show();
    try {
      final userData = {
        "fullName": name.text.trim(),
        "email": email.text.trim(),
        "password": password.text.trim(),
        "role": "owner",
      };

      final signUpData = await _myRepo.signUpApi(userData);
      log("signUp Response Data" + signUpData.toString());
      EasyLoading.dismiss();

      if (signUpData["code"] != null) {
        log("Sign Up 400");
        Utils.showError(signUpData["message"]);
      }
      if (signUpData["data"] != null) {
        log("Signup Success");
        Get.offAll(() => const LoginScreen());
      }
    } catch (error) {
      log("==============");
      log(error.toString());
      log(error.toString());

      HandleError.handleError(error, Get.context!);
    }
  }
}
