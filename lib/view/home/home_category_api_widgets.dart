import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/decorations.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';

import '../../modals/response/home_categories_response_model.dart';
import '../../network/endpoints.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import '../../utils/common/refresh_Indicator.dart';
import '../../utils/future_widget/abstract_future_widget.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/shimmer/shimmer_loader.dart';
import 'home_controller.dart';

class HomePageCategoryAPIWidgets extends FutureAPI<List<HomeCategoryList>> {
  final BuildContext context;

  HomePageCategoryAPIWidgets({required this.context});

  final double productHeight = 60;
  final double brandLoveHeight = 55;
  final double brandHeight = 60;

  final HomeScreenController controller = Get.find();

  @override
  Widget error({Object? error}) {
    return Expanded(
      child: CommonWidgets.errorAPI(
          buttonTitle: retryTxt,
          errorText: error.toString(),
          context: context,
          onPress: () => controller.update([Endpoints.homeCategories])),
    );
  }

  @override
  Widget success({List<HomeCategoryList>? data}) {
    List<HomeCategoryList> record = data ?? [];
    record.sort((a, b) => a.id!.compareTo(b.id!));
    return Expanded(
      child: CustomRefreshIndicator(
        onRefresh: () {
          controller.update([Endpoints.homeCategories]);

          return Future.value(0);
        },
        child: ListView.builder(
          padding: 10.pb,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            return homeOption(homeOptions: record[index], index: index)
                .paddingOnly(bottom: index == record.length - 1 ? 20 : 0);
          },
          itemCount: record.length,
        ),
      ),
    );
  }

  @override
  Widget waiting() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          if (index == 3) {
            return SizedBox(
              height: brandHeight + brandLoveHeight + 10,
            );
          }
          return ShimmerLoader(
            child: homeOption(
                homeOptions: HomeCategoryList(
                    categoryImage: "", categoryName: donnasOptionTxt, id: 0),
                index: index),
          );
        },
        itemCount: 4,
      ),
    );
  }

  /// Home Options
  Widget homeOption(
      {required HomeCategoryList homeOptions, required int index}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 6),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.homeOptions, arguments: <int>[homeOptions.id!]);
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              decoration:
                  CustomBoxDecorations().shadow(context: context, radius: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CommonWidgets.networkImage(
                  imageUrl: homeOptions.categoryImage!,
                  fit: BoxFit.fitWidth,
                  height: 220,
                  alignment: Alignment.topCenter,
                  // width: Get.width,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topRight: Radius.circular(10),
                  )),
              child: AppText(
                homeOptions.categoryName!.toUpperCase(),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
