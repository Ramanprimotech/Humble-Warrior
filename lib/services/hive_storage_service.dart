import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:humble_warrior/modals/response/product_details_response.dart';

class HiveService extends GetxController {
  late Box<ProductDetailsResponse> box;
  @override
  void onInit() async {
    await Hive.initFlutter();
    box = await Hive.openBox("Wishlist");
    super.onInit();
  }

  deleteItem(String id) {
    box
        .delete(id)
        .then((value) => log("Deleted $id", name: "Wish Keys Deleted"));
  }

  getWishList() {
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
    box.close();
    super.onClose();
  }
}
