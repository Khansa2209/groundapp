import 'dart:async';
import 'dart:developer';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pitchgo/ground_list/ground_list.dart';

import '../network_data/handle_error.dart';
import '../repository/auth_repository.dart';
import '../resource/secure_storage.dart';
import '../resource/utils.dart';

class OtpController extends GetxController {
  final seconds = 60.obs;
  Timer? timer;
  var pinValue = '';

  final repo = AuthRepository();

  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  void startCountdown() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      }
    });
  }

  void checkpin(String email) async {
    EasyLoading.show();
    try {
      final userData = {"process": "login", "email": email, "otp": pinValue};

      final data = await repo.otpVerify(userData);
      log("Otp Response Data" + data.toString());
      EasyLoading.dismiss();

      if (data["code"] != null) {
        log("Sign Up 400");
        Utils.showError(data["message"]);
      }
      if (data["data"] != null) {
        log("Signup Success");
        SecureStorage().storeLocalData(
            key: 'userRole', value: data["data"]["user"]["role"]);
        Get.offAll(() => const GroundsListScreen());
      }
    } catch (error) {
      log("==============");
      log(error.toString());
      log(error.toString());

      HandleError.handleError(error, Get.context!);
    }
  }
}
