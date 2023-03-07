import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:humble_warrior/modals/response/product_details_response.dart';

class HiveService extends GetxController {
  late Box<ProductDetailsResponse> box;
  @override
  void onInit() async {
    await Hive.initFlutter();
    // Hive.registerAdapter(ProductDetailsResponseAdapter());
    box = await Hive.openBox("Wishlist");
    // addToWishList();
    super.onInit();
  }

  deleteItem(String id) {
    box
        .delete(id)
        .then((value) => log("Deleted $id", name: "Wish Keys Deleted"));
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

  addToWishList(ProductDetailsResponse item) {
    box.put(item.id.toString(), item);
    log("${hasItem(item.id.toString())}", name: "Has List Keys");

    // box.l
    // getWishList();
  }

  hasItem(String id) {
    bool isIt = box.containsKey(id);
    log(isIt.toString(), name: "Do contain key");
    return isIt;
  }

  favourite({required ProductDetailsResponse item}) {
    if (hasItem(
      item.id.toString(),
    )) {
      deleteItem(item.id.toString());
    } else {
      addToWishList(item);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
