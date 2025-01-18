import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:pitchgo/app_constant/app_color.dart';

class Utils {
  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(seconds: 2)
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = AppColors.redE73725
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = AppColors.redE73725
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static void showError(String message) {
    EasyLoading.dismiss();
    EasyLoading.showError(message);
  }

  static void showSuccess(String message) {
    EasyLoading.dismiss();
    EasyLoading.showSuccess(message);
  }

  static void showInfo(String message) {
    EasyLoading.dismiss();
    EasyLoading.showInfo(message);
  }

  static void otpSnakbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              msg,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 3), // Adjust the duration as needed
      backgroundColor: AppColors.redE73725,
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
        textColor: Colors.white,
      ),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    ));
  }

  static void errorSnakbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              msg,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 3), // Adjust the duration as needed
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
        textColor: Colors.white,
      ),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    ));
  }

  static Future<String?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: AppColors
                  .redE73725, // background color of the header and selected date
              onPrimary:
                  Colors.white, // text color of the header and selected date
            ),
            dialogBackgroundColor:
                Colors.white, // background color of the date picker
          ),
          child: child!,
        );
      },
    );

    return formatDate(picked.toString());
  }

  static String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  static Future<TimeOfDay?> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: AppColors.redE73725,
              onPrimary: Colors.white,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    return (picked);
  }
}
