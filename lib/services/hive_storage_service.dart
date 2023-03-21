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
    box.delete(id);
  }

  getWishList() {
    var data = box.values;
    return data;
  }

  addToWishList(ProductDetailsResponse item) {
    box.put(item.id.toString(), item);
  }

  hasItem(String id) {
    bool isIt = box.containsKey(id);
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

    recentBox.delete(id);
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
