import 'package:flutter/material.dart';

class AccountOptionTheme extends ThemeExtension<AccountOptionTheme> {
  final Color? textColor;
  final Color? backGroundColor;
  final Color? shadow;

  const AccountOptionTheme(
      {required this.textColor,
      required this.backGroundColor,
      required this.shadow});

  @override
  ThemeExtension<AccountOptionTheme> copyWith(
      {Color? textColor, Color? backGroundColor}) {
    return AccountOptionTheme(
        textColor: textColor ?? this.textColor,
        shadow: shadow ?? this.shadow,
        backGroundColor: backGroundColor ?? this.backGroundColor);
  }

  @override
  ThemeExtension<AccountOptionTheme> lerp(
      covariant ThemeExtension<AccountOptionTheme>? other, double t) {
    if (other is! AccountOptionTheme) {
      return this;
    }
    return AccountOptionTheme(
      textColor: Color.lerp(textColor, other.textColor, t),
      shadow: Color.lerp(shadow, other.shadow, t),
      backGroundColor: Color.lerp(backGroundColor, other.backGroundColor, t),
    );
  }
}
