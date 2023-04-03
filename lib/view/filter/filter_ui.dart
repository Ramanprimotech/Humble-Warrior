import 'package:humble_warrior/modals/response/product_category_response.dart';
import 'package:humble_warrior/view/filter/filter_controller.dart';
import 'package:humble_warrior/view/filter/filter_product_category_api_widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonWidgets.titleBar(context, title: filterTxt, fontSize: 20,
                onPress: () {
              if (_filterController.record.isEmpty) {
                Get.back(result: []);
              } else {
                Get.back();
              }
            }),

            /// Category Reset Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText("All Categories"),
                TextButton(
                    onPressed: () {
                      _filterController.resetList();
                    },
                    child: const AppText("Reset")),
              ],
            ).px(16),

            /// List To Select From
            GetBuilder<FilterController>(
                id: Endpoints.productCategories,
                init: _filterController,
                builder: (controller) {
                  return FutureWidget<List<ProductCategoryItem>>().builder(
                      futureWidgets: FilterPageProductCategoryAPIWidgets(
                          context: context,
                          productHeight: productHeight,
                          brandHeight: brandHeight),
                      future: _homeScreenController.productCategoryAPI(),
                      context: context);
                }),
            10.shb,

            /// Category Reset Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(""),
                GestureDetector(
                  onTap: () {
                    _filterController.showCategories(context);
                  },
                  child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: AppText(
                          _filterController.selevtedVisibility.value &&
                                  _filterController.record.length != 0
                              ? "Hide"
                              : "Show",
                          color: AppColors.white,
                        ),
                      ).px(14).py(2),
                    ).p(16),
                  ),
                ),
              ],
            ),
            10.shb,

            ///Visible Selected
            Obx(
              () => Visibility(
                visible: _filterController.selevtedVisibility.value &&
                    _filterController.record.length != 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText("Selected Categories").px(16),
                    10.shb,

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
                                                    duration: const Duration(
                                                        milliseconds: 150),
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
                                        margin: 8.pv,
                                        height: productHeight + 10,
                                        width: Get.width,
                                        child: ListView.builder(
                                            padding: 30.pr,
                                            scrollDirection: Axis.horizontal,
                                            controller: controller
                                                .selectedProductScrollController,
                                            itemCount:
                                                controller.record.value.length,
                                            itemBuilder: (ctx, index) {
                                              ProductCategoryItem item =
                                                  controller
                                                      .record.value[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  controller.removeFromWish(
                                                      controller
                                                          .record.value[index]);
                                                },
                                                child: Container(
                                                  padding: 30.pl,
                                                  height: productHeight,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Stack(
                                                        alignment:
                                                            Alignment.topRight,
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                productHeight -
                                                                    25,
                                                            child:
                                                                Image.network(
                                                              item.categoryImage ??
                                                                  "",
                                                              errorBuilder:
                                                                  (BuildContext
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
                                                          Transform.translate(
                                                            offset:
                                                                Offset(18, -8),
                                                            child: const Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color: AppColors
                                                                  .appGreen,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // 4.shb,
                                                      AppText(
                                                        controller
                                                                .record
                                                                .value[index]
                                                                .categoryName ??
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
                                      visible:
                                          controller.listSelectedForward.value,
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
                                                    duration: const Duration(
                                                        milliseconds: 150),
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
            GetBuilder<FilterController>(
              init: _filterController,
              builder: (controller) => Visibility(
                visible: controller.record.isNotEmpty &&
                    controller.selevtedVisibility.value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText(""),
                    GestureDetector(
                      onTap: () {
                        controller.showResult();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Center(
                          child: AppText(
                            "Show Result",
                            color: AppColors.white,
                          ),
                        ).px(14).py(2),
                      ).p(16),
                    ),
                  ],
                ),
              ),
            ),
            10.shb,
          ],
        ),
      ),
    );
  }
}
