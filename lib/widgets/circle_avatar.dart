import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:flutter/material.dart';

class CircleAvatarCustom extends StatelessWidget {
  const CircleAvatarCustom({
    super.key,
    this.number,
    this.character,
    this.backgroundColor,
    this.radius = 20,
    this.icon,
    this.onTap,
  });

  final int? number;
  final String? character;
  final Color? backgroundColor;
  final double radius;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    int countNonNull = 0;

    if (number != null) ++countNonNull;
    if (character != null) ++countNonNull;
    if (icon != null) ++countNonNull;

    if (countNonNull != 1) {
      throw ArgumentError('number and character cannot be both value');
    }

    final color = backgroundColor == null ? primaryColor : otherColor;

    Widget? child;
    if (number != null) {
      child = Text(
        number.toString(),
        style: TextStyle(
          color: color,
          fontSize: primaryFontSize,
          fontWeight: FontWeight.w600,
        ),
      );
    } else if (character != null) {
      child = Text(
        character!,
        style: TextStyle(
          color: color,
          fontSize: primaryFontSize,
          fontWeight: FontWeight.w600,
        ),
      );
    } else if (icon != null) {
      child = Icon(icon, color: color);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? otherColor,
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
