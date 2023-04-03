import 'package:humble_warrior/hw.dart';

class CustomBoxDecorations {
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
}
