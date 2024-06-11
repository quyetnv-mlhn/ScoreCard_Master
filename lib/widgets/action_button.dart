import 'package:flutter/material.dart';

import 'package:score_card_master/core/constants/app_const.dart';
import 'package:score_card_master/core/constants/app_style.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.text,
    super.key,
    this.color = backGroundColor,
    this.textColor = primaryColor,
    this.onPressed,
    this.fontWeight = FontWeight.w500,
    this.iconData,
  });
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback? onPressed;
  final FontWeight fontWeight;
  final IconData? iconData;

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
            if (iconData != null)
              Icon(iconData, color: textColor)
            else
              const SizedBox.shrink(),
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
