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
      title: const SearchBar(),
      actions: [
        Padding(
          padding: 25.pr,
          child: InkWell(
            onTap: () {
              CommonUtils.toCheckInternet(action: (){
                Get.toNamed(AppRoutes.notification);
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
              context: context);
        });
  }

/*  /// Brand List
  GetBuilder<HomeScreenController> brandsList() {
    return GetBuilder<HomeScreenController>(
      id: Endpoints.allBrands,
      init: controller,
      builder: (controller){
        return FutureWidget<List<BrandDetails>>().builder(
          futureWidgets: HomePageBrandAPIWidgets(context: context),
          future: controller.allBrands(),
          checkInternet: false,
          context: context);
      },
    );
  }*/

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

  /*/// Brand Title Row
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
  }*/
}
