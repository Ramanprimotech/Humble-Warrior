
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/view/home_option/donnas_favourite.dart';
import 'package:humble_warrior/view/home_option/front_page_deals.dart';
import 'package:humble_warrior/view/home_option/home_option_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/app_icons.dart';
import '../../utils/search_bar/search_bar_ui.dart';
import 'donnas_deals.dart';

class HomeOptionScreen extends GetView<HomeOptionController> {
  const HomeOptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final HomeOptionController controller = Get.find();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: AppBar(
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
                child: Padding(
                  padding:20.pl,
                  child: AppIcons.backArrrowIos(),
                )),
            bottom: TabBar(
                isScrollable: true,
                controller: controller.tabController,
                tabs: <Widget>[
                  AppText(donnaDailyDealTxt.upperCamelCase),
                  AppText(donnaFavouriteDealTxt.upperCamelCase),
                  AppText(donnaFrontPageDealTxt.upperCamelCase)
                ]),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: InkWell(onTap: () {}, child: AppIcons.filter()),
              )
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: const [
          DonnaDailyDeals(),
          DonnaFavourite(),
          FrontPageDeals(),
        ],
      ),
    );
  }
}
