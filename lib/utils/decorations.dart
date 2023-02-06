import 'package:flutter/material.dart';

class CustomeBoxDecorations {
  static BoxDecoration squareBorder(Color color,Color borderColor) {
    return BoxDecoration(
      color: color,
      border: Border.all(color: borderColor,width: 1),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    );
  }

  static BoxDecoration circularInputField(
      {Color borderColor = Colors.black,
        Color backColor = Colors.white,
        double border = 25}) {
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
