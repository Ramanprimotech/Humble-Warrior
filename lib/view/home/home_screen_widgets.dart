import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/network/endpoints.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/future_widget/future_widget.dart';
import 'package:humble_warrior/utils/theme_extention/image_icon_theme_extention.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

import '../../modals/response/brands_response_mdel.dart';
import '../../modals/response/home_categories_response_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_text.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/search_bar/search_bar_ui.dart';
import '../../utils/theme_extention/shadow_theme_extention.dart';
import 'home_brands_api_widgets.dart';
import 'home_category_api_widgets.dart';

class HomeScreenWidgets {
  final HomeScreenController controller;
  final BuildContext context;

  HomeScreenWidgets({
    required this.controller,
    required this.context,
  });

  final double productHeight = 60;
  final double brandLoveHeight = 50;
  final double brandHeight = 60;
  final double productArrowIconPadding = 8;
  final double arrowWidth = 30;

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
              child: InkWell(
                onTap: () async {
                  // SharedPreferences _prefs =
                  //     await SharedPreferences.getInstance();
                  // _prefs!.setString("token", null);
                  //
                  // _prefs!.setString(_TOKEN_EXPIRY_KEY);
                },
                child: AppIcons.notification(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///HOme Options List Future Builder
  Widget homeOptionListTwo() {
    return GetBuilder(
        id: Endpoints.homeCategories,
        init: controller,
        builder: (controller) {
          return FutureWidget<List<HomeCategoryList>>().builder(
              futureWidgets: HomePageCategoryAPIWidgets(context: context),
              future: controller.homeCategories(),
              context: context);
        });
  }

  /// Product List Future Builder
  Widget productList() {
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
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    scrollDirection: Axis.horizontal,
                    controller: controller.productScrollController,
                    itemCount: ProductImages.productImagesList.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: SizedBox(
                          height: productHeight,
                          width: 80,
                          child: Column(
                            children: [
                              Image.asset(
                                  ProductImages.productImagesList[index].image,
                                  fit: BoxFit.fitHeight,
                                  height: productHeight - 20,
                                  scale: 0.7),
                              AppText(
                                ProductImages.productImagesList[index].name,
                                fontSize: 12,
                                maxLines: 1,
                              ),
                            ],
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
              // right: -5,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                color: Theme.of(context).scaffoldBackgroundColor,
                height: brandHeight, width: arrowWidth,
                // padding: EdgeInsets.only(right: productArrowIconPadding),
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

  /// Brand List
  Widget brandsList() {
    final ImageIconTheme imageIconTheme =
        Theme.of(context).extension<ImageIconTheme>()!;
    return
        // ValueListenableBuilder(
        // valueListenable: controller.keyboardIsOpened,
        // builder: (BuildContext context, value, Widget? child) {
        //   return Transform.translate(
        //     offset: Offset(0, !value ? (brandHeight + brandLoveHeight + 10) : 0),
        //     child: child,
        //   );
        // },
        // child:
        Container(
      height: brandHeight + brandLoveHeight + 20,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
      ),
      child: Column(
        children: [
          /// Brand Title Row
          _brandRow(height: brandLoveHeight, context: context),
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 10,
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
                ],
              ),
              Obx(
                () => Visibility(
                  visible: controller.brandListBack.value,
                  child: Positioned(
                    left: 0,
                    child: GestureDetector(
                        onTap: () {
                          controller.brandScrollController.animateTo(
                              controller.brandScrollController.offset -
                                  (80 * 2),
                              duration: const Duration(milliseconds: 150),
                              curve: Curves.linear);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: productArrowIconPadding.pl,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            height: brandHeight,
                            width: arrowWidth,
                            child: AppIcons.backArrrowIos(
                                iconColor: imageIconTheme.textColor))),
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.brandListForward.value,
                  child: Positioned(
                    right: 0,
                    child: GestureDetector(
                        onTap: () {
                          controller.brandScrollController.animateTo(
                              controller.brandScrollController.offset +
                                  (80 * 2),
                              duration: const Duration(milliseconds: 150),
                              curve: Curves.linear);
                        },
                        child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            height: brandHeight,
                            width: arrowWidth,
                            child: AppIcons.next(
                                iconColor: imageIconTheme.textColor))),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: 25.ph,
            height: 1,
            width: Get.width,
            color: Colors.grey.shade400,
          ),
          // Divider(color: Colors.black,thickness: 1),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
    // );
  }

  /// Brand List API Builder
  GetBuilder<HomeScreenController> brandListAPIBuilder() {
    return GetBuilder<HomeScreenController>(
        id: Endpoints.allBrands,
        init: controller,
        builder: (controller) {
          return FutureWidget<List<BrandDetails>>().builder(
              futureWidgets: HomePageBrandAPIWidgets(context: context),
              future: controller.allBrands(),
              context: context);
        });
    // return FutureBuilder<List<BrandDetails>>(
    //     future: controller.allBrands(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return ListView.separated(
    //           padding: const EdgeInsets.symmetric(horizontal: 20),
    //           scrollDirection: Axis.horizontal,
    //           itemCount: 25,
    //           itemBuilder: (ctx, index) {
    //             return Container(
    //               color: Theme.of(context)
    //                   .floatingActionButtonTheme
    //                   .backgroundColor,
    //               height: 60,
    //               width: 80,
    //               child: Column(
    //                 children: const [
    //                   ShimmerLoader(
    //                       child: AppText(
    //                     "HW",
    //                     fontWeight: FontWeight.w900,
    //                     fontSize: 35,
    //                   )),
    //                 ],
    //               ),
    //             );
    //           },
    //           separatorBuilder: (BuildContext context, int index) {
    //             return 20.sw;
    //           },
    //         );
    //       }
    //       if (snapshot.hasError) {
    //         return const AppText("Something Went Wrong");
    //       }
    //       List<BrandDetails> data = snapshot.data ?? [];
    //       return ListView.separated(
    //         // physics: BouncingScrollPhysics(),
    //         padding: const EdgeInsets.symmetric(horizontal: 20),
    //         scrollDirection: Axis.horizontal,
    //         controller: controller.brandScrollController,
    //         itemCount: data.length,
    //         itemBuilder: (ctx, index) {
    //           return GestureDetector(
    //             onTap: () {
    //               CommonUtils().urlLauncher(url: data[index].brandLink!);
    //             },
    //             child: SizedBox(
    //               height: 60,
    //               width: 80,
    //               child: Column(
    //                 children: [
    //                   CommonWidgets.networkImage(
    //                     alignment: Alignment.center,
    //                     imageUrl: data[index].brandImage!,
    //                     fit: BoxFit.contain,
    //                     height: 60,
    //                     width: 80,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //         },
    //         separatorBuilder: (BuildContext context, int index) {
    //           return 20.sw;
    //         },
    //       );
    //     });
  }

  /// Brand Title Row
  Widget _brandRow({required double height, required BuildContext context}) {
    final ShadowTheme shadowTheme = Theme.of(context).extension<ShadowTheme>()!;
    return Container(
      height: height,
      padding: const EdgeInsets.only(top: 15, right: 20, left: 20, bottom: 10),
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
                "${brandsTxt} I",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              5.sw,
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: AppIcons.heart(
                  iconColor: Colors.red,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.brands);
            },
            child: const AppText(
              viewAllTxt,
              fontSize: 16,
              color: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }

// ///HOme Options List Future Builder
// Widget homeOptionList() {
//   return GetBuilder(
//       id: Endpoints.homeCategories,
//       init: controller,
//       builder: (controller) {
//         return FutureBuilder<List<HomeCategoryList>>(
//             future: controller.homeCategories(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Expanded(
//                   child: ListView.builder(
//                     itemBuilder: (ctx, index) {
//                       if (index == 3) {
//                         return ValueListenableBuilder(
//                           valueListenable: controller.keyboardIsOpened,
//                           builder: (context, value, child) {
//                             return Visibility(
//                               visible: value,
//                               child: SizedBox(
//                                 height: brandHeight + brandLoveHeight + 10,
//                               ),
//                             );
//                           },
//                         );
//                       }
//                       return ShimmerLoader(
//                         child: homeOption(
//                             homeOptions: HomeCategoryList(
//                                 categoryImage:
//                                     "https://www.pngfind.com/pngs/m/415-4156288_image-nike-logo-just-do-it-orange-hd.png",
//                                 categoryName: "Donna's Options",
//                                 id: 0),
//                             index: index),
//                       );
//                     },
//                     itemCount: 4,
//                   ),
//                 );
//               }
//               if (snapshot.hasError) {
//                 // return ErrorWidget(snapshot.error!);
//                 final DialogueThemeExtention dialogueThemeExtention =
//                     Theme.of(context).extension<DialogueThemeExtention>()!;
//                 return Padding(
//                   padding:
//                       const EdgeInsets.only(top: 80.0, left: 30, right: 30),
//                   child: Container(
//                     height: 200,
//                     width: Get.width,
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: dialogueThemeExtention.backGroundColor,
//                       boxShadow: [
//                         BoxShadow(
//                             color: dialogueThemeExtention.shadow!,
//                             spreadRadius: 2,
//                             blurRadius: 2,
//                             offset: Offset(0, 0))
//                       ],
//                     ),
//                     child: Column(children: [
//                       AppText("${snapshot.error.toString()}",
//                           maxLines: 5, fontSize: 20),
//                       20.sh,
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           elevation: 5,
//                           // fixedSize: const Size(, 35),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           backgroundColor: dialogueThemeExtention.buttonColor,
//                         ),
//                         onPressed: () {
//                           controller.update([Endpoints.homeCategories]);
//                         },
//                         child: const AppText('Retry',
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ]),
//                   ),
//                 );
//                 // return const AppText("Something Went Wrong");
//               }
//               List<HomeCategoryList> data = snapshot.data ?? [];
//               return Expanded(
//                 child: ListView.builder(
//                   itemBuilder: (ctx, index) {
//                     if (index == data.length) {
//                       return ValueListenableBuilder(
//                         valueListenable: controller.keyboardIsOpened,
//                         builder: (ctx, value, child) {
//                           return Visibility(
//                             visible: value,
//                             child: SizedBox(
//                               height: brandHeight + brandLoveHeight + 10,
//                             ),
//                           );
//                         },
//                       );
//                     }
//                     return homeOption(homeOptions: data[index], index: index);
//                   },
//                   itemCount: data.length + 1,
//                 ),
//               );
//             });
//       });
// }
}