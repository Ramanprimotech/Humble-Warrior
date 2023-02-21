import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/brands_response_mdel.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/utils/shimmer/shimmer_loader.dart';
import 'package:humble_warrior/view/brands/brands_controller.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

import '../../utils/search_bar/search_bar_ui.dart';

class BrandsScreen extends StatelessWidget {
    const BrandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BrandsController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: CustomSearchBar(textEditingController: TextEditingController(), focusNode: FocusNode(),),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _aboutButton(),
          Expanded(
            child: Container(
              color: Theme.of(context)
                  .floatingActionButtonTheme
                  .backgroundColor,
              height: Get.height,
              width: Get.height,
              child: GetBuilder<HomeScreenController>(
                builder: (controller){
                  return FutureBuilder<List<BrandDetails>>(
                      future: controller.allBrands(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.vertical,
                            itemCount: 25,
                            itemBuilder: (ctx, index) {
                              return Container(
                                color: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .backgroundColor,
                                // height: 60,
                                // width: 80,
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
                          return Center(child: AppText(somethingTxt));
                        }
                        List<BrandDetails> data = snapshot.data ?? [];
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 40.0,
                            mainAxisSpacing: 60.0,
                            childAspectRatio: 2,
                          ),
                          itemCount: data.length,
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () {
                                // CommonUtils().urlLauncher(
                                //     url: data[index].brandLink!);
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child:
                                      Image.asset(
                                        alignment: Alignment.center,
                                   data[index].brandImage!,
                                  fit: BoxFit.contain,
                                  width: Get.width,),
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
                          },);
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

    _aboutButton() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(bottom: 40),
        width: MediaQuery.of(Get.context!).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 1,
                blurRadius: 1,
                // offset: const Offset(0, 3),
              )
            ]),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppText(
              "${brandsTxt} I",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            5.sw,
            Padding(
              padding: EdgeInsets.only(top: 2),
              child: AppIcons.heart(
                iconColor: Colors.red,
              ),
            ),
          ],
        ),
      );
    }

}
