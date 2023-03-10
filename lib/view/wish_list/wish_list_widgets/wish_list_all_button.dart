import 'package:flutter/material.dart';
import 'package:humble_warrior/modals/abstract_enums/donna_options.dart';
import 'package:humble_warrior/modals/response/product_details_response.dart';
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
    ProductDetailsResponse donnaDealsDetails = details;
    return donnaDealsButton(donnaDealsDetails, index, context);
  }

  @override
  donnaFavourite() {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Heart(
            id: details.id.toString(),
            item: details,
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
    ProductDetailsResponse frontPageDetails = details;
    return frontPageButton(frontPageDetails, index, context);
  }
}
