import 'package:dotted_border/dotted_border.dart';
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/utils/common/photo_viewer.dart';

class ItemCard extends StatelessWidget {
  final double? cardHeight;
  final double imageHeight;
  final double imageTitleHeight;
  final double buttonbarHeight;
  final Widget? buttons;
  final double radius;
  final String imageUrl;
  final String title;
  final bool effect;
  final VoidCallback? onTap;

  const ItemCard(
      {Key? key,
      this.buttons,
      this.buttonbarHeight = 50,
      this.radius = 15,
      this.imageHeight = 160,
      this.imageTitleHeight = 60,
      this.cardHeight,
      this.onTap,
      this.effect = true,
      required this.imageUrl,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        // height: imageHeight + buttonbarHeight,
        height: Get.width - 40,
        decoration: CustomBoxDecorations(context: context).shadow(),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  // height: imageHeight,
                  height: Get.width - buttonbarHeight - 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(radius),
                      topLeft: Radius.circular(radius),
                    ),
                    child: CommonWidgets.networkImage(
                      imageUrl: imageUrl,
                      alignment: Alignment.center,
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  child: Container(
                    width: Get.width,
                    height: imageTitleHeight,
                    alignment: Alignment.centerLeft,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: Get.width - 60,
                        child: AppText(
                          title,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white,
                          textAlign: TextAlign.center,
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

Widget codeButton({required String code, required BuildContext context}) {
  return GestureDetector(
    onTap: () async {
      // await CardView.checkLoggedIn(() {
        CommonUtils().copyToClipboard(copyText: code, context: context);
      // }, context);
    },
    child: Container(
        alignment: Alignment.center,
        padding: 1.pa,
        decoration: BoxDecoration(
            color: AppColors.appGreen,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)]),
        child: DottedBorder(
          color: Colors.green,
          borderType: BorderType.RRect,
          strokeWidth: 2,
          dashPattern: const [3, 3],
          radius: const Radius.circular(20),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Row(
            children: [
              const Icon(
                Icons.cut,
                size: 17,
                color: AppColors.black,
              ),
              2.swb,
              AppText(
                code,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ],
          ),
        )),
  );
}

Widget shopButton(
    {required url, required String title, required BuildContext context}) {
  return GestureDetector(
    onTap: () async {
      // await CardView.checkLoggedIn(() {
        CommonUtils().urlLauncher(url: url, title: title);
      // }, context);
    },
    child: Container(
        alignment: Alignment.center,
        // width: 90,
        height: 32,
        padding: 10.ph,
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)]),
        child: const AppText(
          shopNowTxt,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        )),
  );
}

Widget shareButton(
    {required shareUrl,
    Color? color = Colors.black,
    required BuildContext context}) {
  return GestureDetector(
    onTap: () async {
      await CardView.checkLoggedIn(() {
        CommonUtils().share(shareUrl: shareUrl);
      }, context);
    },
    child: AppIcons.share(iconColor: color),
  );
}

Widget bookmarkButton({required shareUrl}) {
  return IconButton(
    onPressed: () {
      CommonUtils().share(shareUrl: "$shareUrl");
      // CommonUtils().share(shareUrl: "https://humblewarrior.com/");
    },
    icon: AppIcons.bookmarks(),
  );
}

ItemCard categoryListCard(
    ProductDetailsResponse details, int index, BuildContext context,
    {bool? categoryCard = false, bool isDetails = false}) {
  return ItemCard(
    onTap: () {
      if (isDetails) {
        if (details.url != "" || details.url != null) {
          Get.to(CustomPhotoViewer(url: details.url!));
        }
      } else {
        Get.toNamed(AppRoutes.categoryItemDetail, arguments: [details]);
      }
    },
    radius: 10,
    buttons:
        donnaDealsButton(details, index, context, categoryCard: categoryCard),
    imageUrl: details.url!,
    title: "",
    effect: false,
    buttonbarHeight: categoryCard == true ? 85 : 50,
  );
}
