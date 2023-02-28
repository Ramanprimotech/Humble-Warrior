import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
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

        /// App Bar
        appBar: homeScreenWidgets.appBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.sh,

            ///Home Screen Categories List
            homeScreenWidgets.productList(),
            8.sh,

            ///Home Option List Future Builder
            homeScreenWidgets.homeOptionDeals(),

            /// Brand List Future Builder
            homeScreenWidgets.brandsList(),
          ],
        ),
      ),
    );
  }
}
