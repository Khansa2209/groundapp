import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text commonText({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  Color? textDecorationColor,
  TextAlign? textAlign,
  TextDecoration? textDecoration,
  String? fontFamily,
  FontStyle? fontStyle,
}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: GoogleFonts.geologica(
      color: color ?? Colors.black,
      fontSize: fontSize ?? 14,
      fontStyle: fontStyle,
      decorationColor: textDecorationColor,
      decorationThickness: 1.5,
      height: 1.2,
      decoration: textDecoration ?? TextDecoration.none,
      fontWeight: fontWeight ?? FontWeight.w400,
    ),
  );
}
