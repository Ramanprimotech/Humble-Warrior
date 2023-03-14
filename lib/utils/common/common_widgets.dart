import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/shimmer/shimmer_loader.dart';

import '../decorations.dart';
import '../image_path_assets.dart';
import '../theme_extention/custom_notice_theme_extention.dart';

class CommonWidgets {
  static Widget networkImage({
    required String imageUrl,
    double? height,
    double? width,
    BoxFit? fit,
    double scale = 1,
    Alignment? alignment,
  }) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: alignment ?? Alignment.center,
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => ShimmerLoader(
        child: Container(
          color: Colors.grey,
          height: height,
          width: width,
        ),
      ),
      errorWidget: (context, url, error) => Center(
          child: Image.asset(
        ImagePathAssets.noImageFound,
        alignment: Alignment.center,
        fit: fit,
        height: height,
      )),

      // Container(
      // color: Colors.grey,
      // height: height,
      // width: width ?? Get.width,
      // child: const Icon(Icons.error)),
    );
  }

  // static Widget noData({required Function update}) {
  //   return RefreshIndicator(
  //     onRefresh: () async {
  //       update();
  //       return Future.value(0);
  //     },
  //     child: ListView(
  //       children: [
  //         Container(
  //           height: Get.height - 250,
  //           alignment: Alignment.center,
  //           child: AppText(
  //             noDataFoundTxt,
  //             fontSize: 24,
  //             fontWeight: FontWeight.w700,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  static Widget noData(
      {required Function update,
      required BuildContext context,
      required Function() onTap}) {
    return CommonWidgets.errorAPI(
        buttonTitle: retryTxt,
        errorText: noDataFoundTxt.toString(),
        context: context,
        onPress: onTap);
  }

  static Widget loading() {
    return const Center(
      child: AppText(
        loadingDealsTxt,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static Widget errorAPI({
    required String errorText,
    required BuildContext context,
    required Function() onPress,
    required String buttonTitle,
    double? height,
  }) {
    final DialogueThemeExtention dialogueThemeExtention =
        Theme.of(context).extension<DialogueThemeExtention>()!;
    return Center(
      child: Container(
        margin: 20.pa,
        height: height ?? 180,
        width: Get.width,
        padding: 20.pa,
        decoration: CustomBoxDecorations().shadow(context: context),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          AppText(errorText,
              maxLines: 4,
              color: dialogueThemeExtention.textColor,
              fontSize: 16),
          20.sh,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              // fixedSize: const Size(, 35),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: dialogueThemeExtention.buttonColor,
            ),
            onPressed: onPress,
            child: AppText(buttonTitle,
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }

  static Widget titleBar(context,
      {Color? color,
      title,
      Widget? widget,
      icon = false,
      double? fontSize,
      Function()? onPress,
      backIcon = true}) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 16, right: 16),

      // padding: const EdgeInsets.only(right: 20),
      width: MediaQuery.of(Get.context!).size.width,
      decoration: CustomBoxDecorations().shadow(context: context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          backIcon ? AppIcons.IosBackIcon(onPress: onPress) : 40.sw,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                title,
                fontSize: fontSize ?? 16,
                color: color,
                fontWeight: FontWeight.bold,
              ),
              5.sw,
              icon
                  ? Padding(
                      padding: 3.pb,
                      child: AppIcons.heart(
                        size: 22,
                        iconColor: Colors.red,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          widget ?? 40.sw
        ],
      ),
    );
  }
}
