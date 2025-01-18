import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pitchgo/view/otp_screen/otp_screen.dart';

import '../ground_list/ground_list.dart';
import '../network_data/handle_error.dart';
import '../repository/auth_repository.dart';
import '../resource/secure_storage.dart';
import '../resource/utils.dart';

class LoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final repo = AuthRepository();

  void login() async {
    EasyLoading.show();
    try {
      final userData = {
        "email": email.text.trim(),
        "password": password.text.trim(),
      };

      final data = await repo.loginApi(userData);
      log("login Response Data" + data.toString());
      EasyLoading.dismiss();

      if (data["code"] != null) {
        log("Sign Up 400");
        Utils.showError(data["message"]);
      }
      if (data["data"] != null) {
        log("Signup Success");
        Utils.showSuccess(data["message"]);
        if (data["data"]["profile"] == null) {
          Get.to(() => const OtpScreen(
                profile: "empty",
              ));
        } else {
          Get.to(() => const OtpScreen(
                profile: "complete",
              ));
        }
      }
    } catch (error) {
      log("==============");
      log(error.toString());
      log(error.toString());

      HandleError.handleError(error, Get.context!);
    }
  }
}
