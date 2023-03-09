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
    final int donnaDealsDetails = Get.arguments[0];
    return Scaffold(
      appBar: CommonAppBar().AppBarWidget(
        showBackButton: true,
        title: CustomSearchBar(
          focusNode: controller.focusNode,
          textEditingController: controller.searchTextController,
        ),
      ),
      // body: SingleChildScrollView(
      //
      //
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding:
      //             const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      //         child: donnaDealsCard(donnaDealsDetails, 0, context, dailyDeals: true),
      //       ),
      //       productText(context, donnaDealsDetails.itemName),
      //       productDescription(
      //           discription: donnaDealsDetails.productDescription,
      //           itemName: donnaDealsDetails.itemName),
      //     ],
      //   ),
      // ),
    );
  }
}
