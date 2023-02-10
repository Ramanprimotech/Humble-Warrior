import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/front_page_response_model.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/extentions/color_string_extention.dart';

import '../../utils/app_text.dart';
import '../../utils/custom_paint/ribbon.dart';
import 'common_home_option.dart';
import 'home_option_controller.dart';

class FrontPageDeals extends StatelessWidget {
  const FrontPageDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeOptionController controller = Get.find();
    return NotificationListener<ScrollNotification>(
      key: UniqueKey(),
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          // onLoadMore();
          print("object");
          if (controller.frontPageDealsBool.value == false) {
            controller.frontPageDealsBool.value = true;
            controller.update();
            Future.delayed(Duration(milliseconds: 10), () {
              controller.frontPageDealScrollController.animateTo(
                controller
                    .frontPageDealScrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
              );
            });

            controller.frontPageDealsAPI();
          }
        }
        return true;
      },
      child: GetBuilder<HomeOptionController>(
        init: controller,
        builder: (ctx) {
          if (controller.frontPageDealList.isEmpty &&
              controller.frontPageDealsBool.value == true) {
            return Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                AppText(
                  " Loading Deals for you...",
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ));
          }
          if (controller.frontPageDealList.isEmpty &&
              controller.frontPageDealsBool.value == false) {
            return const Center(
              child: AppText(
                "No Data Found",
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            );
          }
          return ListView.builder(
              controller: controller.frontPageDealScrollController,
              itemCount: controller.frontPageDealList.length + 1,
              itemBuilder: (ctx, index) {
                FrontPageDetails details = FrontPageDetails();
                if (index != controller.frontPageDealList.length) {
                  details = controller.frontPageDealList[index];
                }
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: index != controller.frontPageDealList.length
                          ? ItemCard(
                              buttons: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  shareButton(shareUrl: "shareUrl"),
                                  IconButton(
                                    onPressed: () {},
                                    icon: AppIcons.bookmarks(),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: AppIcons.comment(),
                                  ),
                                ],
                              ),
                              imageUrl: details.url!,
                              title: details.productName.toString(),
                            )
                          : Obx(
                              () => Visibility(
                                  visible: controller.frontPageDealsBool.value,
                                  child: Container(
                                      height: 80,
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator())),
                            ),
                    ),
                    Positioned(
                      top: (220 / 4) - 4,
                      left: (-220 / 4) + 16,
                      child: Transform.rotate(
                        angle: (360 - 45) * 3.1415927 / 180,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              size: Size(220, 40),
                              //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                              painter: FrontPageBanner(
                                  color: details.ribbonColor != null
                                      ? details.ribbonColor!.toColor()
                                      : Colors.transparent),
                            ),
                            AppText(
                              "${details.ribbonName}",
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
    // return ListView.builder(itemBuilder: (ctx, index) {
    //   return Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: ItemCard(
    //       buttons: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           shareButton(shareUrl: "shareUrl"),
    //           IconButton(
    //             onPressed: () {},
    //             icon: AppIcons.bookmarks(),
    //           ),
    //           IconButton(
    //             onPressed: () {},
    //             icon: AppIcons.comment(),
    //           ),
    //         ],
    //       ),
    //       imageUrl:
    //           "https://humblewarrior.com/wp-content/uploads/2022/11/ANRABESS-2022-Fall-Winter-Long-Sleeve-1-4-Zipper-Collared-Casual-Chunky-Cable-Knit-Cropped-Pullover-11-15-22-LIVE-PIC-SMC.jpg",
    //       title: 'Title Of Image',
    //     ),
    //   );
    // });
  }
}
