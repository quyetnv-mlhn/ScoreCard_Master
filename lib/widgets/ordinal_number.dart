import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:flutter/material.dart';

class OrdinalNumber extends StatelessWidget {
  const OrdinalNumber({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: otherColor,
        shape: BoxShape.circle,
      ),
      child: Text(
        number.toString(),
        style: const TextStyle(
          color: primaryColor,
          fontSize: primaryFontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
