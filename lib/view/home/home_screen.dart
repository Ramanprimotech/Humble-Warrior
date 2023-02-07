import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/image_path_network.dart';
import 'package:humble_warrior/utils/search_bar/search_bar_UI.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.find();
    return SafeArea(
      child: Scaffold(
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
            children: [
              const SizedBox(
                height: 8,
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
                            Image.network(
                              ImagePathNetwork.feature,
                              fit: BoxFit.fitHeight,
                              height: 50,
                            ),
                            Text(
                              "Product",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Divider(
                color: AppColors.grey,
                height: 2,
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: HomeOptions.homeOptionsList.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                HomeOptions.homeOptionsList[index].image,
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
                                  HomeOptions.homeOptionsList[index].text,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Divider(
                color: AppColors.grey,
                height: 10,
              ),
              Row(
                children: [
                  AppText(
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
                            Image.network(
                              ImagePathNetwork.feature,
                              fit: BoxFit.fitHeight,
                              height: 50,
                            ),
                            Text(
                              "Product",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
