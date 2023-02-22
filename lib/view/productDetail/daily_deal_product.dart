import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/image_path_network.dart';
import 'package:humble_warrior/utils/search_bar/search_bar_ui.dart';
import 'package:humble_warrior/view/home_option/common_home_option.dart';
import 'package:humble_warrior/view/productDetail/daily_deal_product_controller.dart';

import 'product_detail_widget.dart';

class DailyDealProduct extends StatelessWidget with ProductDetailWidget {
  DailyDealProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DailyDealProductController controller = Get.find();
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
                  padding: 20.pl,
                  child: AppIcons.backArrrowIos(),
                )),
          ),
        ),
      ),
      // CustomAppBar(
      //   title: CustomSearchBar(
      //     textEditingController: TextEditingController(),
      //     focusNode: FocusNode(),
      //   ),
      //   showBackButton: true,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: ItemCard(
                radius: 10,
                buttons: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        shopButton(url: "${'https://humblewarrior.com'}"),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // controller.select.value = !controller.select.value;
                          },
                          icon: Heart(
                            size: 28,
                          ),
                        ),
                        shareButton(shareUrl: "shareUrl"),
                      ],
                    ),
                  ],
                ),
                imageUrl: ImagePathNetwork.banner,
                title: 'Title Of Image',
              ),
            ),
            productText(context),
            productDescription(),
          ],
        ),
      ),
    );
  }
}
