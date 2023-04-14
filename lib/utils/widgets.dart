import 'package:humble_warrior/hw.dart';

class CatCard extends StatelessWidget {
  const CatCard({Key? key, this.imageUrl, this.onTap, this.title, this.visible, this.isCheck =  false})
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
        padding: 30.pl,
        height: 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                    height: 45,
                    child: Image.network(errorBuilder: (context, error, stackTrace) {
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
                if(isCheck == true)
                Positioned(
                  child: Visibility(
                    visible: visible ?? true,
                    child: const Icon(
                      Icons.check_circle,
                      color: AppColors.appGreen,
                    ),
                  ),
                ),
              ],
            ),
            // 4.shb,
            AppText(title ?? "",
                fontSize: 14, maxLines: 1, fontWeight: FontWeight.w600),
          ],
        ),
      ),
    );
  }
}