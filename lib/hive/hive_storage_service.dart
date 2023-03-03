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
    // addToWishList();
    super.onInit();
  }

  deleteItem(String id) {
    box.delete(id);
    log("Deleted $id", name: "Wish Keys Deleted");
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

  addToWishList(Wishlistitem item) {
    box.put(item.productId, item);
    // box.l
    getWishList();
  }

  hasItem(String id) {
    bool isIt = box.containsKey(id);
    log(isIt.toString(), name: "Do contain key");
    return isIt;
  }

  removeFromWishList() {}

  @override
  void onClose() {
    super.onClose();
  }
}
