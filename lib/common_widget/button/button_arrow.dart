import 'package:flutter/material.dart';

import '../../app_constant/app_color.dart';

class ButtonArrow extends StatelessWidget {
  const ButtonArrow({
    super.key,
    required this.onTap,
    this.buttonText = "Yes",
  });

  final VoidCallback? onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.redE73725,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(
            buttonText,
            style: TextStyle(
                fontSize: 16,
                color: AppColors.whiteFFFFFF,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
          )
        ]),
      ),
    );
  }
}
