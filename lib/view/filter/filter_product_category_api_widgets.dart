import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/filter/filter_controller.dart';

class FilterPageProductCategoryAPIWidgets
    extends FutureAPI<List<ProductCategoryItem>> {
  final BuildContext context;
  final double productHeight;
  final double brandHeight;

  FilterPageProductCategoryAPIWidgets({required this.context,
    required this.productHeight,
    required this.brandHeight});

  final FilterController controller = Get.find();

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
        },
        child: const AppText('Retry',
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget success({List<ProductCategoryItem>? data}) {
    List<ProductCategoryItem> record = data ?? [];
    const double productArrowIconPadding = 8;
    const double arrowWidth = 40;
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Obx(
                  () =>
                  Visibility(
                    visible: controller.listBack.value,
                    child: Container(
                      alignment: Alignment.center,
                      color: Theme
                          .of(context)
                          .scaffoldBackgroundColor,
                      height: brandHeight,
                      width: arrowWidth,
                      padding: const EdgeInsets.only(
                          left: productArrowIconPadding),
                      child: GestureDetector(
                        onTap: () {
                          controller.productScrollController.animateTo(
                              controller.productScrollController.offset -
                                  (60 * 3),
                              duration: const Duration(milliseconds: 150),
                              curve: Curves.linear);
                        },
                        child: AppIcons.backArrrowIos(
                            iconColor:
                            Theme
                                .of(context)
                                .textTheme
                                .displaySmall!
                                .color!),
                      ),
                    ),
                  ),
            ),
            Expanded(
              child: GetBuilder<FilterController>(
                  init: controller,
                  builder: (controller) {
                    return SizedBox(
                      height: productHeight + 10,
                      width: Get.width,
                      child: ListView.builder(
                          padding: 30.pr,
                          scrollDirection: Axis.horizontal,
                          controller: controller.productScrollController,
                          itemCount: record.length,
                          itemBuilder: (ctx, index) {
                            return CatCard(
                                title: record[index].categoryName,
                                imageUrl: record[index].categoryImage,
                                visible: controller
                                    .containItem(record[index]),
                                isCheck: true,
                                onTap: ()
                            {
                              controller.addToWish(record[index]);
                            },);

                            //   GestureDetector(
                            //   onTap: () {
                            //     controller.addToWish(record[index]);
                            //   },
                            //   child: Container(
                            //     padding: 30.pl,
                            //     height: productHeight,
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         Stack(
                            //           alignment: Alignment.topRight,
                            //           children: [
                            //             SizedBox(
                            //               height: productHeight - 25,
                            //               child: Image.network(errorBuilder:
                            //                   (context, error, stackTrace) {
                            //                 return Center(
                            //                     child: Image.asset(
                            //                   ImagePathAssets.noImageFound,
                            //                   alignment: Alignment.center,
                            //                   fit: BoxFit.fitHeight,
                            //                   // height: height,
                            //                 ));
                            //               }, record[index].categoryImage ?? ""),
                            //             ),
                            //             Transform.translate(
                            //               offset: const Offset(18, -8),
                            //               child: Visibility(
                            //                 visible: controller
                            //                     .containItem(record[index]),
                            //                 child: const Icon(
                            //                   Icons.check_circle,
                            //                   color: AppColors.appGreen,
                            //                 ),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         // 4.shb,
                            //         AppText(
                            //           record[index].categoryName ?? "",
                            //           fontSize: 14,
                            //           maxLines: 1,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // );
                          }),
                    );
                  }),
            ),
            Obx(
                  () =>
                  Visibility(
                    visible: controller.listForward.value,
                    child: Container(
                      alignment: Alignment.center,
                      color: Theme
                          .of(context)
                          .scaffoldBackgroundColor,
                      height: brandHeight,
                      width: arrowWidth,
                      child: GestureDetector(
                        onTap: () {
                          controller.productScrollController.animateTo(
                              controller.productScrollController.offset +
                                  (60 * 3),
                              duration: const Duration(milliseconds: 150),
                              curve: Curves.linear);
                        },
                        child: AppIcons.next(
                            iconColor:
                            Theme
                                .of(context)
                                .textTheme
                                .displaySmall!
                                .color!),
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
                  CustomShimmer.circular(height: 35, width: 35),
                  CustomShimmer.rectangular(height: 10, width: 60),
                ],
              ),
            );
          }),
    );
  }
}
