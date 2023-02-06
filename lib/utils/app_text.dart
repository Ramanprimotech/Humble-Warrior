
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:humble_warrior/utils/sizes/sizes_config.dart';

import 'app_themes/app_theme_controller.dart';
import 'media_query_widget.dart';
import 'sizes/enumClass.dart';

class AppText extends StatelessWidget {
  final String label;
  final TextSizes? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final int? minLines;
  final TextAlign? textAlign;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final TextDecoration? textDecoration;

  const AppText(
    this.label, {
    Key? key,
    this.color,
    this.minLines = 1,
    this.fontWeight = FontWeight.w500,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.padding,
    this.onTap,
    this.textDecoration,
    this.fontSize,
  }) : super(key: key);

  const AppText.small(
    this.label, {
    Key? key,
    this.color,
    this.minLines = 1,
    this.fontSize = TextSizes.small,
    this.fontWeight = FontWeight.w400,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.padding,
    this.onTap,
    this.textDecoration,
  }) : super(key: key);

  const AppText.medium(
    this.label, {
    Key? key,
    this.color,
    this.minLines = 1,
    this.fontSize = TextSizes.medium,
    this.fontWeight = FontWeight.w400,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.padding,
    this.onTap,
    this.textDecoration,
  }) : super(key: key);

  const AppText.large(
    this.label, {
    Key? key,
    this.color,
    this.minLines = 1,
    this.fontSize = TextSizes.large,
    this.fontWeight = FontWeight.w600,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.padding,
    this.onTap,
    this.textDecoration,
  }) : super(key: key);

  const AppText.extraLarge(
    this.label, {
    Key? key,
    this.color,
    this.minLines = 1,
    this.fontSize = TextSizes.extraLarge,
    this.fontWeight = FontWeight.w600,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.padding,
    this.onTap,
    this.textDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double textSize;
    if (fontSize == TextSizes.small) {
      textSize = Dimens.fontSmall;
    } else if (fontSize == TextSizes.medium) {
      textSize = Dimens.fontMedium;
    } else if (fontSize == TextSizes.large) {
      textSize = Dimens.fontLarge;
    } else if (fontSize == TextSizes.extraLarge) {
      textSize = Dimens.fontExtraLarge;
    } else {
      textSize = Dimens.fontNormal;
    }

    return MediaQueryWidget(
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: GestureDetector(
          onTap: onTap,
          child: color == null
              ? Text(
                  label,
                  textAlign: textAlign,
                  style: TextStyle(
                    color: color,
                    fontWeight: fontWeight,
                    fontSize: textSize,
                    decoration: textDecoration,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: maxLines,
                )
              : Text(
                  label,
                  textAlign: textAlign,
                  style: TextStyle(
                    color: color,
                    fontWeight: fontWeight,
                    fontSize: textSize,
                    decoration: textDecoration,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: maxLines,
                ),
        ),
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText(
      this.label, {
        Key? key,
        this.color,
        this.fontSize = 36,
        this.padding,
      }) : super(key: key);

  final String label;
  final Color? color;
  final EdgeInsets? padding;
  final double? fontSize;

  static final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
      child: color == null
          ? Obx(() => Text(
        label,
        style: GoogleFonts.montserrat(
          color: _themeController.headingColor.value,
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
      ))
          : Text(
        label,
        style: GoogleFonts.montserrat(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

