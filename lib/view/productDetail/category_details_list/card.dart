import 'package:cached_network_image/cached_network_image.dart';
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
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        decoration:
            // BoxDecoration(borderRadius: BorderRadius.circular(16)),
            CustomBoxDecorations().shadow(context: context, radius: 16),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1 / .7,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      imgUrl ?? "",
                    ),
                  ),
                ),
                child: cardText != ""
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              width: double.infinity,
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
                                  fontSize: 18,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ],
                      )
                    : SizedBox(),
              ),
            ),
            // if (title != "")
            if (details?.shopUrl == "" &&
                details?.shopUrl == "null" &&
                details?.shopUrl == null &&
                (details?.couponCode == null || details?.couponCode == ""))
              Padding(
                padding: 8.pa,
                child: Row(
                  children: [
                    if (title != "")
                      Expanded(
                          child: AppText(
                        title ?? "",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        textAlign: TextAlign.left,
                      )),
                    if (details?.shopUrl == "" &&
                        details?.shopUrl == "null" &&
                        details?.shopUrl == null &&
                        (details?.couponCode == null ||
                            details?.couponCode == "")) ...[
                      8.swb,
                      Heart(
                        item: details!,
                        id: details!.id.toString(),
                        key: Key(index.toString()),
                      ),
                      8.swb,
                      AppIcons.share(iconColor: Colors.black),
                    ],
                  ],
                ),
              ),
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
                    ),
                  ),
                  8.swb,
                  shareButton(shareUrl: "shareUrl", color: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
