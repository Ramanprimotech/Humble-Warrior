import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:readmore/readmore.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/sizes/sizes_config.dart';

class ProductDetailWidget {
  Widget productText() {
    return Card(
      elevation: 5,
      color: AppColors.white,
      shadowColor: AppColors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade100,
          width: 1, //<-- SEE HERE
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(Get.context!).size.width * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText("Vine Oh! for the Holidays !"),
            RichText(
              text: const TextSpan(
                text: "The",
                style: TextStyle(color: AppColors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: '  Vine Oh! Ho Ho! Box is here !',
                    style: TextStyle(color: AppColors.blue),
                  ),
                ],
              ),
            ),
          ],
        ).p(20),
      ),
    ).p(10);
  }

  /// Shop/Subscribe Button
  Widget shopSubButton() {
    return Card(
      elevation: 5,
      // shape: RoundedRectangleBorder(
      //   side: BorderSide(
      //     color: Colors.grey.shade100,
      //     width: 1, //<-- SEE HERE
      //   ),
      //   borderRadius: BorderRadius.circular(0.0),
      // ),
      child: Container(
        width: MediaQuery.of(Get.context!).size.width * .9,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            button(title: shopNow, backClr: AppColors.secondary),
            Row(
              children: [
                button(title: subscribe, backClr: AppColors.blue),
                Icon(
                  Icons.share,
                  color: Colors.black,
                  size: Dimens.smallIcon,
                ).px(10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button({required String title, required Color backClr}) {
    return Container(
      decoration:
          BoxDecoration(color: backClr, borderRadius: BorderRadius.circular(6)),
      child: Center(
        child: AppText(
          title,
          color: AppColors.white,
        ),
      ).p(8),
    ).p(10);
  }

  /// Product Description
  Widget productDescription() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade100,
          width: 1, //<-- SEE HERE
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        width: MediaQuery.of(Get.context!).size.width * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              "What is Vine Oh?",
              fontSize: 18,
            ).px(6),
            const ReadMoreText(
              AppStrings.lorem,
              trimLines: 20,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Length,
              trimCollapsedText: 'Show more',
              trimExpandedText: ' Show less',
              lessStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              moreStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ).p(6)
          ],
        ).p(6),
      ),
    ).p(10);
  }
}
