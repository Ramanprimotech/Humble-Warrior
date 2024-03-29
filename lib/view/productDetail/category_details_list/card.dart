import 'package:humble_warrior/hw.dart';

class CardView extends StatelessWidget {
  const CardView(
      {Key? key,
      this.imgUrl,
      this.title,
      this.onTap,
      this.shopUrl,
      this.cardtitle,
      this.index,
      required this.details,
      this.cardText = "",
      this.imageText = true,
      this.effect = true})
      : super(key: key);
  final String? imgUrl;
  final String? title;
  final String? cardtitle;
  final String? shopUrl;
  final String? cardText;
  final bool? imageText;
  final bool? effect;
  final int? index;
  final void Function()? onTap;
  final ProductDetailsResponse? details;

  @override
  Widget build(BuildContext context) {
    HiveService service = Get.find<HiveService>();
    Color color = Theme.of(context).textTheme.displayMedium!.color!;
    return Container(
      decoration: CustomBoxDecorations(context: context).shadow(radius: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap ?? () {},
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1 / .7,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                    child: CommonWidgets.networkImage(
                        imageUrl: imgUrl ?? "", fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: cardText != ""
                      ? Container(
                          alignment: Alignment.bottomCenter,
                          height: 70,
                          width: Get.width,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Colors.transparent,
                                Colors.black54,
                                Colors.black
                              ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                          child: AppText(
                            cardText!,
                            padding: 8.pa,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ))
                      : const SizedBox(),
                )
              ],
            ),
          ),
          if ((details?.shopUrl != "" &&
                  details?.shopUrl != "null" &&
                  details?.shopUrl != null) ||
              !(details?.couponCode == null || details?.couponCode == ""))
            Padding(
              padding: 8.pa,
              child: Row(
                children: [
                  if (details?.shopUrl != "" &&
                      details?.shopUrl != "null" &&
                      details?.shopUrl != null) ...[
                    Padding(
                      padding: 8.pr,
                      child: shopButton(
                          context: context,
                          url: "${details?.shopUrl}",
                          title: "${details?.itemName!}"),
                    ),
                  ],
                  !(details?.couponCode == null || details?.couponCode == "")
                      ? codeButton(
                          code: "${details?.couponCode}", context: context)
                      : 80.swb,
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Heart(
                      item: details!,
                      id: details!.id.toString(),
                      key: Key(index.toString()),
                      color: color,
                    ),
                  ),
                  8.swb,
                  shareButton(
                      shareUrl: details!.linkUrl,
                      color: color,
                      context: context),
                ],
              ),
            ),
          if (!details!.shopUrl.isNotEmptyAndNotNull)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      await checkLoggedIn(() async {
                        await service.favourite(item: details!);
                      }, context);
                    },
                    child: iconWithText(
                        title: addToWishlistTxt,
                        child: Heart(
                          item: details!,
                          id: details!.id.toString(),
                          key: Key(index.toString()),
                          color: color,
                        )),
                  ),
                ),
                Container(
                    width: 2, height: 50, color: Colors.black.withOpacity(.2)),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      checkLoggedIn(() {
                        CommonUtils()
                            .share(shareUrl: details!.linkUrl.toString());
                      }, context);
                    },
                    child: iconWithText(
                      title: shareTxt,
                      child: shareButton(
                          shareUrl: details!.linkUrl,
                          color: color,
                          context: context),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  static Future<void> checkLoggedIn(
      Function checkItem, BuildContext context) async {
    bool value = await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
    if (value) {
      checkItem();
    } else {
      if (context.mounted) {
        DialogHelper.showConfirmationDialog(
            message: accessingMsgTxt,
            actionLabel: login,
            action: () {
              Get.toNamed(AppRoutes.loginPage);
            },
            context: context);
      }
    }
  }
}

Widget iconWithText({required String title, required Widget child}) {
  return Padding(
    padding: 0.pv,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        child,
        8.swb,
        AppText(
          title,
          fontSize: 16,
        ),
      ],
    ),
  );
}
