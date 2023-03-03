import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

import '../../modals/response/brands_response_mdel.dart';
import '../../modals/response/home_categories_response_model.dart';
import '../../network/endpoints.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import '../../utils/common/common_functionality.dart';
import '../../utils/common/common_widgets.dart';
import '../../utils/decorations.dart';
import '../../utils/future_widget/abstract_future_widget.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/shimmer/shimmer_loader.dart';
import '../../utils/theme_extention/custom_notice_theme_extention.dart';

class BrandAPIWidgets extends FutureAPI<List<BrandDetails>> {
  final BuildContext context;

  BrandAPIWidgets({required this.context});

  final HomeScreenController controller = Get.find();

  @override
  Widget error({Object? error}) {
    DialogueThemeExtention dialogueThemeExtention =
        Theme.of(context).extension<DialogueThemeExtention>()!;
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
        crossAxisCount: 3,
        crossAxisSpacing: 40.0,
        mainAxisSpacing: 60.0,
        childAspectRatio: 1.5,
      ),
      itemCount: dataa.length,
      itemBuilder: (ctx, index) {
        BrandDetails brandDetails = dataa[index];
        return GestureDetector(
          onTap: () async {
            await CommonUtils().urlLauncher(url: brandDetails.brandLink!);
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: 10.pa,
                  decoration: CustomBoxDecorations()
                      .shadow(context: context, color: Colors.grey.shade200),
                  child: Image.asset(
                    alignment: Alignment.center,
                    brandDetails.brandImage!,
                    fit: BoxFit.contain,
                    width: Get.width,
                  ),
                ),
                // CommonWidgets.networkImage(
                //   alignment: Alignment.center,
                //   imageUrl: data[index].brandImage!,
                //   fit: BoxFit.contain,
                //
                //   width: Get.width,
                // ),
              ),
              // 5.sh,
              // AppText(data[index].brandName!, fontSize: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget waiting() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 40.0,
        mainAxisSpacing: 60.0,
        childAspectRatio: 1.5,
      ),
      itemCount: 20,
      itemBuilder: (ctx, index) {
        return Container(
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          height: 60,
          width: 80,
          child: Column(
            children: const [
              ShimmerLoader(
                  child: AppText(
                "HW",
                fontWeight: FontWeight.w900,
                fontSize: 35,
              )),
            ],
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
