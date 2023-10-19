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

  // /// Wish List
  // deleteItem(String id) {
  //   List key = findKey(id);
  //   for (var element in key) {
  //     box.delete(element);
  //   }
  // }

  // getWishList() {
  //   var data = box.values;
  //   return data;
  // }

  // addToWishList(ProductDetailsResponse item) {
  //   box.add(item);
  // }


  // findKey(String id) {
  //   List<dynamic> key = box.keys
  //       .where((element) => box.get(element)!.id.toString() == id)
  //       .toList();
  //
  //   return key;
  // }

  // hasItem(String id) {
  //   int listLength = box.values.where((element) {
  //     return element.id.toString() == id.toString();
  //   }).length;
  //   bool isIt = listLength != 0;
  //   return isIt;
  // }

  // favourite({required ProductDetailsResponse item}) {
  //   if (hasItem(
  //     item.id.toString(),
  //   )) {
  //     deleteItem(item.id.toString());
  //   } else {
  //     addToWishList(item);
  //   }
  // }

  /// Recent
  deleteRecentItem(String search) {
    List key = findRecentKey(search);
    for (var element in key) {
      log("$element", name: "Delete");
      recentBox.delete(element);
    }
  }

  deleteRecentItemByKey(dynamic key) {
    recentBox.delete(key);
  }

  getRecentList() async {
    dynamic data = recentBox.toMap();
    return data;
  }

  addToRecentList(RecentSearch item) {
    // box.put(item.id.toString(), item);
    recentBox.add(item);
  }

  findRecentKey(String id) {
    List<dynamic> key = recentBox.keys
        .where((element) =>
            recentBox.get(element)!.productSearched.toString().toLowerCase() ==
            id.toLowerCase())
        .toList();

    return key;
  }

  hasRecentItem(String search) {
    int listLength = recentBox.values.where((element) {
      return element.productSearched.toString().toLowerCase() ==
          search.toString().toLowerCase();
    }).length;
    bool isIt = listLength != 0;
    return isIt;
  }

  recentFavourite({required RecentSearch item}) {
    if (hasRecentItem(
      item.productSearched.toString(),
    )) {
      List keys = findRecentKey(item.productSearched!.toString());
      for (var element in keys) {
        log("${element}", name: "Recent Item");
        deleteRecentItemByKey(element);
      }
      // deleteRecentItem(item.productSearched!.toString());
      addToRecentList(item);
    } else {
      addToRecentList(item);
    }
  }
  // getRecentList() {
  //   var data = recentBox.toMap();
  //   data.forEach((key, element) {});
  //   return data;
  // }
  //
  // deleteRecentSearchItem(String id) {
  //   bool isIt = recentBox.containsKey(id);
  //
  //   recentBox.delete(id);
  // }
  //
  // addToRecentList(RecentSearch item) {
  //   if (item.productSearched!.isNotEmpty) {
  //     recentBox.put(item.productSearched, item);
  //   }
  // }

  @override
  void onClose() {
    box.close();
    recentBox.close();
    super.onClose();
  }
}
