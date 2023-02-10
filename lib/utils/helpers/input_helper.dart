import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';

abstract class InputHelper {
  static const int phoneLength = 14;

  static List<TextInputFormatter> phoneFormatter = [
    FilteringTextInputFormatter.digitsOnly,
    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
    _PhoneNumberFormatter(),
  ];

  static List<TextInputFormatter> emailFormatter = [
    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9.-@_]")),
    FilteringTextInputFormatter.deny(RegExp('[<>?\\/|=;:]')),
  ];

  static List<TextInputFormatter> passwordFormatter = [
    FilteringTextInputFormatter.deny(RegExp(' ')),
  ];

  static List<TextInputFormatter> zipQuantityDis = [
    FilteringTextInputFormatter.digitsOnly,
  ];

  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) return "*Required";
    if (!value.isValidEmail()) return "Invalid Email ID";
    return null;
  }

  static String? zipValidator(String? value) {
    if (value == null || value.trim().isEmpty) return "*Required";
    if (value.trim().length < 5) return "Enter valid zipcode";
    return null;
  }

  static String? quentityDistance(String? value) {
    if (value == null || value.trim().isEmpty) return "*Required";
    if (double.parse(value.trim()) <= 0) return "Enter a value greater than 0";
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) return "*Required";
    if (value.length < phoneLength) {
      return "Length should be ${phoneLength - 4}";
    }
    if (!value.isValidPhone()) return "Invalid Phone Number";
    return null;
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();

    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write('${newValue.text.substring(0, usedSubstringIndex = 3)}) ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write('${newValue.text.substring(3, usedSubstringIndex = 6)}-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write('${newValue.text.substring(6, usedSubstringIndex = 10)} ');
      if (newValue.selection.end >= 10) selectionIndex++;
    }

    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
