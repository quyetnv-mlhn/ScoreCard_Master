import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:calculate_card_score/core/constants/app_style.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback? onPressed;
  final FontWeight fontWeight;
  final IconData? iconData;

  const ActionButton({
    super.key,
    required this.text,
    this.color = otherColor,
    this.textColor = primaryColor,
    this.onPressed,
    this.fontWeight = FontWeight.w500,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 1,
        ),
        child: Row(
          children: [
            iconData != null
                ? Icon(iconData, color: textColor)
                : const SizedBox.shrink(),
            Expanded(
              child: Text(
                text,
                style: AppStyle.mediumTextStyle(
                  color: textColor,
                  fontWeight: fontWeight,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
