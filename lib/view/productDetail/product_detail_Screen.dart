import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/view/productDetail/product_detail_widget.dart';

import '../../utils/search_bar/search_bar_UI.dart';
import 'product_detail_controller.dart';

class ProductDetailScreen extends StatelessWidget with ProductDetailWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomSearchBar(
          focusNode: controller.focusNode,
          textEditingController: controller.searchTextController,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            productText(),
            shopSubButton(),
            productDescription(),
          ],
        ),
      ),
    );
  }
}
