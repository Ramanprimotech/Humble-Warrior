import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/common/common_pagination.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/common/photo_viewer.dart';
import 'package:humble_warrior/utils/image_path_assets.dart';

import '../../../utils/routes/app_routes.dart';
import '../common_home_option.dart';
import '../home_options_main/home_option_controller.dart';

class FrontPageDeals extends StatelessWidget {
  const FrontPageDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeOptionController controller = Get.find();
    return PaginationWidget(
      apiBool: controller.frontPageDealsBool,
      api: controller.frontPageDealsAPI,
      update: controller.update,
      scrollController: controller.frontPageDealScrollController,
      totalRecords: controller.frontPageDealsTotalDeals,
      length: controller.frontPageDealListLength,
      child: GetBuilder<HomeOptionController>(
        init: controller,
        builder: (ctx) {
          if (controller.frontPageDealList.isEmpty &&
              controller.frontPageDealsBool.value == true) {
            return Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                CommonWidgets.loading(),
              ],
            ));
          }
          if (controller.frontPageDealList.isEmpty &&
              controller.frontPageDealsBool.value == false) {
            return CommonWidgets.noData(
                update: controller.update,
                context: context,
                onTap: () {
                  controller.frontPageDealsBool.value = true;
                  controller.update();
                  controller.frontPageDealsAPI();
                });
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            controller: controller.frontPageDealScrollController,
            itemCount: controller.frontPageDealList.length + 1,
            itemBuilder: (ctx, index) {
              ProductDetailsResponse details = ProductDetailsResponse();
              if (index != controller.frontPageDealList.length) {
                details = controller.frontPageDealList[index];
              }
              return Stack(
                children: [
                  index != controller.frontPageDealList.length
                      ? frontPageCard(details, index, context)
                      : Obx(
                          () => Visibility(
                              visible: controller.frontPageDealsBool.value,
                              child: Container(
                                  height: 80,
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator())),
                        ),

                  ///Do not remove code for future use Banner Ribbon
                  // Positioned(
                  //   top: (220 / 4) - 4,
                  //   left: (-220 / 4) + 16,
                  //   child: Transform.rotate(
                  //     angle: (360 - 45) * 3.1415927 / 180,
                  //     child: Stack(
                  //       alignment: Alignment.center,
                  //       children: [
                  //         23.sw,
                  //         // CustomPaint(
                  //         //   size: const Size(220, 40),
                  //         //   //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  //         //   painter: FrontPageBanner(
                  //         //       color: details.ribbonColor != null
                  //         //           ? details.ribbonColor!.toColor()
                  //         //           : Colors.transparent),
                  //         // ),
                  //         // AppText(
                  //         //   "${details.ribbonName}",
                  //         //   fontSize: 16,
                  //         //   color: Colors.white,
                  //         // ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
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

ItemCard frontPageCard(
    ProductDetailsResponse details, int index, BuildContext context,
    {bool isDetails = false}) {
  return ItemCard(
    onTap: () {
      if (isDetails) {
        Get.to(CustomPhotoViewer(url: details.url!));
      } else {
        Get.toNamed(AppRoutes.frontPageProductDetail, arguments: [details]);
      }
    },
    buttons: frontPageOptionsButton(details, index, context),
    imageUrl: details.url!,
    radius: 10,
    title: details.itemName.toString(),
  );
}

Widget frontPageButton(
    ProductDetailsResponse details, int index, BuildContext context) {
  Color color = Theme.of(context).textTheme.displayMedium!.color!;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      shareButton(
        shareUrl: "shareUrl",
        color: color,
      ),
      IconButton(
        onPressed: () {},
        icon: Image.asset(
          color: color,
          ImagePathAssets.commentIcon,
          height: 24,
        ),
      ),
      IconButton(
        onPressed: () {
          // controller.select.value = !controller.select.value;
        },
        icon: Heart(
          id: details.id.toString(),
          item: details,
          key: Key(index.toString()),
          color: color,
          size: 28,
        ),
      ),
    ],
  );
}

Widget frontPageOptionsButton(
    ProductDetailsResponse details, int index, BuildContext context) {
  Color color = Theme.of(context).textTheme.displayMedium!.color!;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      shareButton(
        shareUrl: "shareUrl",
        color: color,
      ),
      IconButton(
        onPressed: () {
          // controller.select.value = !controller.select.value;
        },
        icon: Heart(
          item: details,
          id: details.id.toString(),
          key: Key(index.toString()),
          color: color,
          size: 28,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Image.asset(
          color: color,
          ImagePathAssets.commentIcon,
          height: 24,
        ),
      ),
    ],
  );
}
