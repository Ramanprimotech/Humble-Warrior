import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/theme_extention/custom_notice_theme_extention.dart';

import '../../modals/response/brands_response_mdel.dart';
import '../../modals/response/home_categories_response_model.dart';
import '../../network/endpoints.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import '../../utils/common/common_functionality.dart';
import '../../utils/common/common_widgets.dart';
import '../../utils/future_widget/abstract_future_widget.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/shimmer/shimmer_loader.dart';
import 'home_controller.dart';

class HomePageBrandAPIWidgets extends FutureAPI<List<BrandDetails>> {
  final BuildContext context;

  HomePageBrandAPIWidgets({required this.context});

  final HomeScreenController controller = Get.find();

  @override
  Widget error({Object? error}) {
    DialogueThemeExtention dialogueThemeExtention =
        Theme.of(context).extension<DialogueThemeExtention>()!;
    return Expanded(
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            // fixedSize: const Size(, 35),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: dialogueThemeExtention.buttonColor,
          ),
          onPressed: () {
            controller.update([Endpoints.allBrands]);
          },
          child: const AppText('Retry',
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget success({List<BrandDetails>? data}) {
    List<BrandDetails> dataa = data ?? [];
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      controller: controller.brandScrollController,
      itemCount: dataa.length,
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () {
            CommonUtils().urlLauncher(url: dataa[index].brandLink!);
          },
          child: SizedBox(
            height: 60,
            width: 80,
            child: Column(
              children: [
                // CommonWidgets.networkImage(
                //   alignment: Alignment.center,
                //   imageUrl: dataa[index].brandImage!,
                //   fit: BoxFit.contain,
                //   height: 60,
                //   width: 80,
                // ),
                Image.asset(
                  alignment: Alignment.center,
                  dataa[index].brandImage!,
                  fit: BoxFit.contain,
                  height: 60,
                  width: 80,
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return 20.sw;
      },
    );
  }

  @override
  Widget waiting() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: 25,
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
      separatorBuilder: (BuildContext context, int index) {
        return 20.sw;
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
