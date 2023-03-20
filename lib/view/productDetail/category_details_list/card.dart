import 'package:humble_warrior/hw.dart';

class CardView extends StatelessWidget {
  const CardView({Key? key, this.imgUrl, this.title, this.onTap, this.shopUrl})
      : super(key: key);
  final String? imgUrl;
  final String? title;
  final String? shopUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const bool tIcon = true;
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
                    image: NetworkImage(
                      imgUrl ?? "",
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [AppText("label", color: Colors.white,)],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, right: 16, left: 8, bottom: 8),
              child: Row(
                children: [
                  Expanded(
                      child: AppText(
                    title ?? "",
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    textAlign: TextAlign.center,
                  )),
                  if (tIcon == true) ...[
                    16.swb,
                    const Icon(
                      Icons.favorite_outlined,
                      color: Colors.red,
                      size: 27,
                    ),
                    12.swb,
                    AppIcons.share(iconColor: Colors.black),
                  ]
                ],
              ),
            ),
            if (tIcon == false)
              Padding(
                padding: 8.pr,
                child: Row(
                  children: [
                    shopButton(url: shopUrl, title: "Shop Now"),
                    codeButton(code: "C Code", context: context),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // controller.select.value = !controller.select.value;
                      },
                      icon: const Icon(
                        Icons.favorite_outlined,
                        color: Colors.red,
                        size: 27,
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
