import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../resource/utils.dart';

class HandleError {
  static handleError(dynamic error, BuildContext context) {
    EasyLoading.dismiss();
    if (error.toString().contains("No Internet Connection")) {
      Utils.errorSnakbar(context, "No Internet Connection");
    } else {
      log(error.toString());
      Utils.errorSnakbar(context, "Something went wrong");
    }
  }
}
