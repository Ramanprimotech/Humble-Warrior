import 'package:humble_warrior/hw.dart';

class ShadowTheme extends ThemeExtension<ShadowTheme> {
  final Color? shadowColor;
  final Color? background;

  const ShadowTheme({required this.shadowColor, this.background});

  @override
  ThemeExtension<ShadowTheme> copyWith(
      {Color? shadowColor, Color? backGroundColor}) {
    return ShadowTheme(
      shadowColor: shadowColor ?? this.shadowColor,
      background: background ?? this.background,
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
      background: Color.lerp(background, other.background, t),
    );
  }
}
