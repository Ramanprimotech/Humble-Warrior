import 'package:humble_warrior/hw.dart';

class HomePageCategoryAPIWidgets extends FutureAPI<List<HomeCategoryList>> {
  final BuildContext context;

  HomePageCategoryAPIWidgets({required this.context});

  final double productHeight = 60;
  final double brandLoveHeight = 55;
  final double brandHeight = 60;

  final HomeScreenController controller = Get.find();

  @override
  Widget error({Object? error}) {
    return Expanded(
      child: CommonWidgets.errorAPI(
          buttonTitle: retryTxt,
          errorText: somethingWentWrongTxt.toString(),
          context: context,
          onPress: () => controller.update([Endpoints.homeCategories])),
    );
  }

  @override
  Widget success({List<HomeCategoryList>? data}) {
    List<HomeCategoryList> record = data ?? [];
    record.sort((a, b) => a.id!.compareTo(b.id!));
    return Expanded(
      child: CustomRefreshIndicator(
        onRefresh: () {
          controller.update([Endpoints.homeCategories]);

          return Future.value(0);
        },
        child: ListView.builder(
          padding: 10.pb,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            return homeOption(homeOptions: record[index], index: index)
                .paddingOnly(bottom: index == record.length - 1 ? 20 : 0);
          },
          itemCount: record.length,
        ),
      ),
    );
  }

  @override
  Widget waiting() {
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          return const CustomShimmer.rectangular(
            height: 220,
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 6),
          );
        },
      ),
    );
  }

  /// Home Options
  Widget homeOption(
      {required HomeCategoryList homeOptions, required int index}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 6),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.homeOptions, arguments: <int>[homeOptions.id!]);
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              decoration:
                  CustomBoxDecorations(context: context).shadow(radius: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CommonWidgets.networkImage(
                  imageUrl: homeOptions.categoryImage!,
                  fit: BoxFit.fitWidth,
                  height: 220,
                  alignment: Alignment.topCenter,
                  // width: Get.width,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topRight: Radius.circular(10),
                  )),
              child: AppText(
                homeOptions.categoryName!.toUpperCase(),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
