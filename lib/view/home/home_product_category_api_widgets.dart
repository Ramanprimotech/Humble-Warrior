import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/response/product_category_response.dart';

class HomePageProductCategoryAPIWidgets
    extends FutureAPI<List<ProductCategoryItem>> {
  final BuildContext context;
  final double productHeight;
  final double brandHeight;

  HomePageProductCategoryAPIWidgets(
      {required this.context,
      required this.productHeight,
      required this.brandHeight});

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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: dialogueThemeExtention.buttonColor,
        ),
        onPressed: () {
          controller.update([Endpoints.productCategories]);
          // Get.toNamed(AppRoutes.categoryDetailsList, arguments: ["sd", "66"]);
        },
        child: const AppText('Retry',
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget success({List<ProductCategoryItem>? data}) {
    List<ProductCategoryItem> record = data ?? [];
    // record.sort((a, b) => a.id!.compareTo(b.id!));
    const double productArrowIconPadding = 8;
    const double arrowWidth = 40;
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Obx(
              () => Visibility(
                visible: controller.listBack.value,
                child: Container(
                  alignment: Alignment.center,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height: brandHeight,
                  width: arrowWidth,
                  padding: const EdgeInsets.only(left: productArrowIconPadding),
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
            Expanded(
              child: SizedBox(
                height: productHeight,
                width: Get.width,
                child: ListView.builder(
                    padding: 30.pr,
                    scrollDirection: Axis.horizontal,
                    controller: controller.productScrollController,
                    itemCount: record.length,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.categoryDetailsList,
                              arguments: [
                                record[index].categoryName,
                                record[index].id.toString(),
                              ]);
                        },
                        child: Container(
                          padding: 30.pl,
                          height: productHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: productHeight - 20,
                                child: Image.network(
                                    errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                      child: Image.asset(
                                    ImagePathAssets.noImageFound,
                                    alignment: Alignment.center,
                                    fit: BoxFit.fitHeight,
                                    // height: height,
                                  ));
                                }, record[index].categoryImage ?? ""),
                              ),
                              // 4.shb,
                              AppText(
                                record[index].categoryName ?? "",
                                fontSize: 14,
                                maxLines: 1,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.listForward.value,
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
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget waiting() {
    const double productArrowIconPadding = 8;
    const double arrowWidth = 30;
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Expanded(
              // flex: 8,
              child: SizedBox(
                height: productHeight,
                width: Get.width,
                child: ListView.builder(
                    padding: 8.ph,
                    scrollDirection: Axis.horizontal,
                    controller: controller.productScrollController,
                    itemCount: 10,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: 5.ph,
                        child: GestureDetector(
                          onTap: () {},
                          child: ShimmerLoader(
                            child: Container(
                              padding: 10.ph,
                              height: productHeight,
                              color: Colors.grey,
                              width: 80,
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
                padding: const EdgeInsets.only(left: productArrowIconPadding),
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
}
