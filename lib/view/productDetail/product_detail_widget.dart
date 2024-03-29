import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/utils/common/html.dart';

class ProductDetailWidget {
  final AccountOptionTheme accountOptionTheme =
      Theme.of(Get.context!).extension<AccountOptionTheme>()!;

  Widget productText(context, title) {
    return Container(
      decoration: CustomBoxDecorations(context: context).shadow(),
      width: MediaQuery.of(Get.context!).size.width * .9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            "$title",
            fontWeight: FontWeight.bold,
            maxLines: 2,
            fontSize: 18,
          ),
          RichText(
            text: TextSpan(
              text: "The",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 15),
              children: <TextSpan>[
                TextSpan(
                  text: '  $title',
                  style: TextStyle(color: AppColors.primary, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ).p(6),
    ).py(10);
  }

  /// Shop/Subscribe Button
  Widget shopSubButton(
      {required String shopNowUrl,
      required String subscribeUrl,
      required String shareUrl,
      required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
            onTap: () {
              CommonUtils().urlLauncher(url: shopNowUrl);
            },
            child: button(title: shopNowTxt, backClr: AppColors.secondary)),
        Row(
          children: [
            codeButton(code: "dfdh45", context: context),
            GestureDetector(
              onTap: () {
                CommonUtils().share(shareUrl: shareUrl);
              },
              child: Icon(
                Icons.share,
                color: Colors.black,
                size: Dimens.smallIcon,
              ).px(10),
            ),
          ],
        ),
      ],
    );
  }

  Widget button({required String title, required Color backClr}) {
    return Container(
      decoration:
          BoxDecoration(color: backClr, borderRadius: BorderRadius.circular(6)),
      child: Center(
        child: AppText(
          title,
          color: AppColors.white,
        ),
      ).p(8),
    ).p(10);
  }

  /// Product Description
  Widget productDescription(
      {String? discription, String? itemName, required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width * .9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            // "What is $itemName",
            "$itemName",
            fontSize: 18,
            maxLines: 2,
            fontWeight: FontWeight.bold,
          ),
          HtmlData().htmlString(context, discription.toString()),
        ],
      ).p(6),
    ).py(6);
  }
}
