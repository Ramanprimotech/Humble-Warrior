import 'package:humble_warrior/hw.dart';

class CommonWidgets {
  static Widget networkImage(
      {required String imageUrl,
      double? height,
      double? width,
      BoxFit? fit,
      double scale = 1,
      Alignment? alignment,
      EdgeInsets? margin}) {
    return CachedNetworkImage(
      height: height,
      width: width,
      alignment: Alignment.topCenter,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        margin: margin ?? 0.pa,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: alignment ?? Alignment.topCenter,
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) =>
          CustomShimmer(height: height, width: width),
      errorWidget: (context, url, error) => Center(
          child: Image.asset(
        ImagePathAssets.noImageFound,
        alignment: Alignment.center,
        fit: fit,
        height: height,
      )),
    );
  }

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
        fontSize: 18,
        fontWeight: FontWeight.w600,
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
        decoration: CustomBoxDecorations(context: context).shadow(),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          AppText(errorText,
              maxLines: 4,
              color: dialogueThemeExtention.textColor,
              fontSize: 16),
          20.shb,
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
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),

      // padding: const EdgeInsets.only(right: 20),
      width: MediaQuery.of(Get.context!).size.width,
      decoration: CustomBoxDecorations(context: context).shadow(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            backIcon
                  ? SizedBox(child: AppIcons.IosBackIcon(onPress: onPress))
                  : 40.swb,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                title,
                fontSize: fontSize ?? 16,
                color: color,
                fontWeight: FontWeight.bold,
              ),
              5.swb,
              icon
                  ? Padding(
                      padding: 3.pb,
                      child: AppIcons.heart(
                        size: 22,
                        iconColor: Colors.red,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          widget ?? 40.swb
        ],
      ),
    );
  }
}
