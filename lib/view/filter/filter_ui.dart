import 'package:humble_warrior/view/filter/filter_controller.dart';
import 'package:humble_warrior/view/filter/filter_product_category_api_widgets.dart';
import 'package:humble_warrior/view/search/api_services.dart';
import 'package:humble_warrior/view/search/model.dart';

import '../../hw.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({Key? key}) : super(key: key);
  final double productHeight = 55;
  final double brandLoveHeight = 39;
  final double brandHeight = 63;
  final double productArrowIconPadding = 8;
  final double arrowWidth = 40;
  final int badge = 99;
  final FilterController _filterController = Get.find();
  final HomeScreenController _homeScreenController = Get.find();
  HiveService hiveService = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: _filterController.record.value);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Obx(
            () => Column(
              children: [
                CommonWidgets.titleBar(context,
                    title: "All Categories", fontSize: 20, onPress: () {
                  if (_filterController.record.isEmpty) {
                    Get.back(result: _filterController.record.value);
                  } else {
                    Get.back(result: _filterController.record.value);
                  }
                }),

                /// Category Reset Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText((!_filterController.selevtedVisibility.value)
                        ? "Categories"
                        : "Selected Categories",fontWeight: FontWeight.bold),
                    TextButton(
                        onPressed: () {
                          if (_filterController.record.isNotEmpty) {
                            _filterController.resetList();
                            _filterController.selevtedVisibility.value = false;
                            _filterController.update();
                          }
                        },
                        child: GetBuilder<FilterController>(
                            init: _filterController,
                            builder: (controller) {
                              return AppText(_filterController.record.isNotEmpty
                                  ? "Reset"
                                  : "");
                            })),
                  ],
                ).px(16),

                /// List To Select From
                Visibility(
                  visible: (!_filterController.selevtedVisibility.value),
                  child: GetBuilder<FilterController>(
                      id: Endpoints.productCategories,
                      init: _filterController,
                      builder: (controller) {
                        return FutureWidget<List<ProductCategoryItem>>()
                            .builder(
                                futureWidgets:
                                    FilterPageProductCategoryAPIWidgets(
                                        context: context,
                                        productHeight: productHeight,
                                        brandHeight: brandHeight),
                                // future: _homeScreenController.productCategoryAPI(),
                                future: _filterController.api(),
                                context: context);
                      }),
                ),

                ///Visible Selected
                Obx(
                  () => Visibility(
                    visible: _filterController.selevtedVisibility.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Selected List
                        GetBuilder<FilterController>(
                          init: _filterController,
                          builder: (controller) => controller.record.isEmpty
                              ? Container(
                                  height: productHeight,
                                  alignment: Alignment.center,
                                  width: Get.width,
                                  child: const AppText("No Category Selected"),
                                )
                              : Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Visibility(
                                          visible:
                                              controller.listSelectedBack.value,
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            height: brandHeight,
                                            width: arrowWidth,
                                            padding: EdgeInsets.only(
                                                left: productArrowIconPadding),
                                            child: GestureDetector(
                                              onTap: () {
                                                controller
                                                    .selectedProductScrollController
                                                    .animateTo(
                                                        controller
                                                                .selectedProductScrollController
                                                                .offset -
                                                            (60 * 3),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    150),
                                                        curve: Curves.linear);
                                              },
                                              child: AppIcons.backArrrowIos(
                                                  iconColor: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .color!),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            height: productHeight + 10,
                                            width: Get.width,
                                            child: ListView.builder(
                                                padding: 30.pr,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                controller: controller
                                                    .selectedProductScrollController,
                                                itemCount: controller
                                                    .unSelectedList()
                                                    .length,
                                                itemBuilder: (ctx, index) {
                                                  ProductCategoryItem item =
                                                      controller
                                                              .unSelectedList()[
                                                          index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      _filterController
                                                          .addToWish(item);
                                                    },
                                                    child: Container(
                                                      padding: 30.pl,
                                                      height: productHeight,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Stack(
                                                            alignment: Alignment
                                                                .topRight,
                                                            children: [
                                                              SizedBox(
                                                                height:
                                                                    productHeight -
                                                                        25,
                                                                child: Image
                                                                    .network(
                                                                  item.categoryImage ??
                                                                      "",
                                                                  errorBuilder: (BuildContext
                                                                          ctx,
                                                                      Object
                                                                          error,
                                                                      stackTrace) {
                                                                    return Center(
                                                                        child: Image
                                                                            .asset(
                                                                      ImagePathAssets
                                                                          .noImageFound,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      fit: BoxFit
                                                                          .fitHeight,
                                                                      // height: height,
                                                                    ));
                                                                  },
                                                                ),
                                                              ),
                                                              Visibility(
                                                                visible: _filterController
                                                                    .containItem(
                                                                        item),
                                                                child: Transform
                                                                    .translate(
                                                                  offset:
                                                                      const Offset(
                                                                          18,
                                                                          -8),
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .check_circle,
                                                                    color: AppColors
                                                                        .appGreen,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // 4.shb,
                                                          AppText(
                                                            // controller
                                                            //         .record
                                                            //         .value[index]
                                                            item.categoryName ??
                                                                "",
                                                            fontSize: 14,
                                                            maxLines: 1,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                        Visibility(
                                          visible: controller
                                              .listSelectedForward.value,
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            height: brandHeight,
                                            width: arrowWidth,
                                            child: GestureDetector(
                                              onTap: () {
                                                controller
                                                    .selectedProductScrollController
                                                    .animateTo(
                                                        controller
                                                                .selectedProductScrollController
                                                                .offset +
                                                            (60 * 3),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    150),
                                                        curve: Curves.linear);
                                              },
                                              child: AppIcons.next(
                                                  iconColor: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .color!),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                10.shb,

                /// Category Reset Bar
                // GetBuilder<FilterController>(
                //   init: _filterController,
                //   builder: (ctx) => AppText("label"),
                // ),
                GetBuilder<FilterController>(
                  init: _filterController,
                  builder: (ctx) => Visibility(
                    visible: _filterController.record.isNotEmpty,
                    child: GestureDetector(
                      onTap: () {
                        _filterController.showCategories(context);
                      },
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Center(
                          child: AppText(
                            "Search Results",
                            color: AppColors.white,
                          ),
                        ).px(14).py(2),
                      ).p(10),
                    ),
                  ),
                ),

                // ///Visible Selected
                // Obx(
                //   () => Visibility(
                //     visible: _filterController.selevtedVisibility.value &&
                //         _filterController.record.isNotEmpty,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const AppText("Selected Categories").px(16),
                //         10.shb,
                //
                //         /// Selected List
                //         GetBuilder<FilterController>(
                //           init: _filterController,
                //           builder: (controller) => controller.record.isEmpty
                //               ? Container(
                //                   height: productHeight,
                //                   alignment: Alignment.center,
                //                   width: Get.width,
                //                   child: const AppText("No Category Selected"),
                //                 )
                //               : Stack(
                //                   alignment: Alignment.center,
                //                   children: [
                //                     Row(
                //                       children: [
                //                         Visibility(
                //                           visible:
                //                               controller.listSelectedBack.value,
                //                           child: Container(
                //                             alignment: Alignment.center,
                //                             color: Theme.of(context)
                //                                 .scaffoldBackgroundColor,
                //                             height: brandHeight,
                //                             width: arrowWidth,
                //                             padding: EdgeInsets.only(
                //                                 left: productArrowIconPadding),
                //                             child: GestureDetector(
                //                               onTap: () {
                //                                 controller
                //                                     .selectedProductScrollController
                //                                     .animateTo(
                //                                         controller
                //                                                 .selectedProductScrollController
                //                                                 .offset -
                //                                             (60 * 3),
                //                                         duration:
                //                                             const Duration(
                //                                                 milliseconds:
                //                                                     150),
                //                                         curve: Curves.linear);
                //                               },
                //                               child: AppIcons.backArrrowIos(
                //                                   iconColor: Theme.of(context)
                //                                       .textTheme
                //                                       .displaySmall!
                //                                       .color!),
                //                             ),
                //                           ),
                //                         ),
                //                         Expanded(
                //                           child: Container(
                //                             alignment: Alignment.bottomCenter,
                //                             margin: 8.pv,
                //                             height: productHeight + 10,
                //                             width: Get.width,
                //                             child: ListView.builder(
                //                                 padding: 30.pr,
                //                                 scrollDirection:
                //                                     Axis.horizontal,
                //                                 controller: controller
                //                                     .selectedProductScrollController,
                //                                 // itemCount: controller
                //                                 //     .record.value.length,
                //                                 itemCount: controller
                //                                     .unSelectedList()
                //                                     .length,
                //                                 itemBuilder: (ctx, index) {
                //                                   ProductCategoryItem item =
                //                                       controller
                //                                               .unSelectedList()[
                //                                           index];
                //                                   // ProductCategoryItem item =
                //                                   // controller
                //                                   //     .record.value[index];
                //                                   return GestureDetector(
                //                                     onTap: () {
                //                                       _filterController
                //                                           .addToWish(item);
                //                                     },
                //                                     child: Container(
                //                                       padding: 30.pl,
                //                                       height: productHeight,
                //                                       child: Column(
                //                                         mainAxisAlignment:
                //                                             MainAxisAlignment
                //                                                 .end,
                //                                         children: [
                //                                           Stack(
                //                                             alignment: Alignment
                //                                                 .topRight,
                //                                             children: [
                //                                               SizedBox(
                //                                                 height:
                //                                                     productHeight -
                //                                                         25,
                //                                                 child: Image
                //                                                     .network(
                //                                                   item.categoryImage ??
                //                                                       "",
                //                                                   errorBuilder: (BuildContext
                //                                                           ctx,
                //                                                       Object
                //                                                           error,
                //                                                       stackTrace) {
                //                                                     return Center(
                //                                                         child: Image
                //                                                             .asset(
                //                                                       ImagePathAssets
                //                                                           .noImageFound,
                //                                                       alignment:
                //                                                           Alignment
                //                                                               .center,
                //                                                       fit: BoxFit
                //                                                           .fitHeight,
                //                                                       // height: height,
                //                                                     ));
                //                                                   },
                //                                                 ),
                //                                               ),
                //                                               Visibility(
                //                                                 visible: _filterController
                //                                                     .containItem(
                //                                                         item),
                //                                                 child: Transform
                //                                                     .translate(
                //                                                   offset:
                //                                                       Offset(18,
                //                                                           -8),
                //                                                   child:
                //                                                       const Icon(
                //                                                     Icons
                //                                                         .check_circle,
                //                                                     color: AppColors
                //                                                         .appGreen,
                //                                                   ),
                //                                                 ),
                //                                               ),
                //                                             ],
                //                                           ),
                //                                           // 4.shb,
                //                                           AppText(
                //                                             // controller
                //                                             //         .record
                //                                             //         .value[index]
                //                                             item.categoryName ??
                //                                                 "",
                //                                             fontSize: 14,
                //                                             maxLines: 1,
                //                                             fontWeight:
                //                                                 FontWeight.w600,
                //                                           ),
                //                                         ],
                //                                       ),
                //                                     ),
                //                                   );
                //                                 }),
                //                           ),
                //                         ),
                //                         Visibility(
                //                           visible: controller
                //                               .listSelectedForward.value,
                //                           child: Container(
                //                             alignment: Alignment.center,
                //                             color: Theme.of(context)
                //                                 .scaffoldBackgroundColor,
                //                             height: brandHeight,
                //                             width: arrowWidth,
                //                             child: GestureDetector(
                //                               onTap: () {
                //                                 controller
                //                                     .selectedProductScrollController
                //                                     .animateTo(
                //                                         controller
                //                                                 .selectedProductScrollController
                //                                                 .offset +
                //                                             (60 * 3),
                //                                         duration:
                //                                             const Duration(
                //                                                 milliseconds:
                //                                                     150),
                //                                         curve: Curves.linear);
                //                               },
                //                               child: AppIcons.next(
                //                                   iconColor: Theme.of(context)
                //                                       .textTheme
                //                                       .displaySmall!
                //                                       .color!),
                //                             ),
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // GetBuilder<FilterController>(
                //   init: _filterController,
                //   builder: (controller) => Visibility(
                //     visible: controller.record.isNotEmpty &&
                //         controller.selevtedVisibility.value,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         const AppText(""),
                //         GestureDetector(
                //           onTap: () {
                //             controller.showResult();
                //           },
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 color: AppColors.primary,
                //                 borderRadius: BorderRadius.circular(50)),
                //             child: const Center(
                //               child: AppText(
                //                 "Show Result",
                //                 color: AppColors.white,
                //               ),
                //             ).px(14).py(2),
                //           ).p(16),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
               /* Visibility(
                    visible: _filterController.record.isNotEmpty,
                    child: Divider(
                      height: 0.5,
                      color: AppColors.grey,
                    ).px16(),
                ),*/
                _filterController.record.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: AppText(
                            "Select a category to continue...",
                            maxLines: 4,
                          ),
                        ),
                      )
                    : GetBuilder(
                        id: "search",
                        init: _filterController,
                        builder: (ctr) => Expanded(
                          child: FutureBuilder<List<SearchPosts>>(
                            future: FetchSearchList().productDetails(
                                "",
                                // _filterController.controller.text,
                                _filterController.postType,
                                _filterController.getIntList()),
                            builder: (ctx, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                if (_filterController.controller.text.isEmpty) {
                                  return const Center(
                                    child: AppText(
                                      "Select a category to continue...",
                                      maxLines: 4,
                                    ),
                                  );
                                }
                                return const Center(
                                  child: AppText(
                                    somethingWentWrongTxt,
                                    maxLines: 4,
                                  ),
                                );
                              }
                              if (snapshot.data!.isEmpty) {
                                return const Center(
                                  child: AppText(noDealsTxt),
                                );
                              }

                              return ListView.separated(
                                  padding: 10.pv,
                                  itemCount: snapshot.data!.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return 10.shb;
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        hiveService.addToRecentList(
                                            RecentSearch(
                                                productSearched:
                                                    _filterController
                                                        .controller.text));
                                        Get.toNamed(
                                            AppRoutes.dailyDealProductDetail,
                                            arguments: [
                                              ProductDetailsResponse(
                                                  id: snapshot.data![index].id)
                                            ]);
                                      },
                                      child: Container(
                                        height: 80,
                                        margin: 20.ph,
                                        decoration: CustomBoxDecorations(
                                                context: context)
                                            .shadow(),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10)),
                                              child: CommonWidgets.networkImage(
                                                  height: 80,
                                                  width: Get.width * .3,
                                                  imageUrl: snapshot
                                                      .data![index].url
                                                      .toString(),
                                                  fit: BoxFit.cover),
                                            ),
                                            SizedBox(
                                              height: 80,
                                              width: Get.width * .7 - 40,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  (snapshot.data![index]
                                                                  .categoryName ==
                                                              null ||
                                                          snapshot.data![index]
                                                                  .categoryName ==
                                                              "")
                                                      ? const SizedBox()
                                                      : Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 3),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: AppColors
                                                                      .primary,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10),
                                                                  )),
                                                          child: AppText(
                                                            snapshot
                                                                .data![index]
                                                                .categoryName!
                                                                .toUpperCase(),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: Get.width * .7 - 40,
                                                    child: AppText(
                                                      snapshot
                                                          .data![index].itemName
                                                          .toString(),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      maxLines: 2,
                                                    ).paddingSymmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );

                                    //   ListTile(
                                    //   onTap: () {},
                                    //   contentPadding: 16.ph,
                                    //   leading: Image.asset(
                                    //     ImagePathAssets.hwLogoUnnamed,
                                    //     height: 40,
                                    //     width: 40,
                                    //   ),
                                    //   title:
                                    //       AppText("${snapshot.data![index].productName}"),
                                    // );
                                  });
                            },
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
