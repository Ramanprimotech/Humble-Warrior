import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/utils/search_bar/search_bar_ui.dart';
import 'package:humble_warrior/utils/theme_extention/account_option_theme_extentions.dart';
import 'package:humble_warrior/view/productDetail/favourite_deals_controller.dart';

class FavouriteDeals extends StatelessWidget {
  const FavouriteDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountOptionTheme accountOptionTheme =
    Theme.of(Get.context!).extension<AccountOptionTheme>()!;
    FavouriteDealController controller = Get.find();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
    child: CustomAppBar(
    title: CustomSearchBar(textEditingController: TextEditingController(), focusNode: FocusNode(),),
    showBackButton: true,
    ),
      ),
      body: Container(
        padding: 20.ph,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          SizedBox(
            height: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CommonWidgets.networkImage(
                imageUrl: "https://humblewarrior.com/wp-content/uploads/2022/11/Facetune_20-06-2022-06-51-2.jpg",
                alignment: Alignment.topCenter,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: 10.pv,
            padding: 7.pv,
            width: Get.width/1.5,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10)
            ),
            child: AppText(
              'Dress!!',color: Colors.white,textAlign: TextAlign.left,
              fontWeight: FontWeight.bold,
              padding: 5.pl,
              fontSize: 20,
            ),
          ),
              Container(
                padding: 15.pv,
                width: MediaQuery.of(Get.context!).size.width * .9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.lorem,style: TextStyle(fontSize: 15,color: accountOptionTheme.textColor),)
                  ],
                ),
              ),
              _buyNow(title: 'Mobile App here'),
              _buyNow(title: 'Standard View'),
        ]),
      ),
    );
  }

  _buyNow({title}){
    return Row(children: [
      AppText("${title} ------->"),
      10.sw,
      Container(
        margin: 10.pv,
        padding: 8.ph,
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10)
        ),
        child: AppText(
          buyNowTxt,color: Colors.white,textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    ],);
  }

}
