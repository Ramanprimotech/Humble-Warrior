import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/theme_extention/account_option_theme_extentions.dart';
import 'package:humble_warrior/view/home_option/common_home_option.dart';
import 'package:readmore/readmore.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/common/common_functionality.dart';
import '../../utils/decorations.dart';
import '../../utils/sizes/sizes_config.dart';

class ProductDetailWidget {
  final AccountOptionTheme accountOptionTheme =
      Theme.of(Get.context!).extension<AccountOptionTheme>()!;

  Widget productText(context, title) {
    return Container(
      decoration: CustomBoxDecorations().shadow(context: context),
      width: MediaQuery.of(Get.context!).size.width * .9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            "$title",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          RichText(
            text: TextSpan(
              text: "The",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 15),
              children: <TextSpan>[
                TextSpan(
                  text: '  $title',
                  style: TextStyle(color: AppColors.primary, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ).p(6),
    ).py(10);
  }

  /// Shop/Subscribe Button
  Widget shopSubButton(
      {required String shopNowUrl,
      required String subscribeUrl,
      required String shareUrl}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
            onTap: () {
              CommonUtils().urlLauncher(url: shopNowUrl);
            },
            child: button(title: shopNowTxt, backClr: AppColors.secondary)),
        Row(
          children: [
            codeButton(code: "dfdh45"),
            GestureDetector(
              onTap: () {
                CommonUtils().share(shareUrl: shareUrl);
              },
              child: Icon(
                Icons.share,
                color: Colors.black,
                size: Dimens.smallIcon,
              ).px(10),
            ),
          ],
        ),
      ],
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
    return Container(
      /*decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),*/
      width: MediaQuery.of(Get.context!).size.width * .9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            "What is Vine Oh?",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ).px(6),
          const ReadMoreText(
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
          ).p(6)
        ],
      ).p(6),
    ).py(6);
  }
}
