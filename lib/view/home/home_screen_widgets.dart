import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/network/endpoints.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

import '../../modals/response/brands_response_mdel.dart';
import '../../modals/response/home_categories_response_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_text.dart';
import '../../utils/common/common_functionality.dart';
import '../../utils/common/common_widgets.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/search_bar/search_bar_ui.dart';
import '../../utils/shimmer/shimmer_loader.dart';
import '../../utils/theme_extention/custom_notice_theme_extention.dart';
import '../../utils/theme_extention/shadow_theme_extention.dart';

class HomeScreenWidgets {
  final HomeScreenController controller;
  final BuildContext context;

  HomeScreenWidgets({
    required this.controller,
    required this.context,
  });

  final double productHeight = 60;
  final double brandLoveHeight = 55;
  final double brandHeight = 60;

  /// App Bar
  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: AppBar(
          centerTitle: false,
          title: CustomSearchBar(
            onTap: controller.onTap,
            onSubmit: controller.onSubmit,
            onChange: controller.onChange,
            focusNode: controller.focusNode,
            textEditingController: controller.searchTextController,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child:
                  InkWell(onTap: () {}, child: AppIcons.notificationActice()),
            )
          ],
        ),
      ),
    );
  }

  ///HOme Options List Future Builder
  Widget homeOptionList() {
    return GetBuilder(
        id: Endpoints.homeCategories,
        init: controller,
        builder: (controller) {
          return FutureBuilder<List<HomeCategoryList>>(
              future: controller.homeCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        if (index == 3) {
                          return ValueListenableBuilder(
                            valueListenable: controller.keyboardIsOpened,
                            builder: (context, value, child) {
                              return Visibility(
                                visible: value,
                                child: SizedBox(
                                  height: brandHeight + brandLoveHeight + 10,
                                ),
                              );
                            },
                          );
                        }
                        return ShimmerLoader(
                          child: homeOption(
                              homeOptions: HomeCategoryList(
                                  categoryImage:
                                      "https://www.pngfind.com/pngs/m/415-4156288_image-nike-logo-just-do-it-orange-hd.png",
                                  categoryName: "Donna's Options",
                                  id: 0),
                              index: index),
                        );
                      },
                      itemCount: 4,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  // return ErrorWidget(snapshot.error!);
                  final DialogueThemeExtention dialogueThemeExtention =
                      Theme.of(context).extension<DialogueThemeExtention>()!;
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 80.0, left: 30, right: 30),
                    child: Container(
                      height: 200,
                      width: Get.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: dialogueThemeExtention.backGroundColor,
                        boxShadow: [
                          BoxShadow(
                              color: dialogueThemeExtention.shadow!,
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0, 0))
                        ],
                      ),
                      child: Column(children: [
                        AppText("${snapshot.error.toString()}",
                            maxLines: 5, fontSize: 20),
                        20.sh,
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            // fixedSize: const Size(, 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: dialogueThemeExtention.buttonColor,
                          ),
                          onPressed: () {
                            controller.update([Endpoints.homeCategories]);
                          },
                          child: const AppText('Retry',
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                  );
                  // return const AppText("Something Went Wrong");
                }
                List<HomeCategoryList> data = snapshot.data ?? [];
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      if (index == data.length) {
                        return ValueListenableBuilder(
                          valueListenable: controller.keyboardIsOpened,
                          builder: (ctx, value, child) {
                            return Visibility(
                              visible: value,
                              child: SizedBox(
                                height: brandHeight + brandLoveHeight + 10,
                              ),
                            );
                          },
                        );
                      }
                      return homeOption(homeOptions: data[index], index: index);
                    },
                    itemCount: data.length + 1,
                  ),
                );
              });
        });
  }

  /// Home Options
  Widget homeOption(
      {required HomeCategoryList homeOptions, required int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.homeOptions, arguments: <int>[homeOptions.id!]);
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CommonWidgets.networkImage(
                imageUrl: homeOptions.categoryImage!,
                fit: BoxFit.fitWidth,
                height: 200,
                alignment: Alignment.topCenter,
                // width: Get.width,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(20),
                  )),
              child: AppText(
                "${homeOptions.categoryName!.toUpperCase()}",
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

  /// Product List Future Builder
  Widget productList() {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: SizedBox(
            // margin: EdgeInsets.symmetric(horizontal: 20),
            height: productHeight,
            width: Get.width,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                controller: controller.productScrollController,
                itemCount: ProductImages.productImagesList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: SizedBox(
                      height: productHeight,
                      width: 62,
                      child: Column(
                        children: [
                          CommonWidgets.networkImage(
                              imageUrl:
                                  ProductImages.productImagesList[index].image,
                              fit: BoxFit.fitHeight,
                              height: productHeight - 20,
                              scale: 0.7),
                          AppText(
                            "${ProductImages.productImagesList[index].name}",
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              controller.productScrollController.animateTo(
                  controller.productScrollController.offset + (70 * 1),
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.linear);
            },
            child: AppIcons.next(),
          ),
        ),
      ],
    );
  }

  /// Brand List
  Widget brandsList() {
    return ValueListenableBuilder(
      valueListenable: controller.keyboardIsOpened,
      builder: (BuildContext context, value, Widget? child) {
        return Transform.translate(
          offset: Offset(0, !value ? (brandHeight + brandLoveHeight + 10) : 0),
          child: child,
        );
      },
      child: Container(
        height: brandHeight + brandLoveHeight + 10,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        ),
        child: Column(
          children: [
            /// Brand Title Row
            _brandRow(height: brandLoveHeight, context: context),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor,
                    height: brandHeight,
                    width: Get.height,

                    /// Brand List Future Builder
                    child: brandListAPIBuilder(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () {
                        controller.brandScrollController.animateTo(
                            controller.brandScrollController.offset + (80 * 2),
                            duration: const Duration(milliseconds: 150),
                            curve: Curves.linear);
                      },
                      child: AppIcons.next()),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  ///
  FutureBuilder brandListAPIBuilder() {
    return FutureBuilder<List<BrandDetails>>(
        future: controller.allBrands(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: 25,
              itemBuilder: (ctx, index) {
                return Container(
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                  height: 60,
                  width: 80,
                  child: Column(
                    children: const [
                      ShimmerLoader(
                          child: AppText(
                        "HW",
                        fontWeight: FontWeight.w900,
                        fontSize: 35,
                      )),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return 20.sw;
              },
            );
          }
          if (snapshot.hasError) {
            return const AppText("Something Went Wrong");
          }
          List<BrandDetails> data = snapshot.data ?? [];
          return ListView.separated(
            // physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            controller: controller.brandScrollController,
            itemCount: data.length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  CommonUtils().urlLauncher(url: data[index].brandLink!);
                },
                child: SizedBox(
                  height: 60,
                  width: 80,
                  child: Column(
                    children: [
                      CommonWidgets.networkImage(
                        alignment: Alignment.center,
                        imageUrl: data[index].brandImage!,
                        fit: BoxFit.contain,
                        height: 60,
                        width: 80,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return 20.sw;
            },
          );
        });
  }

  /// Brand Title Row
  Widget _brandRow({required double height, required BuildContext context}) {
    final ShadowTheme shadowTheme = Theme.of(context).extension<ShadowTheme>()!;
    return Container(
      height: height,
      padding: const EdgeInsets.only(top: 15, right: 20, left: 20, bottom: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(-1, -1),
                blurRadius: 2,
                color: shadowTheme.shadowColor!),
            BoxShadow(
                offset: const Offset(1, -1),
                blurRadius: 1,
                color: shadowTheme.shadowColor!)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const AppText(
                "BRAND'S  I",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              5.sw,
              AppIcons.heart(
                iconColor: Colors.red,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.brands);
            },
            child: const AppText(
              "VIEW ALL",
              fontSize: 14,
              color: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
