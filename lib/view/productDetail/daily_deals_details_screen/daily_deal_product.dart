import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/common/common_appBar.dart';
import 'package:humble_warrior/utils/search_bar/search_bar_ui.dart';
import 'package:humble_warrior/view/home_option/common_home_option.dart';

import '../../../modals/response/donna_deals_response.dart';
import '../../home_option/tab_screens/donnas_deals.dart';
import '../product_detail_widget.dart';
import 'daily_deal_product_controller.dart';

class DailyDealProduct extends StatelessWidget with ProductDetailWidget {
  DailyDealProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DailyDealProductController controller = Get.find();
    final DonnaDealsDetails donnaDealsDetails = Get.arguments[0];
    return Scaffold(
      appBar: CommonAppBar().AppBarWidget(
        showBackButton: true,
        title: CustomSearchBar(
          focusNode: controller.focusNode,
          textEditingController: controller.searchTextController,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: donnaDealsCard(donnaDealsDetails, 0, context),
            ),
            productText(context, donnaDealsDetails.dealName),
            productDescription(),
          ],
        ),
      ),
    );
  }
}
