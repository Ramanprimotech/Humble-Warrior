import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/brands_response_mdel.dart';
import 'package:humble_warrior/modals/response/home_categories_response_model.dart';
import 'package:humble_warrior/modals/response/product_category_response.dart';
import 'package:humble_warrior/network/api_call.dart';

class HomeScreenController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();

  ///----Scroll Controllers
  final ScrollController brandScrollController =
      ScrollController(initialScrollOffset: 0.0);
  final ScrollController productScrollController =
      ScrollController(initialScrollOffset: 0.0);

  /// Scroll Controller Icons Visibility
  RxBool listBack = false.obs;
  RxBool listForward = true.obs;
  RxBool brandListBack = false.obs;
  RxBool brandListForward = true.obs;

  final FocusNode focusNode = FocusNode();
  ValueNotifier<bool> keyboardIsOpened = ValueNotifier(true);

  void getKeyBoard(BuildContext context) {
    keyboardIsOpened.value =
        (MediaQuery.of(Get.context!).viewInsets.bottom != 0.0);
  }

  @override
  void onInit() {
    scrollControllerListener();
    focusNode.addListener(() {
      getKeyBoard(Get.context!);
    });
    super.onInit();
  }

  void scrollControllerListener() {
    productScrollController.addListener(() {
      listForward.value =
          productScrollController.position.maxScrollExtent - 40 >
              productScrollController.offset;
      listBack.value = productScrollController.offset >
          productScrollController.initialScrollOffset + 40;
    });

    brandScrollController.addListener(() {
      brandListForward.value = brandScrollController.offset !=
          brandScrollController.position.maxScrollExtent;
      brandListBack.value = brandScrollController.offset !=
          brandScrollController.initialScrollOffset;
    });
  }

  Future<List<BrandDetails>> allBrands() async {
    return CallAPI.allBrands();
  }

  Future<List<ProductCategoryItem>> productCategoryAPI() async {
    return CallAPI.productCategoryAPI();
  }

  Future<List<HomeCategoryList>> homeCategories() async {
    return await CallAPI.homeCategory();
  }
}
