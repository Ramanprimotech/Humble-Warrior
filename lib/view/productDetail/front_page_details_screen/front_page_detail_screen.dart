import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/product_details_response.dart';
import 'package:humble_warrior/utils/common/common_appBar.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/view/productDetail/front_page_details_screen/front_page_detail_controller.dart';
import 'package:humble_warrior/view/productDetail/product_detail_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/search_bar/search_bar_ui.dart';
import '../../home_option/tab_screens/front_page_deals.dart';

class FrontPageDetailScreen extends StatelessWidget with ProductDetailWidget {
  FrontPageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FrontPageDetailController controller = Get.find();
    final ProductDetailsResponse details = Get.arguments[0];
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
              padding: 8.ph,
              child: frontPageCard(details, 0, context),
            ),
            productText(context, details.itemName),
            productDescription(details.itemName!, details.productDescription!),
          ],
        ).p(10),
      ),
    );
  }
}
