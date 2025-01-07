import 'package:flutter/material.dart';

import '../../app_constant/app_color.dart';

class SectionHeading1 extends StatelessWidget {
  const SectionHeading1({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.black505050),
    );
  }
}
