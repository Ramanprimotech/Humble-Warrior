import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/brands_response_mdel.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/utils/shimmer/shimmer_loader.dart';
import 'package:humble_warrior/utils/theme_extention/shadow_theme_extention.dart';
import 'package:humble_warrior/view/brands/brands_controller.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

import '../../utils/decorations.dart';
import '../../utils/search_bar/search_bar_ui.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BrandsController controller = Get.find();
    ShadowTheme shadowTheme = Theme.of(context).extension<ShadowTheme>()!;
    return Scaffold(
      appBar: AppBar(
        title: CustomSearchBar(
          textEditingController: TextEditingController(),
          focusNode: FocusNode(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _aboutButton(context, shadowTheme.shadowColor!),
              Expanded(
                child: Container(
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                  height: Get.height,
                  width: Get.height,
                  child: GetBuilder<HomeScreenController>(
                    builder: (controller) {
                      return FutureBuilder<List<BrandDetails>>(
                          future: controller.allBrands(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ListView.separated(
                                padding: 20.ph,
                                scrollDirection: Axis.vertical,
                                itemCount: 25,
                                itemBuilder: (ctx, index) {
                                  return Container(
                                    decoration: CustomBoxDecorations()
                                        .shadow(context: context),
                                    child: Column(
                                      children: const [
                                        ShimmerLoader(
                                            child: AppText(
                                          hmTxt,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 35,
                                        )),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return 20.sw;
                                },
                              );
                            }
                            if (snapshot.hasError) {
                              return const Center(child: AppText(somethingTxt));
                            }
                            List<BrandDetails> data = snapshot.data ?? [];
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 40.0,
                                mainAxisSpacing: 60.0,
                                childAspectRatio: 1.5,
                              ),
                              itemCount: data.length,
                              itemBuilder: (ctx, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: CustomBoxDecorations()
                                              .shadow(
                                                  context: context,
                                                  color: Colors.grey.shade200),
                                          child: Padding(
                                            padding: 10.pa,
                                            child: Image.asset(
                                              alignment: Alignment.center,
                                              data[index].brandImage!,
                                              fit: BoxFit.contain,
                                              width: Get.width,
                                            ),
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
                            /*ListView.separated(
                        // physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              CommonUtils().urlLauncher(
                                  url: data[index].brandLink!);
                            },
                            child: SizedBox(
                              // height: 60,
                              // width: 80,
                              child: Column(
                                children: [
                                  CommonWidgets.networkImage(
                                    alignment: Alignment.center,
                                    imageUrl: data[index].brandImage!,
                                    fit: BoxFit.contain,
                                    height: 80,
                                    width: Get.width,
                                  ),
                                  5.sh,
                                  AppText(data[index].brandName!, fontSize: 22),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder:
                            (BuildContext context, int index) {
                          return 50.sh;
                        },
                      );*/
                          });
                    },
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  _aboutButton(context, color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: 40.pb,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: CustomBoxDecorations().shadow(context: context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppText(
            "$brandsTxt I",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          5.sw,
          Padding(
            padding: 2.pt,
            child: AppIcons.heart(
              iconColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
