import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/decorations.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/theme_extention/custom_notice_theme_extention.dart';

import '../../modals/response/brands_response_mdel.dart';
import '../../network/endpoints.dart';
import '../../utils/app_text.dart';
import '../../utils/common/common_functionality.dart';
import '../../utils/common/common_widgets.dart';
import '../../utils/future_widget/abstract_future_widget.dart';
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
    return Padding(
      padding: 5.pb,
      child: ListView.separated(
        padding: 16.ph,
        scrollDirection: Axis.horizontal,
        controller: controller.brandScrollController,
        itemCount: record.length,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              CommonUtils().urlLauncher(url: record[index].brandLink!);
            },
            child: Container(
              width: 90,
              height: 60,
              padding: 5.pa,
              margin: 2.pa,
              decoration: CustomBoxDecorations()
                  .shadow(context: context, color: Colors.grey.shade200),
              child: CommonWidgets.networkImage(
                alignment: Alignment.center,
                imageUrl: record[index].brandImage!,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return 10.sw;
        },
      ),
    );
  }

  @override
  Widget waiting() {
    return ListView.separated(
      padding: 20.ph,
      scrollDirection: Axis.horizontal,
      itemCount: 25,
      itemBuilder: (ctx, index) {
        return ShimmerLoader(
          child: Container(
            width: 100,
            height: 60,
            // color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            decoration: CustomBoxDecorations().shadow(
              context: context,
              color:
                  Theme.of(context).floatingActionButtonTheme.backgroundColor,
            ),
            /*height: 60,
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
            ),*/
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return 10.sw;
      },
    );
  }
}
