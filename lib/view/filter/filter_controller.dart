import '../../hw.dart';
import '../../modals/response/product_category_response.dart';

class FilterController extends GetxController {
  RxList record = <ProductCategoryItem>[].obs;
  RxBool selevtedVisibility = false.obs;

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

    update();
  }

  bool containItem(ProductCategoryItem item) {
    bool value = record.value.contains(item) ? true : false;
    return value;
  }

  void removeFromWish(ProductCategoryItem item) {
    record.value.remove(item);
    update();
  }

  @override
  void onInit() {
    scrollControllerListener();
    super.onInit();
  }

  void showCategories() {
    selevtedVisibility.value = !selevtedVisibility.value;
    update();
  }

  void resetList() {
    record.clear();
    update();
  }

  void showResult() {
    Get.back(result: record.value);
  }
}
