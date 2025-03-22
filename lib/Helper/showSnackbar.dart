import 'package:brain_curve/Extension/theme.dart';
import 'package:flutter/material.dart';

import '../Utils/customize_style.dart';

void showSnackBar(String message, BuildContext context,
    {Color? bgColor,
    void Function()? onTap,
    String? title,
    bool actionNeeded = false}) {
  BrainCurveCustomizeStyle style = BrainCurveCustomizeStyle();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: style.subHeaderStyle(color: context.textColor),
      ),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: bgColor ?? context.cardBg,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(style.sizes.horizontalBlockSize * 4)),
      margin: EdgeInsets.symmetric(
          vertical: style.sizes.verticalBlockSize * 2,
          horizontal: style.sizes.horizontalBlockSize * 4),
      action: actionNeeded
          ? SnackBarAction(
              label: title ?? "",
              onPressed: onTap ?? () {},
              textColor: Colors.black,
            )
          : null,
    ),
  );
}
