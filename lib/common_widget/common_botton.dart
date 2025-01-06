import 'package:flutter/material.dart';

import '../app_constant/app_color.dart';
import 'common_text.dart';

class CommonButton extends StatefulWidget {
  final String title;
  final Function() onTap;
  final Color? color;
  const CommonButton({super.key, required this.title, required this.onTap, this.color});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: h*0.06,
        width: w,
        margin: EdgeInsets.only(left: w*0.045,right: w*0.045),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color:widget.color==null? AppColors.redE73725:widget.color
        ),
        alignment: Alignment.center,
        child: commonText(text: widget.title,color: AppColors.whiteFFFFFF,fontSize: 14),
      ),
    );
  }
}
