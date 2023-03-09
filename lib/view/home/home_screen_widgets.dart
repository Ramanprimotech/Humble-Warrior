import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/product_category_response.dart';
import 'package:humble_warrior/network/endpoints.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/future_widget/future_widget.dart';
import 'package:humble_warrior/utils/image_path_assets.dart';
import 'package:humble_warrior/utils/theme_extention/image_icon_theme_extention.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

import '../../modals/response/brands_response_mdel.dart';
import '../../modals/response/home_categories_response_model.dart';
import 'package:humble_warrior/hw.dart';

class HomeScreenWidgets {
  final HomeScreenController controller;
  final BuildContext context;

  HomeScreenWidgets({
    required this.controller,
    required this.context,
  });

  final double productHeight = 60;
  final double brandLoveHeight = 50;
  final double brandHeight = 70;
  final double productArrowIconPadding = 8;
  final double arrowWidth = 30;
  final int badge = 99;

  /// App Bar
  AppBar appBar(BuildContext context) {
    ImageIconTheme imageIconTheme =
        Theme.of(context).extension<ImageIconTheme>()!;
    return AppBar(
      toolbarHeight: 70,
      centerTitle: false,
      title: SearchBar(),
      // CustomSearchBar(
      //   onTap: controller.onTap,
      //   onSubmit: controller.onSubmit,
      //   onChange: controller.onChange,
      //   focusNode: controller.focusNode,
      //   textEditingController: controller.searchTextController,
      // ),
      actions: [

        Padding(
          padding: 15.pr,
          child: InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.notification);
            },
            child: Badge(
                textColor:Colors.white ,
                label:  AppText("14",fontSize: 8),
                alignment: const AlignmentDirectional(15.0,-3.0),
                child: Image.asset(
                  ImagePathAssets.bellIcon,
                  height: 28,
                  fit: BoxFit.fitHeight,
                  color: imageIconTheme.backGroundColor,
                )),
          ),
        )

        /// Do not remove this code, saved for future use
        /*Padding(
          padding: 15.pb,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                  height: 45,
                  alignment: Alignment.bottomLeft,
                  width: 50,
                  child: Image.asset(
                    ImagePathAssets.bellIcon,
                    height: 28,
                    fit: BoxFit.fitHeight,
                    color: imageIconTheme.backGroundColor,
                  )),
              Visibility(
                visible: badge>0,
                child: Positioned(
                  left: 15,
                  bottom: 15,
                  child: Container(
                    padding: 2.pa,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: imageIconTheme.backGroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: AppText(badge>99?"99+":"$badge",
                          fontWeight: FontWeight.w600,
                          fontSize: badge>99?9:10,
                          color: imageIconTheme.backGroundColor == Colors.black
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )*/
      ],
    );
  }

  ///HOme Options List Future Builder
  Widget homeOptionDeals() {
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
                    padding: 8.ph,
                    scrollDirection: Axis.horizontal,
                    controller: controller.productScrollController,
                    itemCount: ProductImages.productImagesList.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: 5.ph,
                        child: GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoutes.categoryDetailsList, arguments: [ProductImages.productImagesList[index].name]);
                          },
                          child: Container(
                            padding: 10.ph,
                            height: productHeight,
                            // width: 80,
                            child: Column(
                              children: [
                                Image.asset(
                                    ProductImages.productImagesList[index].image,
                                    fit: BoxFit.fitHeight,
                                    height: productHeight - 25,
                                    scale: 0.7),
                                AppText(
                                  ProductImages.productImagesList[index].name,
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
      height: brandHeight + brandLoveHeight + 10,
      decoration: BoxDecoration(
        // borderRadius: const BorderRadius.only(
        //     topRight: Radius.circular(15), topLeft: Radius.circular(15)),
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
                    flex:10,
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
         /* Container(
            margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
            height: 1,
            width: Get.width,
            color: Colors.grey.shade400,
          ),*/
        ],
      ),
    );
    // );
  }

  /// Product Categories API Builder
  GetBuilder<HomeScreenController> productCategoryListAPIBuilder() {
    return GetBuilder<HomeScreenController>(
        id: Endpoints.productCategories,
        init: controller,
        builder: (controller) {
          return FutureWidget<List<ProductCategoryItem>>().builder(
              futureWidgets: HomePageProductCategoryAPIWidgets(
                  context: context,
                  brandHeight: brandHeight,
                  productHeight: productHeight),
              future: controller.productCategoryAPI(),
              context: context);
        });
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
          // borderRadius: const BorderRadius.only(
          //     topRight: Radius.circular(15), topLeft: Radius.circular(15)),
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
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              5.swb,
              Padding(
                padding: 2.pt,
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
