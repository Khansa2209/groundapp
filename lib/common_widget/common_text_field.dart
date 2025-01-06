import 'package:flutter/material.dart';

import '../app_constant/app_color.dart';

class CommonTextField extends StatefulWidget {
  final String text;
  final TextEditingController? controller;
  const CommonTextField({super.key, required this.text, this.controller});

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
        height: h*0.06,
        width: w,
        margin: EdgeInsets.only(left: w*0.045,right: w*0.045),
        decoration: BoxDecoration(
          color:AppColors.grey797979,
          borderRadius: BorderRadius.circular(13),
        ),
        alignment: Alignment.center,
        child: Center(
          child: TextField(
            controller: widget.controller,
            cursorColor: AppColors.redE73725,
            decoration: InputDecoration(
              hintText: widget.text,
              hintStyle: TextStyle(
                color:AppColors.grey797979,
              ),
              fillColor:AppColors.whiteF5F7FA,
              filled:true,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      width: 1,
                      color: AppColors.grey797979
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.grey797979,
                  )
              ),
            ),
          ),
        ));
  }
}

