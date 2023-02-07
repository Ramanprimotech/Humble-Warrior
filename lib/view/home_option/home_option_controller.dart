import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/view/home/home_screen.dart';

class HomeOptionController extends GetxController with GetSingleTickerProviderStateMixin{
   late TabController tabController;
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
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
