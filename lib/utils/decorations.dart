import 'package:humble_warrior/hw.dart';

class CustomBoxDecorations {
  static BoxDecoration topBorderCurve({
    double radius = 10.0,
    required BuildContext context,
  }) {
    ShadowTheme shadowColor = Theme.of(context).extension<ShadowTheme>()!;
    return BoxDecoration(
      color: shadowColor.background,
      // border: Border.all(color: borderColor, width: 1),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
    );
  }

  static BoxDecoration bottomBorderCurve({
    double radius = 10.0,
    required BuildContext context,
  }) {
    ShadowTheme shadowColor = Theme.of(context).extension<ShadowTheme>()!;
    return BoxDecoration(
      color: shadowColor.background,
      // border: Border.all(color: borderColor, width: 1),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius)),
    );
  }

  BoxDecoration shadow(
      {required BuildContext context, Color? color, double? radius}) {
    ShadowTheme shadowColor = Theme.of(context).extension<ShadowTheme>()!;
    return BoxDecoration(
        color: color ?? shadowColor.background,
        borderRadius: BorderRadius.circular(radius ?? 10),
        boxShadow: [
          BoxShadow(
            color: shadowColor.shadowColor!,
            offset: const Offset(0, 2),
            spreadRadius: 1,
            blurRadius: 2,
          ),
          BoxShadow(
            color: shadowColor.shadowColor!,
            offset: const Offset(0, 0),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ]);
  }

  static BoxDecoration circularInputField(
      {Color borderColor = Colors.black,
      Color backColor = Colors.white,
      required BuildContext context,
      double border = 25}) {
    ShadowTheme shadowColor = Theme.of(context).extension<ShadowTheme>()!;
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
