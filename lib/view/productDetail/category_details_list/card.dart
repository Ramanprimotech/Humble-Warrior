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
      this.cardText = false,
      this.imageText = true,
      this.effect = true})
      : super(key: key);
  final String? imgUrl;
  final String? title;
  final String? cardtitle;
  final String? shopUrl;
  final bool? cardText;
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: effect == true
                                  ? const LinearGradient(
                                      colors: [
                                          Colors.transparent,
                                          Colors.black45,
                                          Colors.black
                                        ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)
                                  : const LinearGradient(colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                    ]),
                            ),
                            child: imageText == true
                                ? AppText(
                                    title ?? "",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    textAlign: TextAlign.center,
                                  )
                                : SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, right: 16, left: 8, bottom: 8),
              child: Row(
                children: [
                  if (cardText == true) ...[
                    Expanded(
                        child: AppText(
                      cardtitle ?? title ?? "",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      textAlign: TextAlign.left,
                    )),
                  ],
                  if (cardText == true) ...[
                    16.swb,
                    Heart(
                      item: details!,
                      id: details!.id.toString(),
                      key: Key(index.toString()),
                    ),
                    12.swb,
                    AppIcons.share(iconColor: Colors.black),
                  ]
                ],
              ),
            ),
            if (cardText == false)
              Padding(
                padding: 8.pr,
                child: Row(
                  children: [
                    Padding(
                      padding: 8.pl,
                      child: (details?.shopUrl == "" ||
                              details?.shopUrl == "null" ||
                              details?.shopUrl == null)
                          ? 0.shb
                          : shopButton(
                              url: "${details?.shopUrl}",
                              title: "${details?.itemName!}"),
                    ),
                    !(details?.couponCode == null || details?.couponCode == "")
                        ? codeButton(
                            code: "${details?.couponCode}", context: context)
                        : 80.swb,
                    // codeButton(code: "C Code", context: context),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // controller.select.value = !controller.select.value;
                      },
                      icon: Heart(
                        item: details!,
                        id: details!.id.toString(),
                        key: Key(index.toString()),
                      ),
                    ),
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
