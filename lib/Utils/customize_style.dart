import 'package:brain_curve/Utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'colors.dart';

class BrainCurveCustomizeStyle {
  late final BrainCurve sizes;

  BrainCurveCustomizeStyle()
      : sizes = BrainCurve(constraints: null, orientation: null);

  BrainCurveCustomizeStyle.init(
      BoxConstraints constraints, Orientation orientation)
      : sizes = BrainCurve(constraints: constraints, orientation: orientation);

  LottieBuilder brainCurveLottieImage(String imagePath,
      {double widthInPercent = 20, AnimationController? animationController}) {
    return Lottie.asset(
      imagePath,
      width: sizes.horizontalBlockSize * widthInPercent,
      fit: BoxFit.cover,
      controller: animationController,
      onLoaded: (composition) {
        if (animationController != null) {
          animationController.duration = composition.duration;
        }
      },
    );
  }

  // Text Styles
  Text brainCurveHeader(
    String text, {
    int? maxLinesOfText,
    Color? textColor,
    double? fontSize,
    TextOverflow? onOverFlow,
    TextAlign? textAlign,
    TextStyle? textStyle,
    FontWeight? fontWeight2,
    bool isLevelTwo = false,
  }) {
    return Text(
      text,
      maxLines: maxLinesOfText,
      overflow: onOverFlow,
      textAlign: textAlign ?? TextAlign.left,
      style: textStyle ??
          headerStyle(
              fontWeight: fontWeight2, color: textColor, size: fontSize),
    );
  }

  Text brainCurveSubHeader(String text,
      {int? maxLinesOfText,
      Color? textColor,
      double? fontSize,
      TextOverflow? onOverFlow,
      TextAlign? textAlign,
      TextStyle? textStyle}) {
    return Text(
      text,
      // maxLines: maxLinesOfText ?? 1,
      // overflow: onOverFlow ?? TextOverflow.visible,
      textAlign: textAlign ?? TextAlign.left,
      style: textStyle ?? subHeaderStyle(color: textColor, size: fontSize),
    );
  }

  Text body(String text, {TextAlign? textAlign, TextStyle? textStyle}) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.left,
      style: textStyle ?? bodyStyle(),
    );
  }

  bodyStyle({Color? color, FontWeight? fontWeight, double? fontSize}) {
    return TextStyle(
        fontSize: 2.0 * sizes.textMultiplier,
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.bold);
  }

  TextStyle headerStyle({Color? color, FontWeight? fontWeight, double? size}) {
    return TextStyle(
      fontSize: size ?? 2.2 * sizes.textMultiplier,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color ?? Colors.white,
    );
  }

  TextStyle levelTwoHeader({Color? darkModeColor, Color? lightModeColor}) {
    return TextStyle(
      fontSize: 1.8 * sizes.textMultiplier,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    );
  }

  TextStyle subHeaderStyle(
      {Color? color, FontWeight? fontWeight, double? size}) {
    return TextStyle(
      fontSize: size ?? 1.5 * sizes.textMultiplier,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? Colors.black,
    );
  }

  Image brainCurveImage(String imagePath,
      {double? widthInPercent,
      Key? imageKey,
      double? heightInPercent,
      BoxFit? fitting}) {
    return Image.asset(
      key: imageKey,
      imagePath,
      width: widthInPercent == null
          ? null
          : sizes.horizontalBlockSize * widthInPercent,
      height: heightInPercent == null
          ? null
          : sizes.verticalBlockSize * heightInPercent,
      fit: fitting ?? BoxFit.contain,
    );
  }

  // Button Styles
  Widget brainCurveElevatedButton({
    required VoidCallback onPressed,
    BorderRadius? borderRadiusOfButton,
    Color? backgroundColor,
    Gradient? gradient,
    double? widthInPercent,
    double? heightInPercent,
    Color? borderColor,
    double? borderWidth,
    required Widget childOfButton,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadiusOfButton ??
            BorderRadius.circular(sizes.horizontalBlockSize * 4),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shadowColor: Colors.transparent, // Remove shadow if gradient is used
          shape: RoundedRectangleBorder(
            borderRadius: borderRadiusOfButton ??
                BorderRadius.circular(sizes.horizontalBlockSize * 4),
            side: borderColor != null
                ? BorderSide(color: borderColor, width: borderWidth ?? 1)
                : BorderSide.none,
          ),
          minimumSize: widthInPercent != null
              ? Size(
                  sizes.horizontalBlockSize * widthInPercent,
                  sizes.verticalBlockSize * (heightInPercent ?? 6.5),
                )
              : null,
        ),
        onPressed: onPressed,
        child: childOfButton,
      ),
    );
  }

// Icon Styles
  IconButton brainCurveIconButton(
    IconData iconData, {
    required VoidCallback onPressed, // Click functionality
    Color? color,
    double? sizeOfIcon,
  }) {
    return IconButton(
      icon: brainCurveIcon(
        iconData,
        color: color,
        sizeOfIcon: sizeOfIcon,
      ),
      onPressed: onPressed,
    );
  }

  Icon brainCurveIcon(IconData iconData, {Color? color, double? sizeOfIcon}) {
    return Icon(
      iconData,
      size: sizeOfIcon ?? 3.0 * sizes.textMultiplier,
      color: color ?? Colors.white,
    );
  }

  Widget brainCurveVerticalGap({double? verticalGapSizeInPercent}) {
    return SizedBox(
      height: sizes.getVerticalGapSize(
          verticalGapSizeInPercent:
              verticalGapSizeInPercent ?? sizes.verticalBlockSize),
    );
  }

  Expanded brainCurveVerticalGapExpanded() {
    return const Expanded(
      child: SizedBox.shrink(),
    );
  }

  Widget brainCurveHorizontalGap({double? horizontalGapSizeInPercent}) {
    return SizedBox(
      width: sizes.getHorizontalGapSize(
          horizontalGapSizeInPercent:
              horizontalGapSizeInPercent ?? sizes.horizontalBlockSize),
    );
  }

  Widget brainCurveGapSize(
      {required double horizontalGapSizeInPercent,
      required double verticalGapSizeInPercent}) {
    return SizedBox(
      width: sizes.getHorizontalGapSize(
          horizontalGapSizeInPercent: horizontalGapSizeInPercent),
      height: sizes.getVerticalGapSize(
          verticalGapSizeInPercent: verticalGapSizeInPercent),
    );
  }

  // Padding of all screen
  EdgeInsets brainCurveAllScreenPadding({double? ver, double? hor}) {
    return EdgeInsets.symmetric(
        horizontal: sizes.horizontalBlockSize * (hor ?? 4),
        vertical: sizes.horizontalBlockSize * (ver ?? 2));
  }

  TextStyle chatStyle(Color? colors) {
    return TextStyle(
      fontSize: 2.0 * sizes.textMultiplier,
      color: colors ?? Colors.white,
    );
  }

  EdgeInsets chatScreenBottomNavPadding() {
    return EdgeInsets.only(
      top: sizes.horizontalBlockSize * 3,
      left: sizes.horizontalBlockSize * 4,
      right: sizes.horizontalBlockSize * 4,
      bottom: sizes.horizontalBlockSize * 3,
    );
  }

  // Margin of all screen
  EdgeInsets brainCurveTextFieldContainerPadding() {
    return EdgeInsets.symmetric(
        horizontal: sizes.horizontalBlockSize * 4,
        vertical: sizes.horizontalBlockSize * 1.5);
  }

  BorderRadius brainCurveTextFieldBorderRadius() {
    return BorderRadius.circular(sizes.textMultiplier * 2);
  }

  // TextField Styles
  TextField brainCurveTextField({
    required TextEditingController controller,
    TextCapitalization? textCapitalization,
    Function(String text)? onChangedText,
    Color? textColor,
    double? textSize,
    VoidCallback? onPrefixIconPressed,
    IconData? prefixIcon,
    Color? colorPrefix,
    IconData? suffixIcon,
    Color? colorSuffix,
    IconData? suffixIcon2,
    Color? colorSuffix2,
    VoidCallback? onSuffixIconPressed,
    VoidCallback? onSuffixIcon2Pressed,
    String? hintText,
    Color? hintColor,
    String? labelText,
    String? helperText,
    Color? helperColor,
    int? helperMaxLines,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    Color? cursorColor,
    bool multiLine = true,
    bool outerBorder = true,
    bool focusOuterBorder = true,
    EdgeInsets? contentPadding,
    bool obscureText = false,
    bool enabled = true,
    Color? focusColor,
    Color? unFocusColor,
  }) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      onChanged: onChangedText,
      maxLines: multiLine ? 4 : 1,
      minLines: 1,
      focusNode: focusNode,
      keyboardType: keyboardType ?? TextInputType.text,
      enabled: enabled,
      obscureText: obscureText,
      style: subHeaderStyle(color: textColor, size: textSize),
      cursorColor: cursorColor ?? pureLightOrangeColor,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? IconButton(
                onPressed: onPrefixIconPressed,
                icon: brainCurveIcon(
                  prefixIcon,
                  sizeOfIcon: 3.0 * sizes.textMultiplier,
                  color: colorPrefix,
                ),
              )
            : null,
        suffixIcon: suffixIcon != null || suffixIcon2 != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (suffixIcon != null)
                    IconButton(
                      onPressed: onSuffixIconPressed,
                      icon: brainCurveIcon(
                        suffixIcon,
                        sizeOfIcon: 3.0 * sizes.textMultiplier,
                        color: colorSuffix,
                      ),
                    ),
                  if (suffixIcon2 != null)
                    IconButton(
                      onPressed: onSuffixIcon2Pressed,
                      icon: brainCurveIcon(
                        suffixIcon2,
                        sizeOfIcon: 3.0 * sizes.textMultiplier,
                        color: colorSuffix2,
                      ),
                    ),
                ],
              )
            : null,
        alignLabelWithHint: true,
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor ?? hintTextColor,
          fontSize: 16.0,
        ),
        contentPadding: contentPadding ?? brainCurveTextFieldContainerPadding(),
        enabledBorder: OutlineInputBorder(
          borderRadius: brainCurveTextFieldBorderRadius(),
          borderSide: outerBorder
              ? BorderSide(
                  color: unFocusColor ?? receiverBubbleDark, width: 1.5)
              : BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: brainCurveTextFieldBorderRadius(),
          borderSide: outerBorder
              ? BorderSide(
                  color: unFocusColor ?? receiverBubbleDark, width: 1.5)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: brainCurveTextFieldBorderRadius(),
          borderSide: focusOuterBorder
              ? BorderSide(width: 1.5, color: focusColor ?? greyColor)
              : BorderSide.none,
        ),
      ),
    );
  }

  Widget brainCurveShadedIconButton({
    required VoidCallback onPressed,
    required IconData icon,
    Color? iconColor,
    Color? backgroundColor,
    Color? borderColor,
    double? iconSize,
  }) {
    return Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade800,
                spreadRadius: 1,
              ),
            ]),
        child: brainCurveIconButton(
          icon,
          onPressed: onPressed,
          color: iconColor,
          sizeOfIcon: iconSize,
        ));
  }

  Widget brainCurveLoginSignUpTextField({
    bool needSuffixIcon = false,
    required TextEditingController controller,
    VoidCallback Function(String text)? onChangedText,
    VoidCallback? onSuffixIconPressed,
    String? hintText,
    String? labelText,
    Color? colorSuffix,
    bool obscureText = false,
    String? helperText,
    Color? helperColor,
    Color? cursorColor,
    Color? textColor,
    int? helperMaxLines,
    VoidCallback? onPrefixIconPressed,
    IconData? prefixIcon,
    Color? colorPrefix,
    bool multiLine = false,
  }) {
    return Container(
      padding: EdgeInsets.only(
        left: sizes.horizontalBlockSize * 4,
        right: sizes.horizontalBlockSize * 4,
        bottom: helperText == null ? 0 : sizes.verticalBlockSize * 1.5,
      ),
      decoration: BoxDecoration(
        borderRadius: brainCurveTextFieldBorderRadius(),
        border: Border.all(
          color: greyColor,
        ),
      ),
      child: brainCurveTextField(
        controller: controller,
        labelText: labelText,
        hintText: hintText,
        cursorColor: cursorColor,
        textColor: textColor,
        obscureText: obscureText,
        suffixIcon: needSuffixIcon
            ? obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined
            : null,
        onSuffixIconPressed: onSuffixIconPressed,
        colorSuffix: colorSuffix,
        prefixIcon: prefixIcon,
        onPrefixIconPressed: onPrefixIconPressed,
        colorPrefix: colorPrefix,
        multiLine: multiLine,
        outerBorder: false,
        focusOuterBorder: false,
        helperText: helperText,
        helperColor: helperColor,
        helperMaxLines: helperMaxLines,
      ),
    );
  }
}
