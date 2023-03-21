import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/utils/common/photo_viewer.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/view/home_option/common_home_option.dart';
import 'package:humble_warrior/view/home_option/tab_screens/donnas_deals.dart';
import 'package:humble_warrior/view/wish_list/wish_list_widgets/wish_list_all_cards.dart';

class WishListCardSelector extends StatelessWidget {
  final int index;
  final ProductDetailsResponse details;
  final BuildContext context;

  const WishListCardSelector(
      {Key? key,
      required this.index,
      required this.details,
      required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    WishListCards wishListCards =
        WishListCards(details: details, index: index, context: context);

    String type = details.catName ?? "";

    if (type == "Donna Daily Deals") {
      return wishListCards.donnaDeals();
    }
    if (type == "Favourite Things") {
      return wishListCards.donnaFavourite();
    }
    if (type == "Front Page Deals") {
      return wishListCards.frontPage();
    }

    return categoryListWishListCard(details, index, context,
        categoryCard: true);
  }
}

ItemCard categoryListWishListCard(
    ProductDetailsResponse details, int index, BuildContext context,
    {bool? categoryCard = false, bool isDetails = false}) {
  return ItemCard(
    onTap: () {
      if (isDetails) {
        if (details.url != "" || details.url != null) {
          Get.to(CustomPhotoViewer(url: details.url!));
        }
      } else {
        Get.toNamed(AppRoutes.categoryItemDetail, arguments: [details]);
      }
    },
    imageHeight: 180,
    radius: 10,
    buttons:
        donnaDealsButton(details, index, context, categoryCard: categoryCard),
    imageUrl: details.url!,
    title: "",
    effect: false,
    buttonbarHeight: categoryCard == true ? 85 : 50,
  );
}
