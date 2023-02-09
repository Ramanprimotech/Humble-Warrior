import 'package:flutter/material.dart';

class AppIcons {
  // IconData

  //Bottom Navigation ==============>
  static Icon home() => const Icon(Icons.home);
  static Icon favourite() => const Icon(Icons.favorite_outlined);
  static Icon bag() => const Icon(Icons.shopping_bag);
  static Icon join() => const Icon(Icons.facebook);
  static Icon person() => const Icon(Icons.person_outlined);
  //<=========== Bottom Navigation

  //Action Bar ===========>
  static Icon refresh({Color iconColor = Colors.black}) => Icon(
        Icons.refresh,
        color: iconColor,
      );
  static Icon share({Color iconColor = Colors.black}) => Icon(
        Icons.share,
        color: iconColor,
      );
  static Icon sort({Color iconColor = Colors.black}) =>
      Icon(Icons.sort, color: iconColor);
  static Icon notification({Color iconColor = Colors.black}) =>
      Icon(Icons.notifications_none_rounded, color: iconColor);
  static Icon notificationActice(
          {Color iconColor = Colors.black, double size = 24}) =>
      Icon(
        Icons.notifications_active,
        color: iconColor,
        size: size,
      );
  static Icon filter({Color iconColor = Colors.black, double size = 24}) =>
      Icon(
        Icons.sort,
        color: iconColor,
        size: size,
      );
  //<=========Action Bar

  //Account Icons===========>
  static Icon accountIcon({Color iconColor = Colors.black}) =>
      Icon(Icons.login, color: iconColor);
  static Icon rightArrow({Color iconColor = Colors.black}) =>
      Icon(Icons.chevron_right, color: iconColor);
  static Icon backArrow({Color iconColor = Colors.black, double size = 24}) =>
      Icon(Icons.arrow_back, size: size, color: iconColor);
  static Icon cross({Color iconColor = Colors.black, double size = 24}) =>
      Icon(Icons.highlight_off, size: size, color: iconColor);
  //<===========Account Icons

  static Icon clock({Color iconColor = Colors.black}) =>
      Icon(Icons.timer, color: iconColor);

  static Icon heart({Color iconColor = Colors.black}) =>
      Icon(Icons.favorite_outlined, color: iconColor,size:16,);
  static Icon share2({Color iconColor = Colors.blue}) =>
      Icon(Icons.share, color: iconColor);
  static Icon comment({Color iconColor = Colors.black}) =>
      Icon(Icons.comment, color: iconColor);
  static Icon language({Color iconColor = Colors.black}) =>
      Icon(Icons.language, color: iconColor);
  static Icon google({Color iconColor = Colors.white}) =>
      Icon(Icons.g_mobiledata, color: iconColor);
  static Icon facebook({Color iconColor = Colors.white}) =>
      Icon(Icons.facebook, color: iconColor);
  static Icon bookmarks({Color iconColor = Colors.black}) =>
      Icon(Icons.bookmarks, color: iconColor);
  static Icon copy({Color iconColor = Colors.black}) =>
      Icon(Icons.copy, color: iconColor);
  static Icon edit({Color iconColor = Colors.black, double size = 24}) =>
      Icon(Icons.edit, size: size, color: iconColor);
  static Icon cut({Color iconColor = Colors.black, double size = 18}) =>
      Icon(Icons.cut, size: size, color: iconColor);
}
