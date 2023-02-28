import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/donna_deals_response.dart';
import 'package:humble_warrior/modals/response/front_page_response_model.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/decorations.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/view/home_option/tab_screens/donnas_deals.dart';
import 'package:humble_warrior/view/home_option/tab_screens/front_page_deals.dart';

import '../../utils/app_text.dart';

class ItemCard extends StatelessWidget {
  final double? cardHeight;
  final double imageHeight;
  final double imageTitleHeight;
  final double buttonbarHeight;
  final Widget? buttons;
  final double radius;
  final String imageUrl;
  final String title;
  final VoidCallback? onTap;

  const ItemCard(
      {Key? key,
      this.buttons,
      this.buttonbarHeight = 50,
      this.radius = 15,
      this.imageHeight = 220,
      this.imageTitleHeight = 60,
      this.cardHeight,
      this.onTap,
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
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    height: imageTitleHeight,
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black26,
                            Colors.black
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: Get.width - 60,
                        child: AppText(
                          title,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: buttonbarHeight, child: buttons)
          ],
        ),
      ),
    );
  }
}

ItemCard donnaDealsCard(
    DonnaDealsDetails details, int index, BuildContext context) {
  return ItemCard(
    onTap: () {
      Get.toNamed(AppRoutes.dailyDealProductDetail, arguments: [details]);
    },
    radius: 10,
    buttons: donnaDealsButton(details, index, context),
    imageUrl: details.url!,
    title: details.dealName!,
  );
}

ItemCard frontPageCard(
    FrontPageDetails details, int index, BuildContext context) {
  return ItemCard(
    onTap: () {
      Get.toNamed(AppRoutes.frontPageProductDetail, arguments: [details]);
    },
    buttons: frontPageButton(details, index, context),
    imageUrl: details.url!,
    radius: 10,
    title: details.productName.toString(),
  );
}

favouritePageCard({double? height, onTap, imageUrl}){
  return InkWell(
    onTap: onTap??(){},
    child: SizedBox(
      height: height??220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CommonWidgets.networkImage(
          imageUrl: imageUrl??"",
          alignment: Alignment.center,
          width: Get.width,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}


Widget codeButton({required String code}) {
  return IconButton(
    onPressed: () async {
      CommonUtils().copyToClipboard(copyText: code);
    },
    icon: Container(
        alignment: Alignment.center,
        // width: 90,
        height: 30,
        padding: 10.ph,
        decoration: BoxDecoration(
            color: AppColors.appGreen,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)]),
        child: AppText(
          code,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        )),
  );
}

Widget shopButton({required url, required String title}) {
  return IconButton(
    onPressed: () async {
      await CommonUtils().urlLauncher(url: url, title: title);
    },
    icon: Container(
        alignment: Alignment.center,
        // width: 90,
        height: 30,
        padding: 10.ph,
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)]),
        child: const AppText(
          shopNowTxt,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        )),
  );
}

Widget shareButton({required shareUrl, Color? color = Colors.black}) {
  return IconButton(
    onPressed: () {
      CommonUtils().share(shareUrl: "$shareUrl");
    },
    icon: AppIcons.share(iconColor: color),
  );
}

Widget bookmarkButton({required shareUrl}) {
  return IconButton(
    onPressed: () {
      CommonUtils().share(shareUrl: "$shareUrl");
    },
    icon: AppIcons.bookmarks(),
  );
}
