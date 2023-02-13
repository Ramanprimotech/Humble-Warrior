import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/home_categories_response_model.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/utils/search_bar/search_bar_ui.dart';
import 'package:humble_warrior/utils/shimmer/shimmer_loader.dart';
import 'package:humble_warrior/utils/theme_extention/shadow_theme_extention.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

import '../../modals/response/brands_response_mdel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.find();

    double productHeight = 60;
    double brandLoveHeight = 55;
    double brandHeight = 60;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ValueListenableBuilder(
          valueListenable: controller.keyboardIsOpened,
          builder: (BuildContext context, value, Widget? child) {
            return Transform.translate(
              offset:
                  Offset(0, !value ? (brandHeight + brandLoveHeight + 10) : 0),
              child: child,
            );
          },
          child: Container(
            height: brandHeight + brandLoveHeight + 10,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              color:
                  Theme.of(context).floatingActionButtonTheme.backgroundColor,
            ),
            child: Column(
              children: [
                _brandRow(height: brandLoveHeight, context: context),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        color: Colors.white,
                        height: brandHeight,
                        width: Get.height,
                        child: FutureBuilder<List<BrandDetails>>(
                            future: controller.allBrands(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return ListView.separated(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 25,
                                  itemBuilder: (ctx, index) {
                                    return Container(
                                      color: Colors.white,
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
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return 20.sw;
                                  },
                                );
                              }
                              if (snapshot.hasError) {
                                return AppText("Something Went Wrong");
                              }
                              List<BrandDetails> data = snapshot.data ?? [];
                              return ListView.separated(
                                // physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                scrollDirection: Axis.horizontal,
                                controller: controller.brandScrollController,
                                itemCount: data.length,
                                itemBuilder: (ctx, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      CommonUtils().urlLauncher(
                                          url: data[index].brandLink!);
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
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return 20.sw;
                                },
                              );
                            }),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            controller.brandScrollController.animateTo(
                                controller.brandScrollController.offset +
                                    (80 * 2),
                                duration: Duration(milliseconds: 150),
                                curve: Curves.linear);
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),

        // Obx(
        //   () => !controller.keyboardIsOpened.value
        //       ? const SizedBox()
        //       : Container(
        //           color: Colors.white,
        //           height: brandHeight + brandLoveHeight + 10,
        //           child: Column(
        //             children: [
        //               _brandRow(height: brandLoveHeight),
        //               Container(
        //                 color: Colors.white,
        //                 height: brandHeight,
        //                 width: Get.height,
        //                 child: FutureBuilder<List<BrandDetails>>(
        //                     future: controller.allBrands(),
        //                     builder: (context, snapshot) {
        //                       if (snapshot.connectionState ==
        //                           ConnectionState.waiting) {
        //                         return ListView.separated(
        //                           padding: EdgeInsets.symmetric(horizontal: 20),
        //                           scrollDirection: Axis.horizontal,
        //                           itemCount: 25,
        //                           itemBuilder: (ctx, index) {
        //                             return Container(
        //                               color: Colors.white,
        //                               height: 60,
        //                               width: 80,
        //                               child: Column(
        //                                 children: const [
        //                                   ShimmerLoader(
        //                                       child: AppText(
        //                                     "HW",
        //                                     fontWeight: FontWeight.w900,
        //                                     fontSize: 35,
        //                                   )),
        //                                 ],
        //                               ),
        //                             );
        //                           },
        //                           separatorBuilder:
        //                               (BuildContext context, int index) {
        //                             return 20.sw;
        //                           },
        //                         );
        //                       }
        //                       if (snapshot.hasError) {
        //                         return AppText("Something Went Wrong");
        //                       }
        //                       List<BrandDetails> data = snapshot.data ?? [];
        //                       return ListView.separated(
        //                         padding: EdgeInsets.symmetric(horizontal: 20),
        //                         scrollDirection: Axis.horizontal,
        //                         itemCount: data.length,
        //                         itemBuilder: (ctx, index) {
        //                           return GestureDetector(
        //                             onTap: () {
        //                               CommonUtils().urlLauncher(
        //                                   url: data[index].brandLink!);
        //                             },
        //                             child: SizedBox(
        //                               height: 60,
        //                               width: 80,
        //                               child: Column(
        //                                 children: [
        //                                   CommonWidgets.networkImage(
        //                                     alignment: Alignment.bottomCenter,
        //                                     imageUrl: data[index].brandImage!,
        //                                     fit: BoxFit.contain,
        //                                     height: 40,
        //                                     width: 80,
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           );
        //                         },
        //                         separatorBuilder:
        //                             (BuildContext context, int index) {
        //                           return 20.sw;
        //                         },
        //                       );
        //                     }),
        //               ),
        //               const SizedBox(
        //                 height: 10,
        //               )
        //             ],
        //           ),
        //         ),
        // ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: AppBar(
              backgroundColor: Colors.white,
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
                  padding: EdgeInsets.only(right: 15),
                  child:
                      InkWell(onTap: () {}, child: AppIcons.notificationActice()
                          // Image.asset(
                          //   ImagePathAssets.bellIcon,
                          //   fit: BoxFit.cover,
                          //   height: 30,
                          //   width: 30,
                          // ),
                          ),
                )
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    // margin: EdgeInsets.symmetric(horizontal: 20),
                    height: productHeight,
                    width: Get.width,
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        controller: controller.productScrollController,
                        itemCount: ProductImages.productImagesList.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: SizedBox(
                              height: productHeight,
                              width: 62,
                              child: Column(
                                children: [
                                  CommonWidgets.networkImage(
                                      imageUrl: ProductImages
                                          .productImagesList[index].image,
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
                            controller.productScrollController.offset +
                                (70 * 1),
                            duration: Duration(milliseconds: 150),
                            curve: Curves.linear);
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 20,
                        weight: 10,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            FutureBuilder<List<HomeCategoryList>>(
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
                    return AppText("Something Went Wrong");
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
                        return homeOption(
                            homeOptions: data[index], index: index);
                      },
                      itemCount: data.length + 1,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  _brandRow({required double height, required BuildContext context}) {
    final ShadowTheme shadowTheme = Theme.of(context).extension<ShadowTheme>()!;
    return Container(
      height: height,
      padding: EdgeInsets.only(top: 15, right: 20, left: 20, bottom: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                offset: Offset(-1, -1),
                blurRadius: 2,
                color: shadowTheme.shadowColor!),
            BoxShadow(
                offset: Offset(1, -1),
                blurRadius: 1,
                color: shadowTheme.shadowColor!)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppText(
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
          AppText(
            "VIEW ALL",
            fontSize: 14,
            color: AppColors.blue,
          ),
        ],
      ),
    );
  }
}

Widget homeOption({required HomeCategoryList homeOptions, required int index}) {
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
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(20),
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
