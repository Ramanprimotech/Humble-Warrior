import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/utils/search_bar/search_bar_UI.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: AppText(
                  "Categories",
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 70,
                width: Get.height,
                child: ListView.builder(
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
              Flexible(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: AppText(
                        "Deals",
                        fontSize: 24,
                      ),
                    ),
                    ...HomeOptions.homeOptionsList
                        .map<Widget>(
                            (e) => homeOption(homeOptions: e, index: 1))
                        .toList(),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const AppText(
                          "BRAND'S I",
                          fontSize: 24,
                        ),
                        AppIcons.heart(
                          iconColor: Colors.red,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 80,
                      width: Get.height,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 25,
                          itemBuilder: (ctx, index) {
                            return SizedBox(
                              height: 80,
                              width: 120,
                              child: Column(
                                children: [
                                  CommonWidgets.networkImage(
                                    alignment: Alignment.bottomCenter,
                                    imageUrl: controller.brands[index % 4],
                                    fit: BoxFit.contain,
                                    height: 80,
                                    width: 110,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget homeOption({required HomeOptions homeOptions, required int index}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.homeOptions, arguments: <int>[index]);
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CommonWidgets.networkImage(
              imageUrl: homeOptions.image,
              fit: BoxFit.fitWidth,
              height: 200,
              alignment: Alignment.topCenter,
              width: Get.width,
            ),
          ),
          Positioned(
            bottom: 20,
            left: (Get.width - 250) / 2,
            right: (Get.width - 250) / 2,
            child: Container(
              height: 40,
              width: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.white),
              child: AppText(
                homeOptions.text,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
