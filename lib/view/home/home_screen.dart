import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/utils/search_bar/search_bar_UI.dart';
import 'package:humble_warrior/utils/shimmer/shimmer_loader.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

import '../../modals/response/brands_response_mdel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double productHeight = 70;
    double brandLoveHeight = 55;
    double brandHeight = 50;

    final HomeScreenController controller = Get.find();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: false,
          title: CustomSearchBar(
            focusNode: controller.focusNode,
            textEditingController: controller.searchTextController,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: InkWell(
                  onTap: () {}, child: AppIcons.notificationActice(size: 28)),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              // margin: EdgeInsets.symmetric(horizontal: 20),
              height: productHeight,
              width: Get.width,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: 25,
                  itemBuilder: (ctx, index) {
                    return SizedBox(
                      height: 80,
                      width: 68,
                      child: Column(
                        children: [
                          CommonWidgets.networkImage(
                              imageUrl: controller.products[index % 4],
                              fit: BoxFit.fitHeight,
                              height: 50,
                              scale: 0.7),
                          const AppText(
                            "Product",
                            fontSize: 12,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              // height: Get.height -
              //     productHeight -
              //     brandHeight -
              //     brandLoveHeight -
              //     16 -
              //     AppBar().preferredSize.height,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return homeOption(
                      homeOptions: HomeOptions.homeOptionsList[index],
                      index: index);
                },
                itemCount: HomeOptions.homeOptionsList.length,
              ),
            ),
            _brandRow(height: brandLoveHeight),
            SizedBox(
              height: brandHeight,
              width: Get.height,
              child: FutureBuilder<List<BrandDetails>>(
                  future: controller.allBrands(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: 25,
                        itemBuilder: (ctx, index) {
                          return SizedBox(
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
                    if (snapshot.hasError) {
                      return AppText("Something Went Wrong");
                    }
                    List<BrandDetails> data = snapshot.data ?? [];
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            CommonUtils()
                                .urlLauncher(url: data[index].brandLink!);
                          },
                          child: SizedBox(
                            height: 60,
                            width: 80,
                            child: Column(
                              children: [
                                CommonWidgets.networkImage(
                                  alignment: Alignment.bottomCenter,
                                  imageUrl: data[index].brandImage!,
                                  fit: BoxFit.contain,
                                  height: 40,
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
                  }),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _brandRow({required double height}) {
    return Container(
      height: height,
      padding: EdgeInsets.only(top: 15, right: 20, left: 20, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                offset: Offset(-2, -3), blurRadius: 2, color: Colors.black12),
            BoxShadow(
                offset: Offset(2, -3), blurRadius: 2, color: Colors.black12)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppText(
                "BRAND'S  I",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              5.sw,
              AppIcons.heart(
                iconColor: Colors.red,
              ),
            ],
          ),
          AppText(
            "VIEW ALL",
            fontSize: 14,
            color: AppColors.blue,
          ),
        ],
      ),
    );
  }
}

Widget homeOption({required HomeOptions homeOptions, required int index}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.homeOptions, arguments: <int>[index]);
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CommonWidgets.networkImage(
              imageUrl: homeOptions.image,
              fit: BoxFit.fitWidth,
              height: 200,
              alignment: Alignment.topCenter,
              // width: Get.width,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(20),
                )),
            child: AppText(
              homeOptions.text,
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
