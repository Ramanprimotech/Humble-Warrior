import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/common/common_appBar.dart';
import 'package:humble_warrior/utils/search_bar/search_bar_ui.dart';
import '../product_detail_widget.dart';
import 'daily_deal_product_controller.dart';

class DailyDealProduct extends StatelessWidget with ProductDetailWidget {
  DailyDealProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DailyDealProductController controller = Get.find();
    return Scaffold(
      appBar: CommonAppBar().AppBarWidget(
        showBackButton: true,
        title: CustomSearchBar(
          focusNode: controller.focusNode,
          textEditingController: controller.searchTextController,
        ),
      ),
    );
  }
}
