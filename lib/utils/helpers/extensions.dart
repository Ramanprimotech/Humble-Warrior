import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:flutter/widgets.dart';

extension Validator on String {
  bool isValidEmail() {
    if (trim().isEmpty) {
      return false;
    }
    RegExp exp = RegExp(r"^[\w.\-]+@[\w]+\.[a-zA-Z]{2,}(\.[a-zA-Z]{2,})?$");
    bool result = exp.hasMatch(trim());
    return result;
  }

  bool isValidPhone() {
    if (trim().isEmpty) {
      return false;
    }
    RegExp exp = RegExp(r"\([2-9]\d{2}\)\s\d{3}-\d{4}");
    bool result = exp.hasMatch(trim());
    return result;
  }
}

extension Spacing on num {
  /// This provides Verticle Padding
  EdgeInsets get pv => EdgeInsets.symmetric(vertical: toDouble());

  /// This provides Horizontal Padding
  EdgeInsets get ph => EdgeInsets.symmetric(horizontal: toDouble());

  /// This provides All Side Padding
  EdgeInsets get pa => EdgeInsets.all(toDouble());

  /// This provides Left Side Padding
  EdgeInsets get pl => EdgeInsets.only(left: toDouble());

  /// This provides Right Side Padding
  EdgeInsets get pr => EdgeInsets.only(right: toDouble());

  /// This provides Top Side Padding
  EdgeInsets get pt => EdgeInsets.only(top: toDouble());

  /// This provides Bottom Side Padding
  EdgeInsets get pb => EdgeInsets.only(bottom: toDouble());

  /// This provides Symmetric padding
  /// You need to pass value as `Double`
  ///
  /// eg -
  /// - 2.3 [2 will be horizontal padding & 3 will be verticle]
  EdgeInsets get ps {
    List<double> nums =
        toString().split('.').map((e) => double.parse(e)).toList();
    return EdgeInsets.symmetric(horizontal: nums.first, vertical: nums.last);
  }

  /// This provides [SizedBox] of provided [height]
  SizedBox get sh => SizedBox(height: toDouble());

  /// This provides [SizedBox] of provided [width]
  SizedBox get sw => SizedBox(width: toDouble());

  /// This provides [BorderRadius] of provided value
  BorderRadius get br => BorderRadius.circular(toDouble());
}

extension Logging on Object {
  void log() => dev.log(toString());
}
