import 'package:flutter/material.dart';

import '../app_constant/app_color.dart';
import 'common_text.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color? color;
  final double radius;

  const CommonButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.color,
      this.radius = 9});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h * 0.06,
        width: w,
        margin: EdgeInsets.only(left: w * 0.045, right: w * 0.045),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: color == null ? AppColors.redE73725 : color),
        alignment: Alignment.center,
        child:
            commonText(text: title, color: AppColors.whiteFFFFFF, fontSize: 14),
      ),
    );
  }
}
