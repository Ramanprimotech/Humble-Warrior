import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:humble_warrior/hive/wishlistitem.dart';

class HiveService extends GetxController {
  late Box<Wishlistitem> box;
  @override
  void onInit() async {
    await Hive.initFlutter();
    Hive.registerAdapter(WishlistitemAdapter());
    box = await Hive.openBox("wishlist");
    getWishList();
    // addToWishList();
    super.onInit();
  }

  getWishList() {
    // List<Wishlistitem> wishList = box.values.toList();
    // wishList.forEach((element) {
    //
    //   log("${element.toString()}", name: "Wish List Items");
    // });
    var data = box.toMap();
    data.forEach((key, element) {
      log("$key   ${element.toString()}", name: "Wish List Keys");
    });
  }

  addToWishList() {
    Wishlistitem item = Wishlistitem(
        image: "fdfdfdf",
        dealName: "sfdf",
        type: "Donna Deals",
        code: "code",
        productId: "product Id",
        shop: "Shop");
    box.add(item);
    // box.l
    getWishList();
  }

  removeFromWishList() {}

  @override
  void onClose() {
    super.onClose();
  }
}
