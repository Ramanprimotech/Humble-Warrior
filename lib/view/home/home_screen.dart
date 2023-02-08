import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/image_path_network.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/utils/search_bar/search_bar_UI.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

import '../bottom_navigation/bottom_navigation_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
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
                             "https://www.freepnglogos.com/uploads/shoes-png/mens-shoes-png-transparent-images-images-11.png",
                              fit: BoxFit.fitHeight,
                              height: 50,
                            ),
                            const AppText(
                              "Product",fontSize: 12,
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
                        child: GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoutes.homeOptions);
                          },
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
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 15,),
              _brandRow(),
              SizedBox(
                height: 80,
                width: Get.height,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 25,
                    itemBuilder: (ctx, index) {
                      return SizedBox(
                        height: 80,
                        width: 100,
                        child: Column(
                          children: [
                            Image.network(
                              "https://seeklogo.com/images/A/adidas-logo-107B082DA0-seeklogo.com.png",
                              fit: BoxFit.fill,
                              height: 80,
                              width: 80,
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

  _brandRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            AppText(
              "BRAND'S I",
              fontSize: 18,
            ),
            AppIcons.heart(
              iconColor: Colors.red,
            ),
          ],
        ),
        AppText(
          "View All",
          fontSize: 16,
        ),
      ],
    );
  }

}
