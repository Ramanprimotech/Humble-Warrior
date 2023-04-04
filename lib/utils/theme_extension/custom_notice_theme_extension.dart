import 'package:humble_warrior/hw.dart';

class DialogueThemeExtention extends ThemeExtension<DialogueThemeExtention> {
  final Color? textColor;
  final Color? backGroundColor;
  final Color? buttonColor;
  final Color? shadow;

  const DialogueThemeExtention(
      {required this.textColor,
      required this.backGroundColor,
      required this.buttonColor,
      required this.shadow});

  @override
  ThemeExtension<DialogueThemeExtention> copyWith(
      {Color? textColor, Color? backGroundColor}) {
    return DialogueThemeExtention(
        textColor: textColor ?? this.textColor,
        shadow: shadow,
        buttonColor: buttonColor,
        backGroundColor: backGroundColor ?? this.backGroundColor);
  }

  @override
  ThemeExtension<DialogueThemeExtention> lerp(
      covariant ThemeExtension<DialogueThemeExtention>? other, double t) {
    if (other is! DialogueThemeExtention) {
      return this;
    }
    return DialogueThemeExtention(
      textColor: Color.lerp(textColor, other.textColor, t),
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t),
      shadow: Color.lerp(shadow, other.shadow, t),
      backGroundColor: Color.lerp(backGroundColor, other.backGroundColor, t),
    );
  }
}
