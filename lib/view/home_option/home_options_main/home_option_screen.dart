import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/view/home_option/tab_screens/front_page_deals.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/app_icons.dart';
import '../../../utils/search_bar/search_bar_ui.dart';
import '../tab_screens/donnas_deals.dart';
import '../tab_screens/donnas_favourite.dart';
import 'home_option_controller.dart';

class HomeOptionScreen extends GetView<HomeOptionController> {
  const HomeOptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FToast().init(context);
    const double tabFontSize = 18;
    final HomeOptionController controller = Get.find();
    controller.context = context;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 15,
        leadingWidth: 35,
        centerTitle: false,
        title: CustomSearchBar(
          focusNode: controller.focusNode,
          textEditingController: controller.searchTextController,
        ),
        leading: AppIcons.IosBackIcon(),
        bottom: TabBar(
          padding: 0.pt,
            isScrollable: true,
            controller: controller.tabController,
            tabs: <Widget>[
              AppText(
                donnaDailyDealTxt.upperCamelCase,
                fontSize: tabFontSize,
              ),
              AppText(donnaFavouriteDealTxt.upperCamelCase,
                  fontSize: tabFontSize),
              AppText(donnaFrontPageDealTxt.upperCamelCase,
                  fontSize: tabFontSize)
            ]),
        actions: [
          IconButton(padding: 20.pr, onPressed: () {}, icon: AppIcons.filter())
        ],
      ),
      body: Padding(
        padding: 15.pt,
        child: TabBarView(
          controller: controller.tabController,
          children: const [
            DonnaDailyDeals(),
            DonnaFavourite(),
            FrontPageDeals(),
          ],
        ),
      ),
    );
  }
}
