import 'package:flutter/material.dart';

import '../app_constant/app_color.dart';

class CommonPaswordField extends StatefulWidget {
  final String? title;
  final TextEditingController? controller;
  const CommonPaswordField({super.key, this.title, this.controller, });

  @override
  State<CommonPaswordField> createState() => _CommonPaswordFieldState();
}

class _CommonPaswordFieldState extends State<CommonPaswordField> {
  bool _obscureText = true; // Start with text being obscured

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.06,
      width: w,
      margin: EdgeInsets.only(left: w*0.045,right: w*0.045),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.whiteF5F7FA,
      ),
      child: Center(
        child: TextField(
          controller: widget.controller,
          cursorColor: AppColors.redE73725,
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: widget.title,
            contentPadding: EdgeInsets.all(12),
            hintStyle: TextStyle(
              color: AppColors.grey797979,
            ),
            fillColor: AppColors.whiteF5F7FA,
            filled: true,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.black000000,
                size: 18,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: AppColors.grey797979,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: AppColors.grey797979,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
