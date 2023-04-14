import 'package:humble_warrior/hw.dart';

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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: dialogueThemeExtention.buttonColor,
        ),
        onPressed: () {
          controller.update([Endpoints.productCategories]);
        },
        child: const AppText('Retry',
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget success({List<ProductCategoryItem>? data}) {
    productCategory = data ?? [];
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
                    return CatCard(
                      imageUrl: record[index].categoryImage,
                      title: record[index].categoryName,
                      onTap: () {
                        Get.toNamed(AppRoutes.categoryDetailsList, arguments: [
                          record[index],
                        ]);
                      },
                    );
                  },
                ),
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
    return SizedBox(
      height: productHeight,
      width: Get.width,
      child: ListView.builder(
          padding: 8.ph,
          scrollDirection: Axis.horizontal,
          controller: controller.productScrollController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: 16.pl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CustomShimmer.circular(height: 45, width: 45),
                  CustomShimmer.rectangular(height: 10, width: 60),
                ],
              ),
            );
          }),
    );
  }
}
