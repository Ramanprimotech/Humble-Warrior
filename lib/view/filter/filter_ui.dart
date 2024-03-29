import 'package:humble_warrior/view/filter/filter_controller.dart';
import 'package:humble_warrior/view/filter/filter_product_category_api_widgets.dart';
import '../../hw.dart';

class FilterScreen extends StatelessWidget {
  final int? route;
  FilterScreen({required this.route,Key? key}) : super(key: key);
  final double productHeight = 55;
  final double brandLoveHeight = 39;
  final double brandHeight = 63;
  final double productArrowIconPadding = 8;
  final double arrowWidth = 40;
  final int badge = 99;
  final FilterController _filterController = Get.find();
  HiveService hiveService = Get.find();

  @override
  Widget build(BuildContext context) {
    _filterController.context = context;
    return WillPopScope(
      onWillPop: () async {
        Get.back(id:  route,result: _filterController.record.value);
        _filterController.record.clear();
        _filterController.selevtedVisibility.value = false;
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Obx(
            () => Column(
              children: [
                CommonWidgets.titleBar(context,
                    title: "All Categories", fontSize: 20, onPress: () {
                  _filterController.selevtedVisibility.value = false;
                  if (_filterController.record.isEmpty) {
                    Get.back(id: route,result: _filterController.record.value);
                  } else {
                    Get.back(id: route,result: _filterController.record.value);
                  }

                  _filterController.record.clear();
                }),

                /// Category Reset Bar

                HeaderText(
                  leadingText: (!_filterController.selevtedVisibility.value)
                      ? "Categories"
                      : "Selected Categories",
                  trailing: TextButton(
                      onPressed: () {
                        if (_filterController.record.isNotEmpty) {
                          _filterController.resetList();
                          _filterController.selevtedVisibility.value = false;
                          _filterController.update();
                        }
                        _filterController.listBack.value = false;
                      },
                      child: GetBuilder<FilterController>(
                          init: _filterController,
                          builder: (controller) {
                            return AppText(_filterController.record.isNotEmpty
                                ? "Reset"
                                : "");
                          })),
                ),

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
                                        productHeight: productHeight + 45,
                                        brandHeight: brandHeight),
                                // future: _homeScreenController.productCategoryAPI(),
                                future: _filterController.api(),
                                checkInternet: true,
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
                                  height: productHeight + 10,
                                  alignment: Alignment.center,
                                  width: Get.width,
                                  child: const AppText("No Category Selected"),
                                )
                              : Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Obx(
                                          () => Visibility(
                                            visible: controller
                                                .listSelectedBack.value,
                                            child: Container(
                                              alignment: Alignment.center,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              height: brandHeight,
                                              width: arrowWidth,
                                              padding: EdgeInsets.only(
                                                  left:
                                                      productArrowIconPadding),
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
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            height: productHeight + 45,
                                            width: Get.width,
                                            child: ListView.builder(
                                                padding: 30.pr,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                controller: controller
                                                    .selectedProductScrollController,
                                                itemCount: controller
                                                    .unSelectedRecords
                                                    .value
                                                    .length,
                                                itemBuilder: (ctx, index) {
                                                  ProductCategoryItem item =
                                                      controller
                                                          .unSelectedRecords
                                                          .value[index];
                                                  return CatCard(
                                                    title: item.categoryName,
                                                    imageUrl:
                                                        item.categoryImage,
                                                    visible: _filterController
                                                        .containItem(item),
                                                    isCheck: true,
                                                    onTap: () {
                                                      _filterController
                                                          .addToWish(item);
                                                    },
                                                  );

                                                  //   GestureDetector(
                                                  //   onTap: () {
                                                  //     _filterController
                                                  //         .addToWish(item);
                                                  //   },
                                                  //   child: Container(
                                                  //     padding: 30.pl,
                                                  //     height: productHeight,
                                                  //     child: Column(
                                                  //       mainAxisAlignment:
                                                  //           MainAxisAlignment
                                                  //               .end,
                                                  //       children: [
                                                  //         Stack(
                                                  //           alignment: Alignment
                                                  //               .topRight,
                                                  //           children: [
                                                  //             SizedBox(
                                                  //               height:
                                                  //                   productHeight -
                                                  //                       25,
                                                  //               child: Image
                                                  //                   .network(
                                                  //                 item.categoryImage ??
                                                  //                     "",
                                                  //                 errorBuilder: (BuildContext
                                                  //                         ctx,
                                                  //                     Object
                                                  //                         error,
                                                  //                     stackTrace) {
                                                  //                   return Center(
                                                  //                       child: Image
                                                  //                           .asset(
                                                  //                     ImagePathAssets
                                                  //                         .noImageFound,
                                                  //                     alignment:
                                                  //                         Alignment
                                                  //                             .center,
                                                  //                     fit: BoxFit
                                                  //                         .fitHeight,
                                                  //                     // height: height,
                                                  //                   ));
                                                  //                 },
                                                  //               ),
                                                  //             ),
                                                  //             Visibility(
                                                  //               visible: _filterController
                                                  //                   .containItem(
                                                  //                       item),
                                                  //               child: Transform
                                                  //                   .translate(
                                                  //                 offset:
                                                  //                     const Offset(
                                                  //                         18,
                                                  //                         -8),
                                                  //                 child:
                                                  //                     const Icon(
                                                  //                   Icons
                                                  //                       .check_circle,
                                                  //                   color: AppColors
                                                  //                       .appGreen,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //         // 4.shb,
                                                  //         AppText(
                                                  //           // controller
                                                  //           //         .record
                                                  //           //         .value[index]
                                                  //           item.categoryName ??
                                                  //               "",
                                                  //           fontSize: 14,
                                                  //           maxLines: 1,
                                                  //           fontWeight:
                                                  //               FontWeight.w600,
                                                  //         ),
                                                  //       ],
                                                  //     ),
                                                  //   ),
                                                  // );
                                                }),
                                          ),
                                        ),
                                        Obx(
                                          () {
                                            return Visibility(
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
                                                            curve: Curves
                                                                .decelerate);
                                                  },
                                                  child: AppIcons.next(
                                                      iconColor:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .color!),
                                                ),
                                              ),
                                            );
                                          },
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
                // 10.shb,

                /// Category Reset Bar
                // GetBuilder<FilterController>(
                //   init: _filterController,
                //   builder: (ctx) => AppText("label"),
                // ),
                GetBuilder<FilterController>(
                  init: _filterController,
                  builder: (ctx) => Visibility(
                    visible: _filterController.record.isNotEmpty,
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              CommonUtils.toCheckInternet(action: () async {
                                _filterController.unSelectedList();
                                _filterController.showCategories(context);
                                _filterController.searchFromStart();
                                _filterController.update();
                              });
                              _filterController.update();
                            },
                            child: Container(
                                width: 150,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(16)),
                                child: const Center(
                                  child: AppText(
                                    "Search",
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ))),
                        Container(
                          height: 1,
                          color: Colors.black12,
                          margin: 8.pv,
                        ),
                      ],
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
                    ? Expanded(
                        child: Center(
                          child: GetBuilder<FilterController>(
                              init: _filterController,
                              builder: (controller) {
                                return AppText(!_filterController.record.isNotEmpty
                                    ? "Select a category to continue..."
                                    : "Tap to search to continue...");
                              })
                          // AppText(
                          //   !_filterController.selevtedVisibility.value
                          //       ? "Select a category to continue..."
                          //       : "",
                          //   maxLines: 4,
                          // ),
                        ),
                      )
                    : Expanded(
                        child: PaginationWidget(
                          showRefresh: false,
                          length: _filterController.searchListLength,
                          apiBool: _filterController.searchsBool,
                          api: _filterController.searchsAPI,
                          update: _filterController.update,
                          scrollController:
                              _filterController.searchScrollController,
                          totalRecords: _filterController.searchsTotalDeals,
                          child: GetBuilder<FilterController>(
                            init: _filterController,
                            builder: (ctx) {
                              if (_filterController.searchList.isEmpty &&
                                  _filterController.searchsBool.value == true) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (_filterController.searchList.isEmpty &&
                                  _filterController.searchsBool.value ==
                                      false) {
                                return CommonWidgets.noData(
                                    update: _filterController.update,
                                    context: context,
                                    onTap: () {
                                      _filterController.searchsBool.value =
                                          true;
                                      _filterController.update();
                                      _filterController.searchsAPI();
                                    });
                              }
                              return ListView.separated(
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 6),
                                controller:
                                    _filterController.searchScrollController,
                                itemCount:
                                    _filterController.searchList.length + 1,
                                itemBuilder: (ctx, index) {
                                  ProductDetailsResponse details =
                                      ProductDetailsResponse();
                                  if (index !=
                                      _filterController.searchList.length) {
                                    details =
                                        _filterController.searchList[index];
                                  }
                                  return index !=
                                          _filterController.searchList.length
                                      ? GestureDetector(
                                          onTap: () {
                                            // hiveService.recentFavourite(
                                            //     item: RecentSearch(
                                            //         productSearched:
                                            //             filterController.controller.text));
                                            Get.toNamed(AppRoutes.categoryItemDetail,id: 3,
                                                arguments: { "details" :   ProductDetailsResponse(
                                                    id: details.id)});
                                            // Get.toNamed(
                                            //     AppRoutes
                                            //         .dailyDealProductDetail,
                                            //     arguments: [
                                            //       ProductDetailsResponse(
                                            //           id: details.id)
                                            //     ]);
                                          },
                                          child: Container(
                                            height: 80,
                                            margin: 20.ph,
                                            decoration: CustomBoxDecorations(
                                                    context: context)
                                                .shadow(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10)),
                                                  child: CommonWidgets
                                                      .networkImage(
                                                          height: 80,
                                                          width: Get.width * .3,
                                                          imageUrl: details.url
                                                              .toString(),
                                                          fit: BoxFit.cover),
                                                ),
                                                SizedBox(
                                                  height: 80,
                                                  width: Get.width * .7 - 40,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      (details.catName ==
                                                                  null ||
                                                              details.catName ==
                                                                  "")
                                                          ? const SizedBox()
                                                          : Container(
                                                              padding: const EdgeInsets
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
                                                                            Radius.circular(10),
                                                                      )),
                                                              child: AppText(
                                                                details.catName!
                                                                    .toUpperCase(),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        width:
                                                            Get.width * .7 - 40,
                                                        child: AppText(
                                                          details.itemName
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
                                        )
                                      // CardView(
                                      //   index: index,
                                      //   details: details,
                                      //   onTap: () {
                                      //     Get.toNamed(AppRoutes.dailyDealProductDetail,
                                      //         arguments: [details]);
                                      //   },
                                      //   imgUrl: details.url!,
                                      //   cardText: details.itemName!,
                                      // )
                                      // searchsCard(details, index, context, dailyDeals: true)
                                      : Obx(
                                          () => Visibility(
                                            visible: _filterController
                                                .searchsBool.value,
                                            child: Container(
                                                height: 80,
                                                alignment: Alignment.center,
                                                child:
                                                    const CircularProgressIndicator()),
                                          ),
                                        );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 18,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )
                // GetBuilder(
                //         id: "search",
                //         init: _filterController,
                //         builder: (ctr) => Expanded(
                //           child: FutureBuilder<List<SearchPosts>>(
                //             future: FetchSearchList().productDetails(
                //                 "","",
                //                 // _filterController.controller.text,
                //                 // _filterController.postType,
                //                 _filterController.getIntList()),
                //             builder: (ctx, snapshot) {
                //               if (snapshot.connectionState ==
                //                   ConnectionState.waiting) {
                //                 return const Center(
                //                     child: CircularProgressIndicator());
                //               }
                //               if (snapshot.hasError) {
                //                 if (_filterController.controller.text.isEmpty) {
                //                   return const Center(
                //                     child: AppText(
                //                       "Select a category to continue...",
                //                       maxLines: 4,
                //                     ),
                //                   );
                //                 }
                //                 return const Center(
                //                   child: AppText(
                //                     somethingWentWrongTxt,
                //                     maxLines: 4,
                //                   ),
                //                 );
                //               }
                //               if (snapshot.data!.isEmpty) {
                //                 return const Center(
                //                   child: AppText(noDealsTxt),
                //                 );
                //               }
                //
                //               return ListView.separated(
                //                   padding: 10.pv,
                //                   itemCount: snapshot.data!.length,
                //                   separatorBuilder:
                //                       (BuildContext context, int index) {
                //                     return 10.shb;
                //                   },
                //                   itemBuilder:
                //                       (BuildContext context, int index) {
                //                     return GestureDetector(
                //                       onTap: () {
                //                         hiveService.addToRecentList(
                //                             RecentSearch(
                //                                 productSearched:
                //                                     _filterController
                //                                         .controller.text));
                //                         Get.toNamed(
                //                             AppRoutes.dailyDealProductDetail,
                //                             arguments: [
                //                               ProductDetailsResponse(
                //                                   id: snapshot.data![index].id)
                //                             ]);
                //                       },
                //                       child: Container(
                //                         height: 80,
                //                         margin: 20.ph,
                //                         decoration: CustomBoxDecorations(
                //                                 context: context)
                //                             .shadow(),
                //                         child: Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.end,
                //                           children: [
                //                             ClipRRect(
                //                               borderRadius:
                //                                   const BorderRadius.only(
                //                                       topLeft:
                //                                           Radius.circular(10),
                //                                       bottomLeft:
                //                                           Radius.circular(10)),
                //                               child: CommonWidgets.networkImage(
                //                                   height: 80,
                //                                   width: Get.width * .3,
                //                                   imageUrl: snapshot
                //                                       .data![index].url
                //                                       .toString(),
                //                                   fit: BoxFit.cover),
                //                             ),
                //                             SizedBox(
                //                               height: 80,
                //                               width: Get.width * .7 - 40,
                //                               child: Column(
                //                                 crossAxisAlignment:
                //                                     CrossAxisAlignment.start,
                //                                 mainAxisAlignment:
                //                                     MainAxisAlignment
                //                                         .spaceBetween,
                //                                 children: [
                //                                   (snapshot.data![index]
                //                                                   .categoryName ==
                //                                               null ||
                //                                           snapshot.data![index]
                //                                                   .categoryName ==
                //                                               "")
                //                                       ? const SizedBox()
                //                                       : Container(
                //                                           padding:
                //                                               const EdgeInsets
                //                                                       .symmetric(
                //                                                   horizontal:
                //                                                       12,
                //                                                   vertical: 3),
                //                                           decoration:
                //                                               BoxDecoration(
                //                                                   color: AppColors
                //                                                       .primary,
                //                                                   borderRadius:
                //                                                       const BorderRadius
                //                                                           .only(
                //                                                     bottomRight:
                //                                                         Radius.circular(
                //                                                             10),
                //                                                   )),
                //                                           child: AppText(
                //                                             snapshot
                //                                                 .data![index]
                //                                                 .categoryName!
                //                                                 .toUpperCase(),
                //                                             fontWeight:
                //                                                 FontWeight.bold,
                //                                             color: Colors.white,
                //                                             fontSize: 12,
                //                                           ),
                //                                         ),
                //                                   SizedBox(
                //                                     width: Get.width * .7 - 40,
                //                                     child: AppText(
                //                                       snapshot
                //                                           .data![index].itemName
                //                                           .toString(),
                //                                       fontWeight:
                //                                           FontWeight.w600,
                //                                       fontSize: 14,
                //                                       maxLines: 2,
                //                                     ).paddingSymmetric(
                //                                         horizontal: 8,
                //                                         vertical: 4),
                //                                   ),
                //                                 ],
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                     );
                //
                //                     //   ListTile(
                //                     //   onTap: () {},
                //                     //   contentPadding: 16.ph,
                //                     //   leading: Image.asset(
                //                     //     ImagePathAssets.hwLogoUnnamed,
                //                     //     height: 40,
                //                     //     width: 40,
                //                     //   ),
                //                     //   title:
                //                     //       AppText("${snapshot.data![index].productName}"),
                //                     // );
                //                   });
                //             },
                //           ),
                //         ),
                //       )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({Key? key, this.leadingText, this.trailing})
      : super(key: key);
  final String? leadingText;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.ph,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            leadingText ?? "",
            fontWeight: FontWeight.w600,
          ),
          trailing ?? 0.shb,
        ],
      ),
    );
  }
}
