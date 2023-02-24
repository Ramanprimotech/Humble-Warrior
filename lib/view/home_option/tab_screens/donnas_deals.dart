import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/donna_deals_response.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/common/common_pagination.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';

import '../common_home_option.dart';
import '../home_options_main/home_option_controller.dart';

class DonnaDailyDeals extends StatelessWidget {
  const DonnaDailyDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeOptionController controller = Get.find();

    return PaginationWidget(
      length: controller.donnaDealListLength,
      apiBool: controller.donnaDealsBool,
      api: controller.donaDealsAPI,
      update: controller.update,
      scrollController: controller.donnaDealScrollController,
      totalRecords: controller.donnaDealsTotalDeals,
      child: GetBuilder<HomeOptionController>(
        init: controller,
        builder: (ctx) {
          if (controller.donnaDealList.isEmpty &&
              controller.donnaDealsBool.value == true) {
            return Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                CommonWidgets.loading(),
              ],
            ));
          }
          if (controller.donnaDealList.isEmpty &&
              controller.donnaDealsBool.value == false) {
            return CommonWidgets.noData();
          }
          return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              controller: controller.donnaDealScrollController,
              itemCount: controller.donnaDealList.length + 1,
              itemBuilder: (ctx, index) {
                DonnaDealsDetails details = DonnaDealsDetails();
                if (index != controller.donnaDealList.length) {
                  details = controller.donnaDealList[index];
                }
                return Padding(
                  padding: 8.pa,
                  child: index != controller.donnaDealList.length
                      ? donnaDealsCard(details, index)
                      : Obx(
                          () => Visibility(
                              visible: controller.donnaDealsBool.value,
                              child: Container(
                                  height: 80,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator())),
                        ),
                );
              });
        },
      ),
    );
    // return NotificationListener<ScrollNotification>(
    //   onNotification: (ScrollNotification scrollInfo) {
    //     if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
    //       // onLoadMore();
    //       print("object");
    //       if (controller.donnaDealsBool == false) {
    //         controller.donnaDealsBool.value = true;
    //         controller.update();
    //         Future.delayed(Duration(milliseconds: 10), () {
    //           controller.donnaDealScrollController.animateTo(
    //             controller.donnaDealScrollController.position.maxScrollExtent,
    //             duration: Duration(milliseconds: 500),
    //             curve: Curves.fastOutSlowIn,
    //           );
    //         });
    //
    //         controller.donaDealsAPI();
    //       }
    //     }
    //     return true;
    //   },
    //   child: GetBuilder<HomeOptionController>(
    //     init: controller,
    //     builder: (ctx) {
    //       if (controller.donnaDealList.isEmpty &&
    //           controller.donnaDealsBool.value == true) {
    //         return Center(
    //             child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: const [
    //             CircularProgressIndicator(),
    //             AppText(
    //               " Loading Deals for you...",
    //               fontSize: 24,
    //               fontWeight: FontWeight.w700,
    //             ),
    //           ],
    //         ));
    //       }
    //       if (controller.donnaDealList.isEmpty &&
    //           controller.donnaDealsBool.value == false) {
    //         return const Center(
    //           child: AppText(
    //             "No Data Found",
    //             fontSize: 24,
    //             fontWeight: FontWeight.w700,
    //           ),
    //         );
    //       }
    //       return ListView.builder(
    //           controller: controller.donnaDealScrollController,
    //           itemCount: controller.donnaDealList.length + 1,
    //           itemBuilder: (ctx, index) {
    //             DonnaDealsDetails details = DonnaDealsDetails();
    //             if (index != controller.donnaDealList.length) {
    //               details = controller.donnaDealList[index];
    //             }
    //             return Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: index != controller.donnaDealList.length
    //                   ? ItemCard(
    //                       buttons: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                         children: [
    //                           shopButton(url: "${details.shopUrl}"),
    //                           !(details.couponCode == null ||
    //                                   details.couponCode == "")
    //                               ? codeButton(code: "${details.couponCode}")
    //                               : const SizedBox(
    //                                   width: 80,
    //                                 ),
    //                           shareButton(shareUrl: "shareUrl"),
    //                           IconButton(
    //                             onPressed: () {},
    //                             icon: AppIcons.bookmarks(),
    //                           ),
    //                         ],
    //                       ),
    //                       imageUrl: details.url!,
    //                       title: details.dealName!,
    //                     )
    //                   : Obx(
    //                       () => Visibility(
    //                           visible: controller.donnaDealsBool.value,
    //                           child: Container(
    //                               height: 80,
    //                               alignment: Alignment.center,
    //                               child: CircularProgressIndicator())),
    //                     ),
    //             );
    //           });
    //     },
    //   ),
    // );
  }
}

ItemCard donnaDealsCard(DonnaDealsDetails details, int index) {
  return ItemCard(
    onTap: () {
      Get.toNamed(AppRoutes.dailyDealProductDetail, arguments: [details]);
    },
    radius: 10,
    buttons: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: 8.pl,
              child: shopButton(
                  url: "${details.shopUrl}", title: details.dealName!),
            ),
            !(details.couponCode == null || details.couponCode == "")
                ? codeButton(code: "${details.couponCode}")
                : 80.sw,
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                // controller.select.value = !controller.select.value;
              },
              icon: Heart(
                key: Key(index.toString()),
                size: 24,
              ),
            ),
            shareButton(shareUrl: "shareUrl"),
          ],
        ),
      ],
    ),
    imageUrl: details.url!,
    title: details.dealName!,
  );
}
