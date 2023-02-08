import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeOptionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  RxInt selectedIndex = 0.obs;
  int initialIndex = Get.arguments[0];
  @override
  void onInit() {
    print(initialIndex);
    tabController =
        TabController(length: 3, initialIndex: initialIndex, vsync: this);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
