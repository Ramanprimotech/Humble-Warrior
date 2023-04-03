import '../../hw.dart';
import '../../modals/response/product_category_response.dart';

class FilterController extends GetxController {
  RxList<ProductCategoryItem> record = <ProductCategoryItem>[].obs;
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
      listSelectedForward.value = selectedProductScrollController.offset !=
          selectedProductScrollController.position.maxScrollExtent;
      listSelectedBack.value = selectedProductScrollController.offset !=
          selectedProductScrollController.initialScrollOffset;
    });
  }

  void addToWish(ProductCategoryItem item) {
    if (record.value.contains(item)) {
      removeFromWish(item);
    } else {
      record.value.add(item);
    }

    if (record.value.length == 0) {
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
      if (record.value.length == 0) {
        selevtedVisibility.value = false;
      }
    }
    update();
  }

  @override
  void onInit() {
    scrollControllerListener();
    super.onInit();
  }

  void showCategories(BuildContext context) {
    FToast().init(context);
    if (record.value.isEmpty) {
      DialogHelper.showToast(context, "Please select at least one category");
    } else {
      selevtedVisibility.value = !selevtedVisibility.value;
      update();
    }
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
}
