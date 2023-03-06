import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/product_details_response.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_text.dart';
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
            return CommonWidgets.noData(update: controller.update);
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            controller: controller.donnaDealScrollController,
            itemCount: controller.donnaDealList.length + 1,
            itemBuilder: (ctx, index) {
              ProductDetailsResponse details = ProductDetailsResponse();
              if (index != controller.donnaDealList.length) {
                details = controller.donnaDealList[index];
              }
              return index != controller.donnaDealList.length
                  ? donnaDealsCard(details, index, context)
                  : Obx(
                      () => Visibility(
                          visible: controller.donnaDealsBool.value,
                          child: Container(
                              height: 80,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator())),
                    );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 25,
              );
            },
          );
        },
      ),
    );
  }
}

ItemCard donnaDealsCard(
    ProductDetailsResponse details, int index, BuildContext context) {
  return ItemCard(
    onTap: () {
      Get.toNamed(AppRoutes.dailyDealProductDetail, arguments: [details]);
    },
    radius: 10,
    buttons: donnaDealsButton(details, index, context),
    imageUrl: details.url!,
    title: details.itemName!,
  );
}

Widget donnaDealsButton(
    ProductDetailsResponse details, int index, BuildContext context,
    {bool? categoryCard = false}) {
  Color color = Theme.of(context).textTheme.displayMedium!.color!;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (categoryCard == true)
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 8.0),
          child: AppText(
            "${details.itemName!}",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: 8.pl,
                child: shopButton(
                    url: "${details.shopUrl}", title: details.itemName!),
              ),
              !(details.couponCode == null || details.couponCode == "")
                  ? codeButton(code: "${details.couponCode}")
                  : 80.sw,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              shareButton(shareUrl: "shareUrl", color: color),
              IconButton(
                onPressed: () {
                  // controller.select.value = !controller.select.value;
                },
                icon: Heart(
                  id: details.id.toString(),
                  item: details,
                  color: color,
                  key: Key(index.toString()),
                  size: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
