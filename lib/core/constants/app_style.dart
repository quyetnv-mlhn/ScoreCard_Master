import 'package:flutter/material.dart';

import 'package:calculate_card_score/core/constants/app_const.dart';

mixin AppStyle {
  static TextStyle mediumTextStyle({
    Color color = primaryColor,
    double size = primaryFontSize,
    FontWeight fontWeight = FontWeight.w400,
  }) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      );

  static TextStyle boldTextStyle({
    Color color = primaryColor,
    double size = primaryFontSize,
    FontWeight fontWeight = FontWeight.w600,
  }) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      );
}
