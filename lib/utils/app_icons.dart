import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:humble_warrior/modals/response/product_details_response.dart';
import 'package:humble_warrior/services/hive_storage_service.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/image_path_assets.dart';

class AppIcons {
  // IconData

  //Bottom Navigation ==============>
  // static Icon home() => const Icon(Icons.home);

  // static Icon favourite(BuildContext context) => Icon(Icons.favorite_outlined,color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,);

  static Image favourite(BuildContext context) => Image.asset(
        ImagePathAssets.heartIcon,
        height: 20,
        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      );

  static Image unselectedfavourite(BuildContext context, Color color) =>
      Image.asset(
        ImagePathAssets.heartIcon,
        height: 20,
        color: color,
        // color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      );

  static Icon bag() => const Icon(Icons.shopping_bag);

  static Image check(BuildContext context) => Image.asset(
        ImagePathAssets.amazonIcon,
        height: 22,
        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      );

  static Image unselectedCheck(BuildContext context, Color color) =>
      Image.asset(
        ImagePathAssets.amazonIcon,
        height: 20,
        color: color,
      );

  static Image home(BuildContext context) => Image.asset(
        ImagePathAssets.homeIcon,
        height: 20,
        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      );

  static Image unselectedHome(BuildContext context, Color color) => Image.asset(
        ImagePathAssets.homeIcon,
        height: 20,
        color: color,
      );

  static Image notification(BuildContext context) => Image.asset(
        ImagePathAssets.notificationIcon,
        height: 40,
        width: 30,
      );

  static Image join(BuildContext context) => Image.asset(
        ImagePathAssets.facebookIcon,
        height: 20,
        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      );

  static Image unselectedJoin(BuildContext context, Color color) => Image.asset(
        ImagePathAssets.facebookIcon,
        height: 20,
        color: color,
      );

  static Image person(BuildContext context) => Image.asset(
        ImagePathAssets.personIcon,
        height: 20,
        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      );

  static Image unselectedPerson(BuildContext context, Color color) =>
      Image.asset(
        ImagePathAssets.personIcon,
        height: 20,
        color: color,
      );

  // static Icon join(BuildContext context) =>  Icon(Icons.facebook, color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,);

  // static Icon person(BuildContext context) =>  Icon(Icons.person, color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,);

  //<=========== Bottom Navigation

  //Action Bar ===========>
  static Icon refresh({Color iconColor = Colors.black}) => Icon(
        Icons.refresh,
        color: iconColor,
      );

  static Icon share({iconColor = Colors.black}) => Icon(
        Icons.share,
        color: iconColor,
      );

  static Icon sort({Color? iconColor}) => Icon(Icons.sort, color: iconColor);

  static Icon notificationActive({Color? iconColor, double size = 24}) => Icon(
        Icons.notifications,
        color: iconColor,
        size: size,
      );

  static Icon filter({Color? iconColor, double size = 24}) => Icon(
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

  static Icon next({Color? iconColor}) => Icon(
        Icons.arrow_forward_ios,
        color: iconColor,
      );

  static Icon backArrrowIos({Color? iconColor}) => Icon(
        Icons.arrow_back_ios,
        color:
            iconColor ?? Theme.of(Get.context!).textTheme.displaySmall!.color!,
      );

  static IconButton IosBackIcon({Color? iconColor, Function()? onPress}) =>
      IconButton(
        padding: 20.pl,
        icon: backArrrowIos(),
        onPressed: onPress ??
            () {
              Get.back();
            },
      );

  static Icon backArrow({Color? iconColor, double size = 24}) =>
      Icon(Icons.arrow_back, size: size, color: iconColor);

  static Icon cross({Color iconColor = Colors.black, double size = 24}) =>
      Icon(Icons.highlight_off, size: size, color: iconColor);

  /// Account Icons

  static Icon clock({Color iconColor = Colors.black}) =>
      Icon(Icons.timer, color: iconColor);

  static Icon heart({Color iconColor = Colors.black, double? size}) => Icon(
        Icons.favorite_outlined,
        color: iconColor,
        size: size ?? 20,
      );

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

class Heart extends StatefulWidget {
  Heart(
      {super.key,
      this.color = Colors.black,
      required this.id,
      required this.item,
      required this.size,
      this.isSelected});

  final double? size;
  bool? isSelected = false;
  Color? color;
  String id;
  ProductDetailsResponse item;
  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HiveService service = Get.find<HiveService>();
    Box<ProductDetailsResponse> box = service.box;
    return ValueListenableBuilder(
      valueListenable: box.listenable(keys: [widget.item.id.toString()]),
      builder: (context, box, child) {
        log("${widget.item.itemName}   ${widget.id.toString()}",
            name: "Update Item");

        return GestureDetector(
          key: widget.key,
          onTap: () {
            service.favourite(item: widget.item);
          },
          child: Icon(
            Icons.favorite_outlined,
            color: service.hasItem(widget.item.id.toString())
                ? Colors.red
                : widget.color,
            size: widget.size ?? 20,
          ),
        );
      },
    );
  }
}
