import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/product_category_response.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/shimmer/shimmer_loader.dart';
import 'package:humble_warrior/utils/theme_extention/custom_notice_theme_extention.dart';

import '../../utils/app_text.dart';
import '../../utils/future_widget/abstract_future_widget.dart';
import '../../utils/routes/app_routes.dart';
import 'home_controller.dart';

class HomePageProductCategoryAPIWidgets
    extends FutureAPI<List<ProductCategoryItem>> {
  final BuildContext context;
  final double productHeight;
  final double brandHeight;

  HomePageProductCategoryAPIWidgets(
      {required this.context,
      required this.productHeight,
      required this.brandHeight});

  final HomeScreenController controller = Get.find();

  @override
  Widget error({Object? error}) {
    DialogueThemeExtention dialogueThemeExtention =
        Theme.of(context).extension<DialogueThemeExtention>()!;
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          // fixedSize: const Size(, 35),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: dialogueThemeExtention.buttonColor,
        ),
        onPressed: () {
          // controller.update([Endpoints.productCategories]);
          Get.toNamed(AppRoutes.categoryDetailsList, arguments: ["sd", "66"]);
        },
        child: const AppText('Retry',
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget success({List<ProductCategoryItem>? data}) {
    List<ProductCategoryItem> dataa = data ?? [];
    dataa.sort((a, b) => a.id!.compareTo(b.id!));
    const double productArrowIconPadding = 8;
    const double arrowWidth = 30;
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Expanded(
              // flex: 8,
              child: Container(
                height: productHeight,
                width: Get.width,
                child: ListView.builder(
                    padding: 8.ph,
                    scrollDirection: Axis.horizontal,
                    controller: controller.productScrollController,
                    itemCount: dataa.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: 5.ph,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.categoryDetailsList,
                                arguments: [
                                  dataa[index].categoryName,
                                  dataa[index].id.toString(),
                                ]);
                          },
                          child: Container(
                            padding: 10.ph,
                            height: productHeight,
                            // width: 80,
                            child: Column(
                              children: [
                                CommonWidgets.networkImage(
                                    imageUrl: dataa[index].categoryImage ?? "",
                                    fit: BoxFit.fitHeight,
                                    height: productHeight - 25,
                                    scale: 0.7),
                                // Image.asset(dataa[index].categoryImage ?? "",
                                //     fit: BoxFit.fitHeight,
                                //     height: productHeight - 25,
                                //     scale: 0.7),
                                AppText(
                                  dataa[index].categoryName ?? "",
                                  fontSize: 12,
                                  maxLines: 1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
        Obx(
          () => Visibility(
            visible: controller.listBack.value,
            child: Positioned(
              left: 0,
              child: Container(
                alignment: Alignment.center,
                color: Theme.of(context).scaffoldBackgroundColor,
                height: brandHeight,
                width: arrowWidth,
                padding: EdgeInsets.only(left: productArrowIconPadding),
                child: GestureDetector(
                  onTap: () {
                    controller.productScrollController.animateTo(
                        controller.productScrollController.offset - (60 * 3),
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.linear);
                  },
                  child: AppIcons.backArrrowIos(
                      iconColor:
                          Theme.of(context).textTheme.displaySmall!.color!),
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.listForward.value,
            child: Positioned(
              right: 0,
              child: Container(
                alignment: Alignment.center,
                color: Theme.of(context).scaffoldBackgroundColor,
                height: brandHeight,
                width: arrowWidth,
                child: GestureDetector(
                  onTap: () {
                    controller.productScrollController.animateTo(
                        controller.productScrollController.offset + (60 * 3),
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.linear);
                  },
                  child: AppIcons.next(
                      iconColor:
                          Theme.of(context).textTheme.displaySmall!.color!),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget waiting() {
    const double productArrowIconPadding = 8;
    const double arrowWidth = 30;
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Expanded(
              // flex: 8,
              child: Container(
                height: productHeight,
                width: Get.width,
                child: ListView.builder(
                    padding: 8.ph,
                    scrollDirection: Axis.horizontal,
                    controller: controller.productScrollController,
                    itemCount: 10,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: 5.ph,
                        child: GestureDetector(
                          onTap: () {},
                          child: ShimmerLoader(
                            child: Container(
                              padding: 10.ph,
                              height: productHeight,
                              color: Colors.grey,
                              width: 80,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
        Obx(
          () => Visibility(
            visible: controller.listBack.value,
            child: Positioned(
              left: 0,
              child: Container(
                alignment: Alignment.center,
                color: Theme.of(context).scaffoldBackgroundColor,
                height: brandHeight,
                width: arrowWidth,
                padding: EdgeInsets.only(left: productArrowIconPadding),
                child: GestureDetector(
                  onTap: () {
                    controller.productScrollController.animateTo(
                        controller.productScrollController.offset - (60 * 3),
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.linear);
                  },
                  child: AppIcons.backArrrowIos(
                      iconColor:
                          Theme.of(context).textTheme.displaySmall!.color!),
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.listForward.value,
            child: Positioned(
              right: 0,
              child: Container(
                alignment: Alignment.center,
                color: Theme.of(context).scaffoldBackgroundColor,
                height: brandHeight,
                width: arrowWidth,
                child: GestureDetector(
                  onTap: () {
                    controller.productScrollController.animateTo(
                        controller.productScrollController.offset + (60 * 3),
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.linear);
                  },
                  child: AppIcons.next(
                      iconColor:
                          Theme.of(context).textTheme.displaySmall!.color!),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
