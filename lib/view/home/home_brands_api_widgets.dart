import 'package:humble_warrior/hw.dart';

class HomePageBrandAPIWidgets extends FutureAPI<List<BrandDetails>> {
  final BuildContext context;

  HomePageBrandAPIWidgets({required this.context});

  /// Brands Item Params
  final double width = 80;
  final double height = 60;
  final EdgeInsets padding = 5.pa;
  final EdgeInsets margin = 3.pa;
  final double brandHeight = 63;
  final double brandLoveHeight = 39;
  final double productArrowIconPadding = 8;
  final double arrowWidth = 30;
  final int badge = 99;


  /// Brands List Params
  final double separatorHeight = 10;
  final EdgeInsets listPadding =
      const EdgeInsets.only(left: 20, right: 20, bottom: 5);

  /// Home Screen Controller
  final HomeScreenController controller = Get.find();

  @override
  Widget error({Object? error}) {
    DialogueThemeExtention dialogueThemeExtention =
        Theme.of(context).extension<DialogueThemeExtention>()!;
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          // fixedSize: const Size(, 35),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: dialogueThemeExtention.buttonColor,
        ),
        onPressed: () {
          controller.update([Endpoints.allBrands]);
        },
        child: const AppText('Retry',
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget success({List<BrandDetails>? data}) {
    List<BrandDetails> record = data ?? [];
    final ImageIconTheme imageIconTheme =
    Theme.of(context).extension<ImageIconTheme>()!;
    return Column(
      children: [
        SizedBox(),
        Container(
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
                          child: ListView.separated(
                            padding: listPadding,
                            scrollDirection: Axis.horizontal,
                            controller: controller.brandScrollController,
                            itemCount: record.length,
                            itemBuilder: (ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  CommonUtils().urlLauncher(url: record[index].brandLink!);
                                },
                                child: Container(
                                  width: width,
                                  height: height,
                                  padding: padding,
                                  margin: margin,
                                  decoration: CustomBoxDecorations(context: context)
                                      .shadow(color: Colors.grey.shade200),
                                  child: CommonWidgets.networkImage(
                                    alignment: Alignment.center,
                                    imageUrl: record[index].brandImage!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return separatorHeight.swb;
                            },
                          ),
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
        ),
      ],
    );
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


  @override
  Widget waiting() {
    return ListView.separated(
      padding: listPadding,
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (ctx, index) {
        return
            // Container(
            //   color: Colors.transparent,
            // );
            CustomShimmer.rectangular(width: width, height: height);
      },
      separatorBuilder: (BuildContext context, int index) {
        return separatorHeight.swb;
      },
    );
  }
}
