import 'package:flutter/material.dart';

extension Spacing on num {
  /// This provides Verticle Padding
  EdgeInsets get pv => EdgeInsets.symmetric(vertical: toDouble());

  /// This provides Top and Bottom padding
  /// You need to pass value as `Double`
  ///
  /// eg -
  /// - 2.3 [2 will be Top padding & 3 will be Bottom]
  EdgeInsets get ptb {
    List<double> nums = toString().split('.').map((e) => double.parse(e)).toList();
    return EdgeInsets.only(top: nums.first, bottom: nums.last);
  }

  /// This provides Left and Top padding
  /// You need to pass value as `Double`
  ///
  /// eg -
  /// - 2.3 [2 will be Left padding & 3 will be Top]
  EdgeInsets get plt {
    List<double> nums = toString().split('.').map((e) => double.parse(e)).toList();
    return EdgeInsets.only(left: nums.first, top: nums.last);
  }

  /// This provides Left and Right padding
  /// You need to pass value as `Double`
  ///
  /// eg -
  /// - 2.3 [2 will be Left padding & 3 will be Right]
  EdgeInsets get plr {
    List<double> nums = toString().split('.').map((e) => double.parse(e)).toList();
    return EdgeInsets.only(left: nums.first, right: nums.last);
  }

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
    List<double> nums = toString().split('.').map((e) => double.parse(e)).toList();
    return EdgeInsets.symmetric(horizontal: nums.first, vertical: nums.last);
  }

  /// This provides [SizedBox] of provided [height]
  SizedBox get sh => SizedBox(height: toDouble());

  /// This provides [SizedBox] of provided [width]
  SizedBox get sw => SizedBox(width: toDouble());

  /// This provides `BorderRadius.circular` of provided value
  BorderRadius get brc => BorderRadius.circular(toDouble());

  /// This provides `BorderRadius.top` of provided value
  BorderRadius get brt => BorderRadius.vertical(top: Radius.circular(toDouble()));

  /// This provides `BorderRadius.bottom` of provided value
  BorderRadius get brb => BorderRadius.vertical(bottom: Radius.circular(toDouble()));

  /// This provides [ShapeBorder] of provided value
  ShapeBorder get shape => RoundedRectangleBorder(borderRadius: brc);
}