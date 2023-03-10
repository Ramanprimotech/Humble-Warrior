import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/network/endpoints.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/common/refresh_Indicator.dart';
import 'package:humble_warrior/utils/future_widget/abstract_future_widget.dart';
import 'package:humble_warrior/view/home_option/tab_screens/donnas_deals.dart';
import 'package:humble_warrior/view/productDetail/daily_deals_details_screen/daily_deal_product_controller.dart';
import 'package:humble_warrior/view/productDetail/product_detail_widget.dart';

class DailyDealsAPIWidgets extends FutureAPI<List<ProductDetailsResponse>>
    with ProductDetailWidget {
  final BuildContext context;

  DailyDealsAPIWidgets({required this.context});

  final double productHeight = 60;
  final double brandLoveHeight = 55;
  final double brandHeight = 60;

  final DailyDealProductController controller = Get.find();

  @override
  Widget error({Object? error}) {
    return Expanded(
      child: CommonWidgets.errorAPI(
          buttonTitle: retryTxt,
          errorText: error.toString(),
          context: context,
          onPress: () => controller.update([Endpoints.productDetails])),
    );
  }

  @override
  Widget success({List<ProductDetailsResponse>? data}) {
    List<ProductDetailsResponse> record = data ?? [];
    return Expanded(
      child: CustomRefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 2), () {
            return Future.value(0);
          });
        },
        child: productDetails(details: record[0], index: 0),
      ),
    );
  }

  @override
  Widget waiting() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          AppText(
            "  Loading Product Details....",
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ],
      ),
    );
  }

  /// Home Options
  Widget productDetails(
      {required ProductDetailsResponse details, required int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: donnaDealsCard(details, 0, context),
            ),
            productText(context, details.itemName.toString()),
            productDescription(
                discription: details.productDescription.toString(),
                itemName: details.itemName.toString()),
          ],
        ),
      ),
    );
  }
}
