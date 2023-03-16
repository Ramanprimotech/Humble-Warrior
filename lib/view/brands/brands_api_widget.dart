import 'package:humble_warrior/hw.dart';

import '../../modals/response/brands_response_mdel.dart';
import '../../modals/response/home_categories_response_model.dart';

class BrandAPIWidgets extends FutureAPI<List<BrandDetails>> {
  final BuildContext context;

  BrandAPIWidgets({required this.context});

  final HomeScreenController controller = Get.find();

  @override
  Widget error({Object? error}) {
    return CommonWidgets.errorAPI(
        buttonTitle: retryTxt,
        errorText: error.toString(),
        context: context,
        onPress: () => controller.update([Endpoints.allBrands]));
  }

  @override
  Widget success({List<BrandDetails>? data}) {
    List<BrandDetails> dataa = data ?? [];
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.5,
      ),
      itemCount: dataa.length,
      itemBuilder: (ctx, index) {
        BrandDetails brandDetails = dataa[index];
        return GestureDetector(
          onTap: () async {
            await CommonUtils().urlLauncher(url: brandDetails.brandLink!);
          },
          child: Container(
            margin: 3.pa,
            padding: 8.pa,
            decoration: CustomBoxDecorations()
                .shadow(context: context, color: Colors.grey.shade200),
            child: CommonWidgets.networkImage(
              alignment: Alignment.center,
              imageUrl: dataa[index].brandImage!,
              fit: BoxFit.contain,
            ),
            // Image.asset(
            //   alignment: Alignment.center,
            //   brandDetails.brandImage!,
            //   fit: BoxFit.contain,
            //   width: Get.width,
            // ),
          ),
        );
      },
    );
  }

  @override
  Widget waiting() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.5,
      ),
      itemCount: 21,
      itemBuilder: (ctx, index) {
        return ShimmerLoader(
          child: Container(
            margin: 3.pa,
            decoration: CustomBoxDecorations().shadow(
              context: context,
              color:
                  Theme.of(context).floatingActionButtonTheme.backgroundColor,
            ),
            // color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            // height: 60,
            // width: 80,
            // child:
            /*Column(
              children: const [
                ShimmerLoader(
                    child: AppText(
                  "HW",
                  fontWeight: FontWeight.w900,
                  fontSize: 35,
                )),
              ],
            ),*/
          ),
        );
      },
    );
  }

  /// Home Options
  Widget homeOption(
      {required HomeCategoryList homeOptions, required int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.homeOptions, arguments: <int>[homeOptions.id!]);
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CommonWidgets.networkImage(
                imageUrl: homeOptions.categoryImage!,
                fit: BoxFit.fitWidth,
                height: 200,
                alignment: Alignment.topCenter,
                // width: Get.width,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(20),
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
