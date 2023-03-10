import 'package:flutter/material.dart';
import 'package:humble_warrior/modals/abstract_enums/donna_options.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/view/wish_list/wish_list_controller.dart';
import 'package:humble_warrior/view/wish_list/wish_list_widgets/wish_list_all_button.dart';
import 'package:humble_warrior/view/wish_list/wish_list_widgets/wish_list_single_card.dart';

class WishListCards implements DonnaOptions {
  final dynamic details;
  final int index;
  final BuildContext context;
  late final WishListRouting onTap;
  late final WishListButton wishListButton;

  WishListCards(
      {required this.details, required this.index, required this.context}) {
    onTap = WishListRouting(details: details);
    wishListButton =
        WishListButton(details: details, index: 1, context: context);
  }

  @override
  donnaDeals() {
    ProductDetailsResponse donnaDealsDetails = details;
    return WishListCard(
      onTap: onTap.donnaDeals,
      imageUrl: donnaDealsDetails.url!,
      title: donnaDealsDetails.itemName!,
      buttons: wishListButton.donnaDeals(),
      deal: donnaDailyDealTxt,
    );
  }

  @override
  donnaFavourite() {
    ProductDetailsResponse donnaFavouriteDetails = details;
    return WishListCard(
      onTap: onTap.donnaFavourite,
      deal: donnaFrontPageDealTxt,
      imageUrl: donnaFavouriteDetails.url!,
      title: donnaFavouriteDetails.itemName!,
      buttons: wishListButton.donnaFavourite(),
    );
  }

  @override
  frontPage() {
    ProductDetailsResponse frontPageDetails = details;
    return WishListCard(
      onTap: onTap.frontPage,
      deal: donnaFrontPageDealTxt,
      imageUrl: frontPageDetails.url!,
      title: frontPageDetails.itemName!,
      buttons: wishListButton.frontPage(),
    );
  }
}
