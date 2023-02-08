import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/image_path_network.dart';
import 'package:humble_warrior/view/productDetail/product_detail_widget.dart';
import 'package:velocity_x/velocity_x.dart';

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
            GestureDetector(
              onTap: (){
                controller.getImagePath();
              },
                child: "Pick Image".text.make().p(10)),
              controller.imagePath == null ?Image.network(ImagePathNetwork.image4,height: 100,) :
              GetBuilder(
                init: controller,
                  builder: (ProductDetailController controller) {
                   return Image.file(controller.imagePath!).p(10);
                  },
              ),
            productText(),
            shopSubButton(),
            productDescription(),
          ],
        ),
      ),
    );
  }
}
