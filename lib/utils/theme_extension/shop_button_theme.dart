import 'package:humble_warrior/hw.dart';

class ShopNowTheme extends ThemeExtension<ShopNowTheme> {
  final Color? textColor;
  final Color? backGroundColor;

  const ShopNowTheme({required this.textColor, required this.backGroundColor});
  @override
  ThemeExtension<ShopNowTheme> copyWith(
      {Color? textColor, Color? backGroundColor}) {
    return ShopNowTheme(
        textColor: textColor ?? this.textColor,
        backGroundColor: backGroundColor ?? this.backGroundColor);
  }

  @override
  ThemeExtension<ShopNowTheme> lerp(
      covariant ThemeExtension<ShopNowTheme>? other, double t) {
    if (other is! ShopNowTheme) {
      return this;
    }
    return ShopNowTheme(
      textColor: Color.lerp(textColor, other.textColor, t),
      backGroundColor: Color.lerp(backGroundColor, other.backGroundColor, t),
    );
  }
}
