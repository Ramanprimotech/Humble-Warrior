import 'package:flutter/material.dart';

class AppIcons {
  // IconData

  //Bottom Navigation ==============>
  static Icon home() => const Icon(Icons.home);
  static Icon category() => const Icon(Icons.category);
  static Icon list() => const Icon(Icons.list);
  static Icon search() => const Icon(Icons.search);
  static Icon saved() => const Icon(Icons.bookmark_border);
  static Icon person() => const Icon(Icons.person);
  //<=========== Bottom Navigation

  //Action Bar ===========>
  static Icon refresh({Color iconColor = Colors.black}) => Icon(Icons.refresh , color: iconColor ,);
  static Icon share({Color iconColor = Colors.black}) => Icon(Icons.share , color: iconColor ,);
  static Icon sort({Color iconColor = Colors.black}) => Icon(Icons.sort , color: iconColor);
  static Icon notification({Color iconColor = Colors.black}) => Icon(Icons.notifications_none_rounded , color: iconColor);
  //<=========Action Bar

  //Account Icons===========>
  static Icon accountIcon({Color iconColor = Colors.black}) => Icon(Icons.login , color: iconColor);
  static Icon rightArrow({Color iconColor = Colors.black}) => Icon(Icons.chevron_right , color: iconColor);
  static Icon backArrow({Color iconColor = Colors.black, double size = 24}) => Icon(Icons.arrow_back ,size: size , color: iconColor);
  static Icon cross({Color iconColor = Colors.black, double size = 24}) => Icon(Icons.highlight_off,size: size , color: iconColor);
  //<===========Account Icons

  static Icon clock({Color iconColor = Colors.black}) => Icon(Icons.timer , color: iconColor);
  static Icon heart({Color iconColor = Colors.black}) => Icon(Icons.favorite_outlined , color: iconColor);
  static Icon share2({Color iconColor = Colors.blue}) => Icon(Icons.share , color: iconColor);
  static Icon comment({Color iconColor = Colors.white}) => Icon(Icons.messenger_outline , color: iconColor);
  static Icon language({Color iconColor = Colors.black}) => Icon(Icons.language , color: iconColor);
  static Icon google({Color iconColor = Colors.white}) => Icon(Icons.g_mobiledata , color: iconColor);
  static Icon facebook({Color iconColor = Colors.white}) => Icon(Icons.facebook , color: iconColor);
  static Icon edit({Color iconColor = Colors.black, double size = 24}) => Icon(Icons.edit,size: size , color: iconColor);

}
