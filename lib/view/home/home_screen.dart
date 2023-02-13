import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/view/home/home_controller.dart';
import 'package:humble_warrior/view/home/home_screen_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.find();
    final HomeScreenWidgets homeScreenWidgets =
        HomeScreenWidgets(controller: controller, context: context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        ///Brand List Future Builder
        floatingActionButton: homeScreenWidgets.brandsList(),

        /// App Bar
        appBar: homeScreenWidgets.appBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),

            /// Product List Future Builder
            homeScreenWidgets.productList(),

            const SizedBox(
              height: 8,
            ),

            ///Home Option List Future Builder
            homeScreenWidgets.homeOptionList(),
          ],
        ),
      ),
    );
  }
}
