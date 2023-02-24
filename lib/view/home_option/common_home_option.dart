import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/decorations.dart';
import 'package:humble_warrior/utils/extensions.dart';

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
        decoration: CustomBoxDecorations()
            .shadow(context: context, color: Colors.white),
        // BoxDecoration(
        //     color: Theme.of(context).scaffoldBackgroundColor,
        //     borderRadius: BorderRadius.circular(radius),
        //     boxShadow: const [
        //       BoxShadow(blurRadius: 4, spreadRadius: 0, color: Colors.black38)
        //     ]),
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
                      // borderRadius: BorderRadius.only(
                      //     bottomRight: Radius.circular(15),
                      //     bottomLeft: Radius.circular(15)),
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
                      padding: 8.pa,
                      child: AppText(
                        title,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.white,
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

Widget codeButton({required String code}) {
  return IconButton(
    onPressed: ()async{
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

Widget shopButton({required url}) {
  return IconButton(
    onPressed: ()async{
      await CommonUtils().urlLauncher(url: url);
    },icon: Container(
        alignment: Alignment.center,
        // width: 90,
        height: 30,
        padding:10.ph,
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)]),
        child: AppText(
          shopNowTxt,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        )),
  );
}

Widget shareButton({required shareUrl}) {
  return IconButton(
    onPressed: () {
      CommonUtils().share(shareUrl: "$shareUrl");
    },
    icon: AppIcons.share(),

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
