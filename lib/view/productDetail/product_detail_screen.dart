import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/image_path_network.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/view/home_option/common_home_option.dart';
import 'package:humble_warrior/view/productDetail/product_detail_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/app_icons.dart';
import '../../utils/search_bar/search_bar_ui.dart';
import 'product_detail_controller.dart';

class ProductDetailScreen extends StatelessWidget with ProductDetailWidget {
  ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailController controller = Get.find();
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
      // AppBar(
      //   centerTitle: true,
      //   title: CustomSearchBar(
      //     focusNode: controller.focusNode,
      //     textEditingController: controller.searchTextController,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ItemCard(
                onTap: () {
                  Get.toNamed(AppRoutes.productDetail);
                },
                buttons: shopSubButton(
                    shopNowUrl: 'https://humblewarrior.com',
                    subscribeUrl: '',
                    shareUrl: 'https://humblewarrior.com'),
                buttonbarHeight: 60,
                imageUrl: ImagePathNetwork.banner,
                title: 'Title Of Image',
              ),
            ),
            productText(),
            productDescription(),
          ],
        ).p(10),
      ),
    );
  }
}
