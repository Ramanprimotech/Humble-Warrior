import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/home/home_product_category_api_widgets.dart';

class HomeScreenWidgets {
  final HomeScreenController controller;
  final BuildContext context;

  HomeScreenWidgets({
    required this.controller,
    required this.context,
  });

  final double productHeight = 60;
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
      title: const SearchBar(
        route: 3,
      ),
      actions: [
        Padding(
          padding: 25.pr,
          child: InkWell(
            onTap: () {
              CommonUtils.toCheckInternet(action: () {
                Get.toNamed(AppRoutes.notification, id: 3);
              });
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
              checkInternet: true,
              context: context
          );
        });
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
              checkInternet: false,
              future: controller.productCategoryAPI(),
              context: context);
        });
  }

  /// Brand List API Builder
  GetBuilder<HomeScreenController> brandListAPIBuilder({waitingState}) {
    return GetBuilder<HomeScreenController>(
        id: Endpoints.allBrands,
        init: controller,
        builder: (controller) {
          return FutureWidget<List<BrandDetails>>().builder(
              futureWidgets: HomePageBrandAPIWidgets(context: context),
              future: controller.allBrands(),
              waiting: waitingState,
              checkInternet: false,
              context: context);
        });
  }
}
