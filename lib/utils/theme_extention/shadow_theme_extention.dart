import 'package:flutter/material.dart';

class ShadowTheme extends ThemeExtension<ShadowTheme> {
  final Color? shadowColor;

  const ShadowTheme({required this.shadowColor});

  @override
  ThemeExtension<ShadowTheme> copyWith(
      {Color? shadowColor, Color? backGroundColor}) {
    return ShadowTheme(
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  @override
  ThemeExtension<ShadowTheme> lerp(
      covariant ThemeExtension<ShadowTheme>? other, double t) {
    if (other is! ShadowTheme) {
      return this;
    }
    return ShadowTheme(
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
    );
  }
}
