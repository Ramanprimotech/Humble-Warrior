import 'package:flutter/material.dart';

class AccountOptionTheme extends ThemeExtension<AccountOptionTheme> {
  final Color? textColor;
  final Color? backGroundColor;

  const AccountOptionTheme(
      {required this.textColor, required this.backGroundColor});

  @override
  ThemeExtension<AccountOptionTheme> copyWith(
      {Color? textColor, Color? backGroundColor}) {
    return AccountOptionTheme(
        textColor: textColor ?? this.textColor,
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
      backGroundColor: Color.lerp(backGroundColor, other.backGroundColor, t),
    );
  }
}
