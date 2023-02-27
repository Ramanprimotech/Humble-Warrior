import 'package:flutter/material.dart';
import 'package:humble_warrior/view/wish_list/wish_list_widgets/wish_list_all_cards.dart';

class WishListCardSelector extends StatelessWidget {
  final int index;
  final dynamic details;
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

    int type = index % 3;

    if (type == 0) {
      return wishListCards.donnaDeals();
    }
    if (type == 1) {
      return wishListCards.donnaFavourite();
    }

    return wishListCards.frontPage();
  }
}
