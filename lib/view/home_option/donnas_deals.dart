import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/donna_deals_response.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/view/home_option/home_option_controller.dart';

import 'common_home_option.dart';

class DonnaDailyDeals extends StatelessWidget {
  const DonnaDailyDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeOptionController controller = Get.find();
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          // onLoadMore();
          print("object");
          if (controller.donnaDealsBool == false) {
            controller.donnaDealsBool.value = true;
            controller.update();
            Future.delayed(Duration(milliseconds: 10), () {
              controller.donnaDealScrollController.animateTo(
                controller.donnaDealScrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
              );
            });

            controller.donaDealsAPI();
          }
        }
        return true;
      },
      child: GetBuilder<HomeOptionController>(
        init: controller,
        builder: (ctx) {
          if (controller.donnaDealList.isEmpty &&
              controller.donnaDealsBool.value == true) {
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
          if (controller.donnaDealList.isEmpty &&
              controller.donnaDealsBool.value == false) {
            return const Center(
              child: AppText(
                "No Data Found",
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            );
          }
          return ListView.builder(
              controller: controller.donnaDealScrollController,
              itemCount: controller.donnaDealList.length + 1,
              itemBuilder: (ctx, index) {
                DonnaDealsDetails details = DonnaDealsDetails();
                if (index != controller.donnaDealList.length) {
                  details = controller.donnaDealList[index];
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: index != controller.donnaDealList.length
                      ? ItemCard(
                          buttons: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              shopButton(url: "${details.shopUrl}"),
                              !(details.couponCode == null ||
                                      details.couponCode == "")
                                  ? codeButton(code: "${details.couponCode}")
                                  : const SizedBox(
                                      width: 80,
                                    ),
                              shareButton(shareUrl: "shareUrl"),
                              IconButton(
                                onPressed: () {},
                                icon: AppIcons.bookmarks(),
                              ),
                            ],
                          ),
                          imageUrl: details.url!,
                          title: details.dealName!,
                        )
                      : Obx(
                          () => Visibility(
                              visible: controller.donnaDealsBool.value,
                              child: Container(
                                  height: 80,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator())),
                        ),
                );
              });
        },
      ),
    );
  }
}
