import 'dart:convert';

import 'package:humble_warrior/view/search/api_services.dart';
import 'package:humble_warrior/view/search/model.dart';

import '../../hw.dart';

class FilterController extends GetxController {
  RxList<ProductCategoryItem> record = <ProductCategoryItem>[].obs;
  RxList<ProductCategoryItem> unSelectedRecords = <ProductCategoryItem>[].obs;
  TextEditingController controller = TextEditingController();
  String postType = "";
  late BuildContext context;
  RxBool selevtedVisibility = false.obs;
  int? catID;

  ///----Scroll Controllers
  final ScrollController productScrollController =
      ScrollController(initialScrollOffset: 0.0);

  final ScrollController selectedProductScrollController =
      ScrollController(initialScrollOffset: 0.0);

  /// Scroll Controller Icons Visibility
  RxBool listBack = false.obs;
  RxBool listForward = true.obs;
  RxBool listSelectedBack = false.obs;
  RxBool listSelectedForward = true.obs;

  /// Donna's Deals
  final RxInt searchsLength = 0.obs;
  final RxBool searchsBool = true.obs;
  List<ProductDetailsResponse> searchList = [];
  RxInt searchListLength = 0.obs;
  int searchsPage = 1;
  RxInt searchsTotalDeals = 20.obs;
  final ScrollController searchScrollController =
      ScrollController(initialScrollOffset: 0.0);

  /// Scroll Listener
  void scrollControllerListener() {
    productScrollController.addListener(() {
      listForward.value =
          productScrollController.position.maxScrollExtent - 40 >
              productScrollController.offset;
      listBack.value = productScrollController.offset >
          productScrollController.initialScrollOffset + 40;
    });

    selectedProductScrollController.addListener(() {
      listSelectedForward.value = selectedProductScrollController.position.maxScrollExtent - 40 >
          selectedProductScrollController.offset;
      listSelectedBack.value = selectedProductScrollController.offset !=
          selectedProductScrollController.initialScrollOffset;
    });
  }

  Future<List<ProductCategoryItem>> api() async {
    return productCategory;
  }

  void searchFromStart() {
    searchsBool.value = true;
    searchsPage = 1;
    searchsTotalDeals.value = 20;
    searchList.clear();
    update();
    searchsAPI();
  }

  Future searchsAPI({bool? refresh = false}) async {
    if (refresh!) {
      searchsPage = 1;
      searchList.clear();
    }
    List<int> catIds = getIntList();
    await FetchSearchList()
        .productDetails(catIds.isEmpty ? controller.text : "",
            searchsPage.toString(), postType, catIds)
        .then((value) {
      if (value.data == null) {
        DialogHelper.showToast(context, noMoreDealsTxt);
      } else {
        searchsPage += 1;
        searchList.addAll(value.data!);
        searchListLength.value = searchList.length;
        if (refresh) {
          DialogHelper.showToast(context, dealsRefreshTxt);
        }
      }
      if (value.totalRecords != null) {
        searchsTotalDeals.value = int.parse(value.totalRecords!);
      }
      searchsTotalDeals.log();
      searchsBool.value = false;
      update();
    });
  }

  Future filterAPI(List<int> catIds, {bool? refresh = false}) async {
    if (refresh!) {
      searchsPage = 1;
      searchList.clear();
    }

    await FetchSearchList()
        .productDetails(
            controller.text, searchsPage.toString(), postType, catIds)
        .then((value) {
      if (value.data == null) {
        DialogHelper.showToast(context, noMoreDealsTxt);
      } else {
        searchsPage += 1;
        searchList.addAll(value.data!);
        searchListLength.value = searchList.length;
        if (refresh) {
          DialogHelper.showToast(context, dealsRefreshTxt);
        }
      }
      if (value.totalRecords != null) {
        searchsTotalDeals.value = int.parse(value.totalRecords!);
      }
      searchsTotalDeals.log();
      searchsBool.value = false;
      update();
    });
  }

  void addToWish(ProductCategoryItem item) {
    if (record.value.contains(item)) {
      removeFromWish(item);
    } else {
      record.value.add(item);
    }

    if (record.value.isEmpty) {
      selevtedVisibility.value = false;
    }
    update();
  }

  bool containItem(ProductCategoryItem item) {
    bool value = record.value.contains(item) ? true : false;
    return value;
  }

  void removeFromWish(ProductCategoryItem item) {
    if (item.id != catID) {
      record.value.remove(item);
      if (record.value.isEmpty) {
        selevtedVisibility.value = false;
      }
    }
    update();
  }

  List<ProductCategoryItem> unSelectedList() {
    List<ProductCategoryItem> data = [];
    data.addAll(record.value.reversed);
    Iterable<ProductCategoryItem> unselectedData =
        productCategory.where((element) {
      bool isIt = !containItem(element);
      return isIt;
    });
    data.addAll(unselectedData);
    unSelectedRecords.value = data;
    // selectedProductScrollController.animateTo(1.0,
    //     duration: const Duration(microseconds: 1600), curve: Curves.ease);
        update();
    return data;
  }

  @override
  void onInit() {
    scrollControllerListener();
    searchsAPI();
    super.onInit();
  }

  void showCategories(BuildContext context) {
    FToast().init(context);
    if (record.value.isEmpty) {
      DialogHelper.showToast(context, selectCategoryTxt);
    } else {
      selevtedVisibility.value = true;
    }
    update();
    update(["search"]);
  }

  void resetList() {
    if (catID != null) {
      for (var i = record.length - 1; i >= 0; i--) {
        if (record[i].id != catID) {
          record.value.remove(record[i]);
        }
      }
    } else {
      record.clear();
      selevtedVisibility.value = false;
    }
    update();
  }

  void showResult() {
    Get.back(result: record.value);
  }

  List<int> getIntList() {
    List<int> values = [];
    record.value.forEach((e) => values.add(e.id!));
    return values;
  }

  @override
  void onClose() {
    controller.dispose();
    productScrollController.dispose();
    selectedProductScrollController.dispose();
    searchScrollController.dispose();
    super.onClose();
  }

// SortItem sort() {
//   if (!_sortController.checkFilter()) {
//     return const SortItem(itemnName: "", itemValue: "", type: "");
//   } else {
//     return _sortController
//         .filterData[_sortController.headerIndex.value].subHeader[
//     _sortController
//         .filterData[_sortController.headerIndex.value].selected!];
//   }
// }
}
