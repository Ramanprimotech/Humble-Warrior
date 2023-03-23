import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';

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
    ShadowTheme shadowColor = Theme.of(context).extension<ShadowTheme>()!;
    return Container(
      decoration:
          // BoxDecoration(
          //   color: shadowColor.background,
          //     borderRadius: BorderRadius.circular(16),
          //     border: Border.all(width: 2, color: Colors.black.withOpacity(.2),),),
          CustomBoxDecorations().shadow(context: context, radius: 16),
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
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: const BorderRadius.only(
                  //       topRight: Radius.circular(16),
                  //       topLeft: Radius.circular(16),
                  //     ),
                  //     image: DecorationImage(
                  //       fit: BoxFit.cover,
                  //       image: CachedNetworkImageProvider(
                  //         imgUrl ?? "",
                  //         /*errorListener: (){
                  //            ShimmerLoader(
                  //                child: AspectRatio(
                  //                  aspectRatio: 1 / .7,
                  //                  child: Container(
                  //                    decoration: const BoxDecoration(
                  //                      borderRadius: BorderRadius.only(
                  //                        topRight: Radius.circular(16),
                  //                        topLeft: Radius.circular(16),
                  //                      ),
                  //                    ),
                  //                  ),
                  //                ));
                  //         },*/
                  //       ),
                  //     ),
                  //   ),
                  //   child: cardText != ""
                  //       ? Column(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: [
                  //             Container(
                  //                 width: double.infinity,
                  //                 decoration: const BoxDecoration(
                  //                     gradient: LinearGradient(
                  //                         colors: [
                  //                       Colors.transparent,
                  //                       Colors.black54,
                  //                       Colors.black
                  //                     ],
                  //                         begin: Alignment.topCenter,
                  //                         end: Alignment.bottomCenter)),
                  //                 child: Center(
                  //                   child: AppText(
                  //                     cardText!,
                  //                     padding: 8.pa,
                  //                     color: Colors.white,
                  //                     fontWeight: FontWeight.w700,
                  //                     fontSize: 18,
                  //                     maxLines: 2,
                  //                     textAlign: TextAlign.center,
                  //                   ),
                  //                 )),
                  //           ],
                  //         )
                  //       : SizedBox(),
                  // ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: cardText != ""
                      ? Container(
                          height: 60,
                          alignment: Alignment.center,
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
                          child: Center(
                            child: AppText(
                              cardText!,
                              padding: 8.pa,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ))
                      : SizedBox(),
                )
              ],
            ),
          ),
          // if (details?.shopUrl == "" &&
          //     details?.shopUrl == "null" &&
          //     details?.shopUrl == null &&
          //     (details?.couponCode == null || details?.couponCode == ""))
          //   Padding(
          //     padding: 8.pa,
          //     child: Row(
          //       children: [
          //         if (title != "")
          //           Expanded(
          //               child: AppText(
          //             title ?? "",
          //             fontWeight: FontWeight.w600,
          //             fontSize: 16,
          //             textAlign: TextAlign.left,
          //           )),
          //         if (details?.shopUrl == "" &&
          //             details?.shopUrl == "null" &&
          //             details?.shopUrl == null &&
          //             (details?.couponCode == null ||
          //                 details?.couponCode == "")) ...[
          //           8.swb,
          //           Heart(
          //             item: details!,
          //             id: details!.id.toString(),
          //             key: Key(index.toString()),
          //           ),
          //           8.swb,
          //           AppIcons.share(iconColor: Colors.black),
          //         ],
          //       ],
          //     ),
          //   ),
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
                          url: "${details?.shopUrl}",
                          title: "${details?.itemName!}"),
                    ),
                  ],

                  !(details?.couponCode == null || details?.couponCode == "")
                      ? codeButton(
                          code: "${details?.couponCode}", context: context)
                      : 80.swb,
                  // codeButton(code: "C Code", context: context),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // controller.select.value = !controller.select.value;
                    },
                    child: Heart(
                      item: details!,
                      id: details!.id.toString(),
                      key: Key(index.toString()),
                      color: color,
                    ),
                  ),
                  8.swb,
                  shareButton(shareUrl: details!.linkUrl, color: color),
                ],
              ),
            ),
          if (!details!.shopUrl.isNotEmptyAndNotNull
          // ||
          //     (details?.couponCode == null || details?.couponCode == "")
          )
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      service.favourite(item: details!);
                    },
                    child: iconWithText(
                        title: 'Add to Wishlist',
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
                      CommonUtils()
                          .share(shareUrl: details!.linkUrl.toString());
                    },
                    child: iconWithText(
                      title: 'Share',
                      child:
                          shareButton(shareUrl: details!.linkUrl, color: color),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
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
