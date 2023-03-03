import 'package:flutter/material.dart';

class ImageIconTheme
    extends ThemeExtension<ImageIconTheme> {
  final Color? textColor;
  final Color? backGroundColor;

  const ImageIconTheme(
      {required this.textColor,
      required this.backGroundColor});

  @override
  ThemeExtension<ImageIconTheme> copyWith(
      {Color? textColor, Color? backGroundColor}) {
    return ImageIconTheme(
        textColor: textColor ?? this.textColor,
        backGroundColor: backGroundColor ?? this.backGroundColor);
  }

  @override
  ThemeExtension<ImageIconTheme> lerp(
      covariant ThemeExtension<ImageIconTheme>? other, double t) {
    if (other is! ImageIconTheme) {
      return this;
    }
    return ImageIconTheme(
      textColor: Color.lerp(textColor, other.textColor, t),
      backGroundColor: Color.lerp(backGroundColor, other.backGroundColor, t),
    );
  }
}
