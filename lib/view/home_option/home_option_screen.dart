import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/view/home_option/Donna_deals.dart';
import 'package:humble_warrior/view/home_option/home_option_controller.dart';

import '../../utils/app_icons.dart';
import '../../utils/search_bar/search_bar_UI.dart';

class HomeOptionScreen extends StatelessWidget {
  const HomeOptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeOptionController controller = Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 35,
          centerTitle: false,
          title: CustomSearchBar(
            focusNode: controller.focusNode,
            textEditingController: controller.searchTextController,
          ),
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: AppIcons.backArrow()),
          bottom: TabBar(controller: controller.tabController, tabs: const <Widget>[
            AppText("Front Page Deals"),
            AppText("Donna's Daily Deals")
          ]),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(onTap: () {}, child: AppIcons.filter()),
            )
          ],
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: [
            DonnaDeals(),
            Text("sddsd"),
          ],
        ),
      ),
    );
  }
}

