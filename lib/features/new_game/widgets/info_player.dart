import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:calculate_card_score/core/constants/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoPlayer extends StatelessWidget {
  const InfoPlayer({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/images/camera-add.svg',
            width: 50,
            height: 50,
          ),
          TextField(
            style: AppStyle.mediumTextStyle(),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Player ${index + 1}',
              hintStyle: AppStyle.mediumTextStyle(color: textColor),
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: smallPadding,
                horizontal: largePadding,
              ),
              border: const UnderlineInputBorder(),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }
}
