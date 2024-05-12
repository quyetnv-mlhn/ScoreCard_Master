// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:calculate_card_score/core/constants/app_style.dart';
import 'package:flutter/material.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeneralAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppStyle.boldTextStyle(color: primaryLightColor, size: 20.0),
      ),
      backgroundColor: primaryColor,
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: primaryLightColor),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
