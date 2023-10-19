import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';

import '../modals/hive_modal/wish_list_model.dart';
import '../utils/app_strings.dart';
import '../utils/shared_preference/shared_pref.dart';

class WishlistStorageService extends GetxController {
  late Box<WishListModel> wishlistBox;

  @override
  void onInit() async {
    await Hive.initFlutter();
    wishlistBox = await Hive.openBox("WishlistData");
    _mergeOldInNewDB();
    super.onInit();
  }

  /// Retrieve existing data from the mobile device and merge it into a new database.
  _mergeOldInNewDB() async{
    final loginId = await SharePreferenceData.getStringValuesSF(spRegisterUserId);
    final Box<ProductDetailsResponse> oldWishlistBox = await Hive.openBox('Wishlist');

    if (loginId != null && oldWishlistBox.isBlank == false) {
      for (var item in oldWishlistBox.values) {
        wishlistBox.add(WishListModel(loginId,item));
      }
    }
    oldWishlistBox.clear();
    await oldWishlistBox.close();
  }


  /// Wish List
  Future<List<ProductDetailsResponse>> getWishList() async{
    final userId = await SharePreferenceData.getStringValuesSF(spRegisterUserId) ?? "-1";
    print("ghhsdgfhsgfs ${wishlistBox.values.where((element) => element.userid.toString() == userId.toString())}");
    return wishlistBox.values.where((element) => element.userid.toString() == userId.toString() && element.item != null).map((e) => e.item!).toList();
  }

  _addToWishList(ProductDetailsResponse item) async{
    final userId = await SharePreferenceData.getStringValuesSF(spRegisterUserId) ?? "-1";
    await wishlistBox.add(WishListModel(userId,item));
  }


  clearAllUserData() async{
    final userId = await SharePreferenceData.getStringValuesSF(spRegisterUserId) ?? "-1";
    final keysToDelete = <int>[];
    for (var key in wishlistBox.keys) {
      final item = wishlistBox.get(key);
      if (item?.userid == userId) {
        keysToDelete.add(key);
      }
    }
    for (var key in keysToDelete) {
      await wishlistBox.delete(key);
    }
  }

  _deleteItem(String id) {
    List key = _findKey(id);
    for (var element in key) {
      wishlistBox.delete(element);
    }
  }

  _findKey(String id) {
    List<dynamic> key = wishlistBox.keys
        .where((element) => wishlistBox.get(element)?.item?.id.toString() == id)
        .toList();

    return key;
  }

  Future<bool> hasItem(String id) async{
    final userId = await SharePreferenceData.getStringValuesSF(spRegisterUserId) ?? "-1";
    return wishlistBox.values.where((element) {
      return element.item?.id.toString() == id.toString() && element.userid == userId;
    }).isNotEmpty;
  }

  favourite({required ProductDetailsResponse item}) async{
    if (await hasItem(item.id.toString())) {
      _deleteItem(item.id.toString());
    } else {
      _addToWishList(item);
    }
  }


  @override
  void onClose() {
    wishlistBox.close();
    super.onClose();
  }
}
