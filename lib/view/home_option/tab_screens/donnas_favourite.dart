import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/product_details_response.dart';
import 'package:humble_warrior/utils/common/common_pagination.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';

import '../../../utils/routes/app_routes.dart';
import '../home_options_main/home_option_controller.dart';

class DonnaFavourite extends StatelessWidget {
  const DonnaFavourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeOptionController controller = Get.find();
    return PaginationWidget(
      api: controller.donnaFavouriteDealsAPI,
      apiBool: controller.donnaFavouriteDealsBool,
      scrollController: controller.donnaFavouriteDealScrollController,
      update: controller.update,
      totalRecords: controller.donnaFavouriteDealsTotalDeals,
      length: controller.donnaFavouriteDealListLength,
      child: GetBuilder<HomeOptionController>(
        init: controller,
        builder: (ctx) {
          if (controller.donnaFavouriteDealList.isEmpty &&
              controller.donnaFavouriteDealsBool.value == true) {
            return Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                CommonWidgets.loading(),
              ],
            ));
          }
          if (controller.donnaFavouriteDealList.isEmpty &&
              controller.donnaFavouriteDealsBool.value == false) {
            return CommonWidgets.noData(
                update: controller.update,
                context: context,
                onTap: () {
                  controller.donnaFavouriteDealsBool.value = true;
                  controller.update();
                  controller.donnaFavouriteDealsAPI();
                });
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            controller: controller.donnaFavouriteDealScrollController,
            itemCount: controller.donnaFavouriteDealList.length + 1,
            itemBuilder: (ctx, index) {
              ProductDetailsResponse details = ProductDetailsResponse();
              if (index != controller.donnaFavouriteDealList.length) {
                details = controller.donnaFavouriteDealList[index];
              }
              return index != controller.donnaFavouriteDealList.length
                  ? favouritePageCard(
                      onTap: () {
                        Get.toNamed(AppRoutes.favouriteDeal,
                            arguments: [details]);
                      },
                      imageUrl: details.url!,
                    )
                  : Obx(
                      () => Visibility(
                          visible: controller.donnaFavouriteDealsBool.value,
                          child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator())),
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

  favouritePageCard({double? height, onTap, imageUrl}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: SizedBox(
        height: height ?? 220,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CommonWidgets.networkImage(
            imageUrl: imageUrl ?? "",
            alignment: Alignment.center,
            width: Get.width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
