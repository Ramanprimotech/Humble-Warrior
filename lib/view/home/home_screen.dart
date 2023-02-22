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

        /// App Bar
        appBar: homeScreenWidgets.appBar(),
        body: /*Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.bottomCenter,
          children: [*/
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),

            ///Home Screen Categories List
            homeScreenWidgets.productList(),
            const SizedBox(
              height: 8,
            ),

            ///Home Option List Future Builder
            homeScreenWidgets.homeOptionListTwo(),

            /// Brand List Future Builder
            homeScreenWidgets.brandsList(),
          ],
        ),
        /* KeyboardVisibilityBuilder(builder: (context, isKVisible) {
              debugPrint(isKVisible.toString());
              return Visibility(
                  visible: !isKVisible, child: homeScreenWidgets.brandsList());
            }),*/
        //   ],
        // ),
      ),
    );
  }
}
