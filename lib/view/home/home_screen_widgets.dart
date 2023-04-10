import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/home/home_product_category_api_widgets.dart';

class HomeScreenWidgets {
  final HomeScreenController controller;
  final BuildContext context;

  HomeScreenWidgets({
    required this.controller,
    required this.context,
  });

  final double productHeight = 65;
  final double brandLoveHeight = 39;
  final double brandHeight = 63;
  final double productArrowIconPadding = 8;
  final double arrowWidth = 30;
  final int badge = 99;

  final NotificationController _notificationController = Get.find();

  /// App Bar
  AppBar appBar(BuildContext context) {
    ImageIconTheme imageIconTheme =
        Theme.of(context).extension<ImageIconTheme>()!;
    return AppBar(
      centerTitle: false,
      title: const SearchBar(),
      actions: [
        Padding(
          padding: 25.pr,
          child: InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.notification);
            },
            child: GetBuilder<NotificationController>(
              init: _notificationController,
              id: "badge",
              builder: (ctx) {
                return FutureBuilder<NotificationResponseModel>(
                    future: ctx.notificationList(),
                    builder: (context, snapshot) {
                      NotificationResponseModel data =
                          snapshot.data ?? NotificationResponseModel(posts: []);
                      int notificationCount = data.posts!
                          .where((element) => element.read == false)
                          .length;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Image.asset(
                          ImagePathAssets.bellIcon,
                          height: 28,
                          fit: BoxFit.fitHeight,
                          color: imageIconTheme.backGroundColor,
                        );
                      }
                      if (snapshot.hasError) {
                        return Image.asset(
                          ImagePathAssets.bellIcon,
                          height: 28,
                          fit: BoxFit.fitHeight,
                          color: imageIconTheme.backGroundColor,
                        );
                      }
                      if (data.posts!.isEmpty) {
                        return Image.asset(
                          ImagePathAssets.bellIcon,
                          height: 28,
                          fit: BoxFit.fitHeight,
                          color: imageIconTheme.backGroundColor,
                        );
                      }
                      return notificationCount == 0
                          ? Image.asset(
                              ImagePathAssets.bellIcon,
                              height: 28,
                              fit: BoxFit.fitHeight,
                              color: imageIconTheme.backGroundColor,
                            )
                          : Badge(
                              textColor: Colors.white,
                              label: AppText("$notificationCount", fontSize: 8),
                              alignment: const AlignmentDirectional(15.0, -3.0),
                              child: Image.asset(
                                ImagePathAssets.bellIcon,
                                height: 28,
                                fit: BoxFit.fitHeight,
                                color: imageIconTheme.backGroundColor,
                              ));
                    });
              },
            ),
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

  /// Brand List
  Widget brandsList() {
    final ImageIconTheme imageIconTheme =
        Theme.of(context).extension<ImageIconTheme>()!;
    return Container(
      height: brandHeight + brandLoveHeight + 10,
      decoration: BoxDecoration(
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
  }

  /// Brand Title Row
  Widget _brandRow({required double height, required BuildContext context}) {
    final ShadowTheme shadowTheme = Theme.of(context).extension<ShadowTheme>()!;
    return Container(
      height: height,
      padding: const EdgeInsets.only(top: 4, right: 16, left: 16, bottom: 8),
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
                "$brandsTxt I",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              5.swb,
              Padding(
                padding: 3.pb,
                child: AppIcons.heart(
                    iconColor: Colors.red, size: Dimens.smallIcon),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.brands);
            },
            child: const AppText(
              viewAllTxt,
              fontSize: 14,
              color: AppColors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
