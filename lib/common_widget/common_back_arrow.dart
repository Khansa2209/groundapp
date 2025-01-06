import 'package:flutter/material.dart';

class CommonBackArrow extends StatefulWidget {
  const CommonBackArrow({super.key});

  @override
  State<CommonBackArrow> createState() => _CommonBackArrowState();
}

class _CommonBackArrowState extends State<CommonBackArrow> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/back_arrow.png',
      height: 20,
      width: 20,
    );
  }
}
