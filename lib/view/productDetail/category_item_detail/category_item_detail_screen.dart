import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/decorations.dart';
import 'package:humble_warrior/view/home_option/common_home_option.dart';
import 'package:humble_warrior/view/productDetail/category_item_detail/category_item_detail_controller.dart';
import 'package:humble_warrior/view/productDetail/product_detail_widget.dart';

class CategoryItemDetail extends StatelessWidget with ProductDetailWidget {
  CategoryItemDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryItemDetailController controller = Get.find();
    final ProductDetailsResponse donnaDealsDetails = Get.arguments[0];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonWidgets.titleBar(context,
                title: "Product Details", fontSize: 20, backIcon: true),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20),
                      child: categoryListCard(donnaDealsDetails, 0, context,
                          categoryCard: false, isDetails: true),
                    ),
                    productTitleDetail(context, donnaDealsDetails.itemName),
                    productDesc(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productTitleDetail(context, title) {
    return Container(
      decoration: CustomBoxDecorations().shadow(context: context),
      width: MediaQuery.of(Get.context!).size.width * .9,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: AppText(
        "$title",
        fontWeight: FontWeight.bold,
        fontSize: 20,
        maxLines: 3,
      ),
    );
  }

  /// Product Description
  Widget productDesc() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: MediaQuery.of(Get.context!).size.width * .9,
      child: const AppText(
        AppStrings.lorem,
        fontSize: 16,
        maxLines: 150,
      ),
    );
  }
}
