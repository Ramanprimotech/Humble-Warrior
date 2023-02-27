import 'package:flutter/material.dart';
import 'package:humble_warrior/modals/abstract_enums/donna_options.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/view/wish_list/wish_list_controller.dart';
import 'package:humble_warrior/view/wish_list/wish_list_widgets/wish_list_all_button.dart';
import 'package:humble_warrior/view/wish_list/wish_list_widgets/wish_list_single_card.dart';

import '../../../modals/response/donna_deals_response.dart';
import '../../../modals/response/donna_favourite_response_model.dart';
import '../../../modals/response/front_page_response_model.dart';

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
    DonnaDealsDetails donnaDealsDetails = details;
    return WishListCard(
      onTap: onTap.donnaDeals,
      imageUrl: donnaDealsDetails.url!,
      title: donnaDealsDetails.dealName!,
      buttons: wishListButton.donnaDeals(),
      deal: donnaDailyDealTxt,
    );
  }

  @override
  donnaFavourite() {
    DonnaFavouriteDetails donnaFavouriteDetails = details;
    return WishListCard(
      onTap: onTap.donnaFavourite,
      deal: donnaFrontPageDealTxt,
      imageUrl: donnaFavouriteDetails.url!,
      title: donnaFavouriteDetails.productName!,
      buttons: wishListButton.donnaFavourite(),
    );
  }

  @override
  frontPage() {
    FrontPageDetails frontPageDetails = details;
    return WishListCard(
      onTap: onTap.frontPage,
      deal: donnaFrontPageDealTxt,
      imageUrl: frontPageDetails.url!,
      title: frontPageDetails.productName!,
      buttons: wishListButton.frontPage(),
    );
  }
}
