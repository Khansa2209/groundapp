import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroundController extends GetxController {
  final groundName = TextEditingController();
  final groundDescription = TextEditingController();
  final groundLocation = "".obs;
  final groundPrice = TextEditingController();
  final selectedImages = <File>[].obs;
  final selectedSportType = 'Cricket'.obs;
  final selectedDay = "".obs;
  final selectedTime = "".obs;

  void show() {
    for (var element in selectedImages) {
      final bytes =
          File(element.path).readAsBytesSync(); // path.readAsBytesSync();

      String img64 = base64Encode(bytes);

      print(img64);
    }
  }
}
