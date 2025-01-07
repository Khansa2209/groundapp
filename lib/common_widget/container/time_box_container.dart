import 'package:flutter/material.dart';

import '../../app_constant/app_string.dart';

class TimeBoxContainer extends StatelessWidget {
  const TimeBoxContainer(
      {super.key,
      required this.item,
      required this.containerColor,
      required this.textColor,
      required this.iconColor,
      required this.borderColor,
      this.showIcon = false,
      this.onTap});

  final String item;
  final Color containerColor;
  final Color textColor;
  final Color iconColor;
  final Color borderColor;
  final VoidCallback? onTap;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        height: 45,
        width: 90,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: borderColor, width: 3),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Center(
                    child: Text(
              item,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
            ))),
            showIcon
                ? Image.asset(
                    "${AppString.imagePath}mage_dots.png",
                    color: iconColor,
                    height: 16,
                    width: 16,
                    fit: BoxFit.fitHeight,
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
