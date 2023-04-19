import 'package:humble_warrior/hw.dart';

class CatCard extends StatelessWidget {
  const CatCard(
      {Key? key,
      this.imageUrl,
      this.onTap,
      this.title,
      this.visible,
      this.isCheck = false})
      : super(key: key);
  final String? imageUrl;
  final onTap;
  final String? title;
  final bool? visible;
  final bool isCheck;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: 90,
        padding: 30.pl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                    height: 40,
                    child: Image.network(
                        errorBuilder: (context, error, stackTrace) {
                      return Center(
                          child: Image.asset(
                        ImagePathAssets.noImageFound,
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        // height: height,
                      ));
                    }, imageUrl ?? ""),
                  ),
                ),
                if (isCheck == true)
                  Positioned(
                    child: Visibility(
                      visible: visible ?? true,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            border: Border.all(width: 1, color: Colors.white),
                            shape: BoxShape.circle),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
              ],
            ),
            8.shb,
            AppText(title ?? "",
                fontSize: 14,
                maxLines: 2,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
