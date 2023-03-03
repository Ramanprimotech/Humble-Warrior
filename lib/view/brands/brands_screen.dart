import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/brands_response_mdel.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/utils/theme_extention/shadow_theme_extention.dart';
import 'package:humble_warrior/view/brands/brands_controller.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

import '../../network/endpoints.dart';
import '../../utils/decorations.dart';
import '../../utils/future_widget/future_widget.dart';
import 'brands_api_widget.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BrandsController controller = Get.find();
    HomeScreenController homeScreenController = Get.find();
    ShadowTheme shadowTheme = Theme.of(context).extension<ShadowTheme>()!;
    return Scaffold(
      // appBar: AppBar(
      //   leadingWidth: 35,
      //   leading: AppIcons.IosBackIcon(),
      //   title: CustomSearchBar(
      //     textEditingController: TextEditingController(),
      //     focusNode: FocusNode(),
      //   ),
      // ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidgets.titleBar(context,
              title: "$brandsTxt I",icon: true
              ),
              // _aboutButton(context, shadowTheme.shadowColor!),
              Expanded(
                child: Container(
                  padding: 20.ph,
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                  height: Get.height,
                  width: Get.height,
                  child: GetBuilder<HomeScreenController>(
                      id: Endpoints.allBrands,
                      init: homeScreenController,
                      builder: (controller) {
                        return FutureWidget<List<BrandDetails>>().builder(
                            futureWidgets: BrandAPIWidgets(context: context),
                            future: controller.allBrands(),
                            context: context);
                      }),

                  // GetBuilder<HomeScreenController>(
                  //   builder: (controller) {
                  //     return FutureBuilder<List<BrandDetails>>(
                  //         future: controller.allBrands(),
                  //         builder: (context, snapshot) {
                  //           if (snapshot.connectionState ==
                  //               ConnectionState.waiting) {
                  //             return GridView.builder(
                  //               gridDelegate:
                  //                   const SliverGridDelegateWithFixedCrossAxisCount(
                  //                 crossAxisCount: 3,
                  //                 crossAxisSpacing: 40.0,
                  //                 mainAxisSpacing: 60.0,
                  //                 childAspectRatio: 1.5,
                  //               ),
                  //               itemCount: 25,
                  //               itemBuilder: (ctx, index) {
                  //                 return Container(
                  //                   decoration: CustomBoxDecorations()
                  //                       .shadow(context: context),
                  //                   child: Column(
                  //                     children: const [
                  //                       ShimmerLoader(
                  //                           child: AppText(
                  //                         hmTxt,
                  //                         fontWeight: FontWeight.w900,
                  //                         fontSize: 35,
                  //                       )),
                  //                     ],
                  //                   ),
                  //                 );
                  //               },
                  //             );
                  //           }
                  //           if (snapshot.hasError) {
                  //             return const Center(child: AppText(somethingTxt));
                  //           }
                  //           List<BrandDetails> data = snapshot.data ?? [];
                  //
                  //           return GridView.builder(
                  //             gridDelegate:
                  //                 const SliverGridDelegateWithFixedCrossAxisCount(
                  //               crossAxisCount: 3,
                  //               crossAxisSpacing: 40.0,
                  //               mainAxisSpacing: 60.0,
                  //               childAspectRatio: 1.5,
                  //             ),
                  //             itemCount: data.length,
                  //             itemBuilder: (ctx, index) {
                  //               BrandDetails brandDetails = data[index];
                  //               return GestureDetector(
                  //                 onTap: () async {
                  //                   await CommonUtils().urlLauncher(
                  //                       url: brandDetails.brandLink!);
                  //                 },
                  //                 child: Column(
                  //                   children: [
                  //                     Expanded(
                  //                       child: Container(
                  //                         decoration: CustomBoxDecorations()
                  //                             .shadow(
                  //                                 context: context,
                  //                                 color: Colors.grey.shade200),
                  //                         child: Padding(
                  //                           padding: 10.pa,
                  //                           child: Image.asset(
                  //                             alignment: Alignment.center,
                  //                             brandDetails.brandImage!,
                  //                             fit: BoxFit.contain,
                  //                             width: Get.width,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       // CommonWidgets.networkImage(
                  //                       //   alignment: Alignment.center,
                  //                       //   imageUrl: data[index].brandImage!,
                  //                       //   fit: BoxFit.contain,
                  //                       //
                  //                       //   width: Get.width,
                  //                       // ),
                  //                     ),
                  //                     // 5.sh,
                  //                     // AppText(data[index].brandName!, fontSize: 16),
                  //                   ],
                  //                 ),
                  //               );
                  //             },
                  //           );
                  //
                  //         });
                  //   },
                  // ),
                ),
              ),
            ]),
      ),
    );
  }


}
