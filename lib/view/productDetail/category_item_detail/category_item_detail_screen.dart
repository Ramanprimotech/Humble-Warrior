import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/donna_deals_response.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/common/common_appBar.dart';
import 'package:humble_warrior/utils/decorations.dart';
import 'package:humble_warrior/utils/search_bar/search_bar_ui.dart';
import 'package:humble_warrior/view/home_option/common_home_option.dart';
import 'package:humble_warrior/view/productDetail/category_item_detail/category_item_detail_controller.dart';
import 'package:humble_warrior/view/productDetail/product_detail_widget.dart';
import 'package:readmore/readmore.dart';

class CategoryItemDetail extends StatelessWidget with ProductDetailWidget {
   CategoryItemDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryItemDetailController controller = Get.find();
    final DonnaDealsDetails donnaDealsDetails = Get.arguments[0];
    return Scaffold(
      appBar: CommonAppBar().AppBarWidget(
        showBackButton: true,
        title: CustomSearchBar(
          focusNode: controller.focusNode,
          textEditingController: controller.searchTextController,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: categoryListCard(donnaDealsDetails, 0, context, categoryCard: false),
            ),
            productTitleDetail(context, donnaDealsDetails.dealName),
            productDesc(),
          ],
        ),
      ),
    );
  }

   Widget productTitleDetail(context, title) {
     return Container(
       decoration: CustomBoxDecorations().shadow(context: context),
       width: MediaQuery.of(Get.context!).size.width * .9,
       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
       margin: const EdgeInsets.symmetric(vertical: 12),
       child: AppText(
             "$title",
             fontWeight: FontWeight.bold,
             fontSize: 20,
             maxLines: 3,
           ),
     );
   }

   /// Product Description
   Widget productDesc() {
     return Container(
       padding: const EdgeInsets.symmetric(horizontal: 5),
       width: MediaQuery.of(Get.context!).size.width * .9,
       child: const ReadMoreText(
             AppStrings.lorem,
             trimLines: 20,
             colorClickableText: Colors.pink,
             trimMode: TrimMode.Length,
             trimCollapsedText: readmoreTxt,
             trimExpandedText: readlessTxt,
             lessStyle: TextStyle(
                 fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue),
             moreStyle: TextStyle(
                 fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue),
           ),
     );
   }

}
