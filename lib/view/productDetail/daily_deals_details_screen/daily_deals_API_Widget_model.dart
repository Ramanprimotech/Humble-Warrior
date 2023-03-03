import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/product_details_response.dart';
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
    //   Padding(
    //   padding: const EdgeInsets.only(top: 80.0, left: 30, right: 30),
    //   child: Container(
    //     height: 200,
    //     width: Get.width,
    //     // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //     padding: 20.ps,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10),
    //       color: dialogueThemeExtention.backGroundColor,
    //       boxShadow: [
    //         BoxShadow(
    //             color: dialogueThemeExtention.shadow!,
    //             spreadRadius: 2,
    //             blurRadius: 2,
    //             offset: Offset(0, 0))
    //       ],
    //     ),
    //     child: Column(children: [
    //       AppText(error.toString(), maxLines: 5, fontSize: 20),
    //       20.sh,
    //       ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //           elevation: 5,
    //           // fixedSize: const Size(, 35),
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(10)),
    //           backgroundColor: dialogueThemeExtention.buttonColor,
    //         ),
    //         onPressed: () {
    //           controller.update([Endpoints.homeCategories]);
    //         },
    //         child: const AppText('Retry',
    //             color: Colors.white, fontWeight: FontWeight.bold),
    //       ),
    //     ]),
    //   ),
    // );
  }

  @override
  Widget success({List<ProductDetailsResponse>? data}) {
    List<ProductDetailsResponse> dataa = data ?? [];
    // return Placeholder(
    //   color: Colors.red,
    // );
    return Expanded(
      child: CustomRefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2), () {
            return Future.value(0);
          });
        },
        child: productDetails(details: dataa[0], index: 0),
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
            productDescription(details.productDescription.toString(),
                details.itemName.toString()),
          ],
        ),
      ),
    );
  }
}
