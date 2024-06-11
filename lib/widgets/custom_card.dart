import 'package:flutter/material.dart';

import 'package:score_card_master/core/constants/app_const.dart';
import 'package:score_card_master/core/constants/app_style.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.title,
    required this.content,
    super.key,
    this.leadingIcon,
    this.padding,
    this.onTap,
  });

  final String title;
  final Widget content;
  final Widget? leadingIcon;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backGroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(smallPadding),
      ),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(largePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (leadingIcon != null) leadingIcon!,
              Text(
                title,
                style: AppStyle.boldTextStyle(size: 16),
              ),
              const SizedBox(height: 8),
              content,
            ],
          ),
        ),
      ),
    );
  }
}
