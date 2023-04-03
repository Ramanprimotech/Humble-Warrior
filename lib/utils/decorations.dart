import 'package:humble_warrior/hw.dart';

class CustomBoxDecorations {
  late ShadowTheme shadowColor;

  CustomBoxDecorations({required BuildContext context}) {
    shadowColor = Theme.of(context).extension<ShadowTheme>()!;
  }

  BoxDecoration shadow({Color? color, double? radius}) {
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

  BoxDecoration shadowAll() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        blurRadius: 2,
        spreadRadius: 2,
        color: shadowColor.shadowColor!,
      ),
    ]);
  }
}
