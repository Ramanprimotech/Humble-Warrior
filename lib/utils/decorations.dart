import 'package:flutter/material.dart';
import 'package:humble_warrior/utils/theme_extention/shadow_theme_extention.dart';

class CustomBoxDecorations {
  static BoxDecoration squareBorder(Color color, Color borderColor) {
    return BoxDecoration(
      color: color,
      border: Border.all(color: borderColor, width: 1),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    );
  }

  BoxDecoration shadow({required BuildContext context, Color? color}) {
    ShadowTheme shadowColor = Theme.of(context).extension<ShadowTheme>()!;
    Color containerColor = color ?? Theme.of(context).scaffoldBackgroundColor;
    return BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: shadowColor.shadowColor!,
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ]);
  }

  static BoxDecoration circularInputField(
      {Color borderColor = Colors.black,
      Color backColor = Colors.white,
      double border = 25}) {
    return BoxDecoration(
      color: backColor,
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.all(Radius.circular(border)),
    );
  }

  static BoxDecoration circularAgree(
      {Color borderColor = Colors.black, required Color backColor}) {
    return BoxDecoration(
      color: backColor,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
  }
}
