import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/modals/hive_modal/recent_search_model.dart';

class HiveService extends GetxController {
  late Box<ProductDetailsResponse> box;
  late Box<RecentSearch> recentBox;
  @override
  void onInit() async {
    await Hive.initFlutter();
    box = await Hive.openBox("Wishlist");
    recentBox = await Hive.openBox("Recent");
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

  getRecentList() {
    var data = recentBox.toMap();
    data.forEach((key, element) {});
    return data;
  }

  deleteRecentSearchItem(String id) {
    bool isIt = recentBox.containsKey(id);
    log(isIt.toString(), name: "Do contain key");

    recentBox.delete(id).then(
        (value) => log("Deleted $id", name: "Recent Search Keys Deleted"));
  }

  addToRecentList(RecentSearch item) {
    recentBox.put(item.productSearched, item);
  }

  @override
  void onClose() {
    box.close();
    recentBox.close();
    super.onClose();
  }
}
