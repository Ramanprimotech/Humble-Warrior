import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/decorations.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';

class WishListCard extends StatelessWidget {
  final double? cardHeight;
  final double imageHeight;
  final double imageTitleHeight;
  final double buttonbarHeight;
  final Widget? buttons;
  final double radius;
  final String imageUrl;
  final String title;
  final String deal;
  final VoidCallback? onTap;

  const WishListCard(
      {Key? key,
      this.buttons,
      this.buttonbarHeight = 135,
      this.radius = 10,
      this.imageHeight = 220,
      this.imageTitleHeight = 60,
      this.cardHeight,
      this.onTap,
      required this.deal,
      required this.imageUrl,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        height: imageHeight + buttonbarHeight,
        decoration: CustomBoxDecorations().shadow(context: context),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                SizedBox(
                  height: imageHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(radius),
                      topLeft: Radius.circular(radius),
                    ),
                    child: CommonWidgets.networkImage(
                      imageUrl: imageUrl,
                      alignment: Alignment.topCenter,
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.only(
                        // bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(10),
                      )),
                  child: AppText(
                    deal.toUpperCase(),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Container(
              decoration:
                  CustomBoxDecorations.bottomBorderCurve(context: context),
              height: buttonbarHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: 8.pa,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          title,
                          fontSize: 16,
                          // color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        const AppText(
                          AppStrings.lorem,
                          // color: Colors.black,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: buttons!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
