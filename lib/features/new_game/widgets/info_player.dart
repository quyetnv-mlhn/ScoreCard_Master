import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_const.dart';
import '../../../core/constants/app_style.dart';

class InfoPlayer extends StatelessWidget {
  const InfoPlayer(
      {required this.index,
      required this.textEditingController,
      super.key,
      this.onChanged});

  final int index;
  final void Function(String)? onChanged;
  final TextEditingController textEditingController;

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
            controller: textEditingController,
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
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
