import 'package:flutter/material.dart';
import 'package:humble_warrior/modals/abstract_enums/donna_options.dart';
import 'package:humble_warrior/modals/response/donna_deals_response.dart';
import 'package:humble_warrior/modals/response/donna_favourite_response_model.dart';
import 'package:humble_warrior/modals/response/front_page_response_model.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/view/home_option/tab_screens/donnas_deals.dart';

import '../../home_option/tab_screens/front_page_deals.dart';

class WishListButton implements DonnaOptions {
  final dynamic details;
  final int index;
  final BuildContext context;
  WishListButton({
    required this.details,
    required this.index,
    required this.context,
  });

  @override
  donnaDeals() {
    DonnaDealsDetails donnaDealsDetails = details;
    return donnaDealsButton(donnaDealsDetails, index, context);
  }

  @override
  donnaFavourite() {
    DonnaFavouriteDetails donnaFavouriteDetails = details;
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Heart(
            color: Theme.of(context).textTheme.displayMedium!.color,
            key: Key(index.toString()),
            size: 28,
          ),
        ],
      ),
    );
  }

  @override
  frontPage() {
    FrontPageDetails frontPageDetails = details;
    return frontPageButton(frontPageDetails, index, context);
  }
}
