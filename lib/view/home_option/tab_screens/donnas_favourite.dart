import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/donna_favourite_response_model.dart';
import 'package:humble_warrior/utils/common/common_pagination.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/view/home_option/common_home_option.dart';

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
                CircularProgressIndicator(),
                CommonWidgets.loading(),
              ],
            ));
          }
          if (controller.donnaFavouriteDealList.isEmpty &&
              controller.donnaFavouriteDealsBool.value == false) {
            return CommonWidgets.noData();
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            controller: controller.donnaFavouriteDealScrollController,
            itemCount: controller.donnaFavouriteDealList.length + 1,
            itemBuilder: (ctx, index) {
              DonnaFavouriteDetails details = DonnaFavouriteDetails();
              if (index != controller.donnaFavouriteDealList.length) {
                details = controller.donnaFavouriteDealList[index];
              }
              return index != controller.donnaFavouriteDealList.length
                  ? favouritePageCard(onTap: () {
                Get.toNamed(AppRoutes.favouriteDeal,
                    arguments: [details]);
              },
                imageUrl:  details.url!,
              ): Obx(
                      () => Visibility(
                          visible: controller.donnaFavouriteDealsBool.value,
                          child: Container(
                              height: 50,
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
