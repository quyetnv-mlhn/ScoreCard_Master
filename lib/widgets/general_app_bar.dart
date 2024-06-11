// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:score_card_master/core/constants/app_const.dart';
import 'package:score_card_master/core/constants/app_style.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeneralAppBar({
    required this.title,
    super.key,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.leading,
  });

  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppStyle.boldTextStyle(color: primaryLightColor, size: 20),
      ),
      backgroundColor: primaryColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      iconTheme: const IconThemeData(color: primaryLightColor),
      actions: actions,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
