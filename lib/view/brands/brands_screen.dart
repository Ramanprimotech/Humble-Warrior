import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/brands_response_mdel.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

import '../../network/endpoints.dart';
import '../../utils/future_widget/future_widget.dart';
import 'brands_api_widget.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeScreenController homeScreenController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidgets.titleBar(context,
                  title: "$brandsTxt I", icon: true, fontSize: 20),
              Expanded(
                child: Container(
                  padding: 20.ph,
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                  height: Get.height,
                  width: Get.height,
                  child: GetBuilder<HomeScreenController>(
                      id: Endpoints.allBrands,
                      init: homeScreenController,
                      builder: (controller) {
                        return FutureWidget<List<BrandDetails>>().builder(
                            futureWidgets: BrandAPIWidgets(context: context),
                            future: controller.allBrands(),
                            context: context);
                      }),
                ),
              ),
            ]),
      ),
    );
  }
}
